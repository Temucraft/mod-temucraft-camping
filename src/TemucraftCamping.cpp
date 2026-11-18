/*
 * mod-temucraft-camping: camping.
 *
 * Any cooking fire is a campfire (Basic Campfire, or a fire in town). Camp items, crafted by professions (see data/sql),
 * (601670-601675) set a camp feature (gameobjects 601690-601695) down next to the campfire you stand at, for Temucraft.Camping.FeatureDuration seconds; a fire
 * holds up to Temucraft.Camping.MaxFeatures of them, from anyone. Sit near the fire (or in the Camp Chair) for a
 * minute and you get every feature's benefit, renewed each minute you stay (flat values scale with your level, 60 = as listed):
 *   Camp Tent         rested experience topped up to 5% of your level
 *   Sharpening Wheel  Sharpened: +34 Strength, 30 min
 *   Incense Candle    Incense: +25 Intellect, 30 min
 *   Lodestone         Lodestone: +90 attack power, 30 min
 *   Mana Well         Mana Well: 29 mana every 5 sec, 30 min
 *   Camp Chair        Comfortable: +2% critical strike chance, 30 min (and something to sit on)
 *   Enchanted Drum    Enchanted Melody: +308 armor, +13 all stats, +22 all resistances, 30 min
 *   Meditation Cushion Meditative: +32 Spirit, 30 min
 *   First Aid Kit     Patched Up: +30 Stamina, 30 min
 *   Fish Bowl         Soothing Waters: +8% all stats, 30 min
 *   Vendor Bot        a vendor that buys anything and repairs, for the feature's time (one per campfire, not counted
 *                     against the feature limit)
 *
 * Tiers: every camp item also comes as Sturdy (602020-602029, skill 140, 50% stronger) and Masterwork
 * (602030-602039, skill 300, twice as strong); a stronger one replaces a weaker one of the same kind at the fire.
 * Campfires: a Sturdy Campfire (602040, Cooking 140) holds 5 camp features, a Grand Campfire (602041, Cooking 300) 10;
 * other fires hold Temucraft.Camping.MaxFeatures. Growers: Herb Planter (Alchemy) and Ore Extractor (Mining), three
 * tiers each (602042-602047), take a slot at the fire and can be harvested after Temucraft.Camping.GrowerTime seconds.
 */

#include "Chat.h"
#include "TemucraftModuleText.h"
#include "Config.h"
#include "GameObject.h"
#include "Item.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <list>
#include <mutex>
#include <unordered_map>

namespace
{
    constexpr uint32 FOCUS_COOKING_FIRE = 4;

    struct Feature
    {
        uint32 item;
        uint32 object;
        uint32 spell; // 0: the tent (rested experience)
        char const* name;
    };

    std::array<Feature, 10> const FEATURES = { {
        { 601670, 601690, 0,     "Camp Tent" },
        { 601671, 601691, 95021, "Sharpening Wheel" },
        { 601672, 601692, 95022, "Incense Candle" },
        { 601673, 601693, 95023, "Lodestone" },
        { 601674, 601694, 95024, "Mana Well" },
        { 601675, 601695, 95025, "Camp Chair" },
        { 601676, 601696, 95026, "Enchanted Drum" },
        { 601677, 601697, 95027, "Meditation Cushion" },
        { 601678, 601698, 95028, "First Aid Kit" },
        { 601679, 601699, 95029, "Fish Bowl" },
    } };

    // The engineer's Vendor Bot: a creature (buys anything, repairs) instead of an object, one per campfire
    constexpr uint32 VENDOR_BOT_ITEM = 601680;
    constexpr uint32 VENDOR_BOT_CREATURE = 601699;

    constexpr uint32 TIER2_ITEM = 602020; // + feature index
    constexpr uint32 TIER3_ITEM = 602030;
    constexpr uint32 STURDY_CAMPFIRE_ITEM = 602040;
    constexpr uint32 GRAND_CAMPFIRE_ITEM = 602041;
    constexpr uint32 STURDY_CAMPFIRE_OBJECT = 602060;
    constexpr uint32 GRAND_CAMPFIRE_OBJECT = 602061;
    constexpr uint32 GROWER_ITEM = 602042;   // 6 of them: herb planter x3, ore extractor x3
    constexpr uint32 GROWER_OBJECT = 602062;
    constexpr uint32 GROWER_COUNT = 6;

    struct CampSettings
    {
        bool enable = true;
        uint32 maxFeatures = 3;
        uint32 featureDuration = 1800;
        uint32 growerTime = 600;
    } camp;

    std::mutex sLock;
    std::unordered_map<ObjectGuid, uint8> sTier; // camp feature object -> tier (1-3), under sLock

    uint8 TierOf(GameObject* go)
    {
        std::lock_guard lock(sLock);
        auto itr = sTier.find(go->GetGUID());
        return itr == sTier.end() ? 1 : itr->second;
    }

