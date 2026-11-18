# mod-temucraft-camping

Camp features crafted by professions, set down by a campfire; sit nearby for a minute for their benefits, renewed each minute.

- 10 features: Camp Tent (rested experience), Sharpening Wheel, Incense Candle, Lodestone, Mana Well, Camp Chair, Enchanted Drum, Meditation Cushion, First Aid Kit, Fish Bowl; plus the Vendor Bot (buys anything, repairs).
- Three tiers: plain (skill 20), Sturdy (skill 140, 50% stronger), Masterwork (skill 300, twice as strong). A stronger one replaces a weaker one at the fire.
- Campfires: any cooking fire holds 3 features (config); a Sturdy Campfire (Cooking 140) holds 5, a Grand Campfire (Cooking 300) 10.
- Growers: Herb Planter (Alchemy) and Ore Extractor (Mining), three tiers, harvestable after 10 minutes.
- A camp buff doesn't stack with the class buff it copies (Arcane Intellect, Blessing of Might, ...).

## Install

1. Put this folder in `modules/` of your AzerothCore source, re-run CMake and build.
2. The SQL in `data/sql/` is applied by the worldserver on its next start (AzerothCore's module updater). Every file deletes its own rows before inserting them, so running one again is safe.
   Copy `conf/mod-temucraft-camping.conf.dist` to your `configs/modules/` as `mod-temucraft-camping.conf` to change its settings.
3. **Client.** `client/patch-K.MPQ/` is a patch folder, not a packed MPQ: pack it yourself (for example with Ladik's MPQ Editor: new MPQ, add the folder contents keeping the `DBFilesClient\` path) and put the `.MPQ` in the game's `Data/` folder. Each DBC in it is the stock 3.3.5a (12340) file plus only this module's rows.
   **Using more than one Temucraft module, or other DBC changes?** Two patches that both carry `Spell.dbc` overwrite each other (the later letter wins). Use the all-in-one patch from the Temucraft configuration repo (`client/patch-5.MPQ/`, every Temucraft change merged), or merge the rows yourself. The server side never conflicts: it reads this module's rows from the `*_dbc` tables in `data/sql/`.

## What it adds, and where

| Database | Table | IDs |
|---|---|---|
| world | `item_template` | 601670-601680, 602020-602047 |
| world | `gameobject_template` | 601690-601699, 602060-602067 |
| world | `gameobject_loot_template` | 602062-602067 (growers) |
| world | `creature_template`, `creature_template_model` | 601699 (Vendor Bot) |
| world | `trainer_spell` | 95030-95040, 95280-95307 at every trainer of the profession |
| world | `spell_dbc` | 95021-95040 (buffs and recipes), 95280-95307 (recipes) |
| world | `skilllineability_dbc` | 31787-31797, 31807-31834 |
| client | `Spell.dbc`, `SkillLineAbility.dbc` | the same rows |

## Works with other modules

- Recipes use existing reagents only.
- Another module using SkillLineAbility IDs 31787-31834 or spells 95021-95040 / 95280-95307 clashes.

## Independence

This module doesn't need any other module, nor any other Temucraft module. 

## Customising IDs

The entries above are a block reserved for this module. Item, object and spell IDs are also constants at the top of `src/TemucraftCamping.cpp` (and the spells in the client DBCs): change all of them together.

## Texts and translations

The 1 player-facing texts (chat messages, gossip options) are in the `module_string` table under the module name
`mod-temucraft-camping`, so they can be changed without rebuilding. Translations go in `module_string_locale` with the same
module and id plus the locale (`deDE`, `esES`, `frFR`, ...). If a row is missing the English text in the code is used.

Part of the Temucraft modules for AzerothCore 3.3.5a.