    uint32 Capacity(GameObject* fire)
    {
        if (fire->GetEntry() == GRAND_CAMPFIRE_OBJECT)
            return std::max(camp.maxFeatures, 10u);
        if (fire->GetEntry() == STURDY_CAMPFIRE_OBJECT)
            return std::max(camp.maxFeatures, 5u);
        return camp.maxFeatures;
    }

    std::unordered_map<ObjectGuid, std::pair<uint32, uint32>> sResting; // player -> (check timer, ms resting)

    GameObject* NearbyCampfire(WorldObject* origin, float range)
    {
        GameObject* go = origin->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_SPELL_FOCUS, range);
        return go && go->isSpawned() && go->GetGOInfo()->spellFocus.focusId == FOCUS_COOKING_FIRE ? go : nullptr;
    }

    // The camp features set down around a campfire
    std::vector<GameObject*> FeaturesAt(GameObject* fire, float range)
    {
        std::vector<GameObject*> found;
        for (Feature const& feature : FEATURES)
        {
            std::list<GameObject*> objects;
            fire->GetGameObjectListWithEntryInGrid(objects, feature.object, range);
            for (GameObject* go : objects)
                if (go->isSpawned())
                    found.push_back(go);
        }
        for (uint32 i = 0; i < GROWER_COUNT; ++i)
        {
            std::list<GameObject*> objects;
            fire->GetGameObjectListWithEntryInGrid(objects, GROWER_OBJECT + i, range);
            for (GameObject* go : objects)
                if (go->isSpawned())
                    found.push_back(go);
        }
        return found;
    }

    Feature const* FeatureByItem(uint32 item, uint8& tier)
    {
        for (size_t i = 0; i < FEATURES.size(); ++i)
        {
            tier = FEATURES[i].item == item ? 1 : item == TIER2_ITEM + i ? 2 : item == TIER3_ITEM + i ? 3 : 0;
            if (tier)
                return &FEATURES[i];
        }
        return nullptr;
    }

    Feature const* FeatureByObject(uint32 object)
    {
        for (Feature const& feature : FEATURES)
            if (feature.object == object)
                return &feature;
        return nullptr;
    }

    void Tell(Player* player, std::string const& text)
    {
        ChatHandler(player->GetSession()).PSendSysMessage(TemucraftModuleText("mod-temucraft-camping", player->GetSession(), 1, "|cffffcc00{}|r"), text);
    }

    // A camp buff doesn't stack with the class buff it copies (by first rank of the class spell)
    std::unordered_map<uint32, std::vector<uint32>> const CLASS_BUFFS = {
        { 95021, { 8076 } },                                // Sharpened: Strength of Earth
        { 95022, { 1459, 23028, 61024, 61316 } },           // Incense: Arcane Intellect / Brilliance, Dalaran
        { 95023, { 19740, 25782 } },                        // Lodestone: Blessing of Might
        { 95024, { 19742, 25894 } },                        // Mana Well: Blessing of Wisdom
        { 95025, { 24907 } },                               // Comfortable: Moonkin Aura
        { 95026, { 1126, 21849 } },                         // Enchanted Melody: Mark / Gift of the Wild
        { 95027, { 14752, 27681 } },                        // Meditative: Divine Spirit, Prayer of Spirit
        { 95028, { 1243, 21562 } },                         // Patched Up: Power Word / Prayer of Fortitude
        { 95029, { 20217, 25898 } },                        // Soothing Waters: Blessing of Kings
    };

    bool HasClassBuff(Player* player, uint32 campSpell)
    {
        auto itr = CLASS_BUFFS.find(campSpell);
        if (itr == CLASS_BUFFS.end())
            return false;
        for (auto const& [id, application] : player->GetAppliedAuras())
        {
            uint32 first = sSpellMgr->GetFirstSpellInChain(id);
            if (std::find(itr->second.begin(), itr->second.end(), first) != itr->second.end())
                return true;
        }
        return false;
    }

    void Benefit(Player* player, GameObject* fire)
    {
        for (GameObject* go : FeaturesAt(fire, 8.0f))
        {
            Feature const* feature = FeatureByObject(go->GetEntry());
            if (!feature)
                continue;
            if (!feature->spell)
            {
                // The tent: rested experience up to 5% of the level, if lower
                float target = player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP) * 0.05f * (1.0f + 0.5f * (TierOf(go) - 1));
                if (player->GetRestBonus() < target)
                    player->SetRestBonus(target);
                continue;
            }
            if (HasClassBuff(player, feature->spell))
                continue;
            Aura* aura = player->GetAura(feature->spell);
            if (aura)
                aura->RefreshDuration();
            else
                aura = player->AddAura(feature->spell, player);
            // The values are made for level 60: they grow and shrink with the player's level
            // (a quarter at most below, a third more at 80). Percent buffs (Fish Bowl, Camp Chair) stay as they are.
            // Sturdy is 50% stronger, Masterwork twice as strong.
            if (aura)
            {
                float scale = 1.0f + 0.5f * (TierOf(go) - 1);
                if (feature->spell != 95025 && feature->spell != 95029)
                    scale *= std::max(0.25f, float(player->GetLevel()) / 60.0f);
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    if (AuraEffect* effect = aura->GetEffect(i))
                        effect->ChangeAmount(int32(effect->GetBaseAmount() * scale));
            }
        }
    }
}

class item_temucraft_camp_feature : public ItemScript
{
public:
    item_temucraft_camp_feature() : ItemScript("item_temucraft_camp_feature") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        uint8 tier = 0;
        Feature const* feature = FeatureByItem(item->GetEntry(), tier);
        uint32 entry = item->GetEntry();
        bool vendorBot = entry == VENDOR_BOT_ITEM;
        bool campfireKit = entry == STURDY_CAMPFIRE_ITEM || entry == GRAND_CAMPFIRE_ITEM;
        bool grower = entry >= GROWER_ITEM && entry < GROWER_ITEM + GROWER_COUNT;
        if (!camp.enable || (!feature && !vendorBot && !campfireKit && !grower))
            return true;
        if (player->IsInCombat())
        {
            Tell(player, "Not during a fight.");
            return true;
        }
        if (campfireKit)
        {
            if (NearbyCampfire(player, 6.0f))
            {
                Tell(player, "There's a campfire right here already.");
                return true;
            }
            float angle = player->GetOrientation();
            float x = player->GetPositionX() + std::cos(angle) * 2.0f;
            float y = player->GetPositionY() + std::sin(angle) * 2.0f;
            float z = player->GetMap()->GetHeight(player->GetPhaseMask(), x, y, player->GetPositionZ() + 2.0f);
            if (z <= INVALID_HEIGHT)
                z = player->GetPositionZ();
            uint32 object = entry == GRAND_CAMPFIRE_ITEM ? GRAND_CAMPFIRE_OBJECT : STURDY_CAMPFIRE_OBJECT;
            if (!player->SummonGameObject(object, x, y, z, angle, 0.0f, 0.0f, std::sin(angle / 2), std::cos(angle / 2),
                camp.featureDuration, true, GO_SUMMON_TIMED_DESPAWN))
            {
                Tell(player, "There's no room for it here.");
                return true;
            }
            player->DestroyItemCount(entry, 1, true);
            Tell(player, Acore::StringFormat("You build a campfire that holds up to {} camp features.",
                object == GRAND_CAMPFIRE_OBJECT ? std::max(camp.maxFeatures, 10u) : std::max(camp.maxFeatures, 5u)));
            return true;
        }
        GameObject* fire = NearbyCampfire(player, 5.0f);
        if (!fire)
        {
            Tell(player, "Stand by a campfire to set this up (Basic Campfire, from Cooking, or any cooking fire).");
            return true;
        }
        if (vendorBot)
        {
            if (fire->FindNearestCreature(VENDOR_BOT_CREATURE, 8.0f))
            {
                Tell(player, "This campfire already has a Vendor Bot.");
                return true;
            }
            float angle = fire->GetAbsoluteAngle(player) - 1.6f;
            Position pos(fire->GetPositionX() + std::cos(angle) * 3.0f, fire->GetPositionY() + std::sin(angle) * 3.0f,
                fire->GetPositionZ(), angle + float(M_PI));
            pos.m_positionZ = fire->GetMap()->GetHeight(fire->GetPhaseMask(), pos.GetPositionX(), pos.GetPositionY(),
                fire->GetPositionZ() + 2.0f);
            if (pos.GetPositionZ() <= INVALID_HEIGHT)
                pos.m_positionZ = fire->GetPositionZ();
            if (!fire->SummonCreature(VENDOR_BOT_CREATURE, pos, TEMPSUMMON_TIMED_DESPAWN, camp.featureDuration * IN_MILLISECONDS))
            {
                Tell(player, "There's no room for it here.");
                return true;
            }
            player->DestroyItemCount(item->GetEntry(), 1, true);
            Tell(player, "Your Vendor Bot whirs to life by the campfire: it buys anything and mends gear.");
            return true;
        }
        std::vector<GameObject*> present = FeaturesAt(fire, 4.0f);
        uint32 object = grower ? GROWER_OBJECT + (entry - GROWER_ITEM) : feature->object;
        GameObject* replaced = nullptr;
        for (GameObject* go : present)
        {
            bool sameKind = grower ? (go->GetEntry() >= GROWER_OBJECT && go->GetEntry() < GROWER_OBJECT + GROWER_COUNT &&
                (go->GetEntry() - GROWER_OBJECT) / 3 == (object - GROWER_OBJECT) / 3) : go->GetEntry() == object;
            if (!sameKind)
                continue;
            if (grower || TierOf(go) >= tier)
            {
                Tell(player, Acore::StringFormat("This campfire already has a {}.", go->GetGOInfo()->name));
                return true;
            }
            replaced = go; // a stronger one takes the weaker one's place
        }
        if (!replaced && present.size() >= Capacity(fire))
        {
            Tell(player, Acore::StringFormat("This campfire already has {} camp features.", Capacity(fire)));
            return true;
        }
        if (replaced)
        {
            {
                std::lock_guard lock(sLock);
                sTier.erase(replaced->GetGUID());
            }
            replaced->DespawnOrUnsummon();
            std::erase(present, replaced);
        }
        // Around the fire, in the direction of the player, spread out by how many features are there already
        float angle = fire->GetAbsoluteAngle(player) + float(present.size()) * 1.2f;
        float x = fire->GetPositionX() + std::cos(angle) * 2.5f;
        float y = fire->GetPositionY() + std::sin(angle) * 2.5f;
        float z = fire->GetMap()->GetHeight(fire->GetPhaseMask(), x, y, fire->GetPositionZ() + 2.0f);
        if (z <= INVALID_HEIGHT)
            z = fire->GetPositionZ();
        float facing = angle + float(M_PI); // looking at the fire
        GameObject* placed = player->SummonGameObject(object, x, y, z, facing, 0.0f, 0.0f, std::sin(facing / 2),
            std::cos(facing / 2), camp.featureDuration, true, GO_SUMMON_TIMED_DESPAWN);
        if (!placed)
        {
            Tell(player, "There's no room for it here.");
            return true;
        }
        player->DestroyItemCount(entry, 1, true);
        if (grower)
        {
            // growing: can't be opened until the time is up
            placed->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            placed->m_Events.AddEventAtOffset([placed]() { placed->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE); },
                Seconds(camp.growerTime));
            Tell(player, Acore::StringFormat("You set up a {} by the campfire. It's ready to harvest in {} minutes.",
                placed->GetGOInfo()->name, std::max(1u, camp.growerTime / 60)));
            return true;
        }
        if (tier > 1)
        {
            std::lock_guard lock(sLock);
            sTier[placed->GetGUID()] = tier;
        }
        Tell(player, Acore::StringFormat("You set up a {} by the campfire. Sit nearby for a minute to feel it.",
            placed->GetGOInfo()->name));
        return true;
    }
};

class TemucraftCamping_Player : public PlayerScript
{
public:
    TemucraftCamping_Player() : PlayerScript("TemucraftCamping_Player", { PLAYERHOOK_ON_UPDATE, PLAYERHOOK_ON_LOGOUT }) { }

    void OnPlayerLogout(Player* player) override
    {
        std::lock_guard lock(sLock);
        sResting.erase(player->GetGUID());
    }

    void OnPlayerUpdate(Player* player, uint32 diff) override
    {
        if (!camp.enable)
            return;
        uint32 rested;
        {
            std::lock_guard lock(sLock);
            auto& [timer, resting] = sResting[player->GetGUID()];
            if (timer > diff)
            {
                timer -= diff;
                return;
            }
            timer = 5000;
            rested = resting;
        }

        GameObject* fire = player->IsSitState() && !player->IsInCombat() ? NearbyCampfire(player, 8.0f) : nullptr;
        if (!fire || FeaturesAt(fire, 8.0f).empty())
        {
            std::lock_guard lock(sLock);
            sResting[player->GetGUID()].second = 0;
            return;
        }
        rested += 5000;
        if (rested >= 60000)
        {
            Benefit(player, fire);
            rested = 0; // again after another minute
        }
        std::lock_guard lock(sLock);
        sResting[player->GetGUID()].second = rested;
    }
};

class TemucraftCamping_World : public WorldScript
{
public:
    TemucraftCamping_World() : WorldScript("TemucraftCamping_World", { WORLDHOOK_ON_AFTER_CONFIG_LOAD }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        camp.enable = sConfigMgr->GetOption<bool>("Temucraft.Camping.Enable", true);
        camp.maxFeatures = sConfigMgr->GetOption<uint32>("Temucraft.Camping.MaxFeatures", 3);
        camp.featureDuration = sConfigMgr->GetOption<uint32>("Temucraft.Camping.FeatureDuration", 1800);
        camp.growerTime = sConfigMgr->GetOption<uint32>("Temucraft.Camping.GrowerTime", 600);
    }
};

void AddTemucraftCampingScripts()
{
    new item_temucraft_camp_feature();
    new TemucraftCamping_Player();
    new TemucraftCamping_World();
}
