-- mod-temucraft-camping: camp features (items 601670-601675 set down gameobjects 601690-601695 by a campfire). Re-runnable.
SET @DummySpell := 18282;
DELETE FROM `item_template` WHERE `entry` BETWEEN 601670 AND 601680;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `ItemLevel`, `RequiredLevel`, `maxcount`, `stackable`,
    `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellcooldown_1`, `bonding`, `description`, `Material`, `ScriptName`,
    `VerifiedBuild`) VALUES
(601670, 0, 8, -1, 'Camp Tent',        3568, 1, 1, 20000, 5000, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there tops your rested experience up to 5% of your level.', -1, 'item_temucraft_camp_feature', 0),
(601671, 0, 8, -1, 'Sharpening Wheel', 7450, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +34 Strength for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601672, 0, 8, -1, 'Incense Candle',   7451, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +25 Intellect for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601673, 0, 8, -1, 'Lodestone',        7452, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +90 attack power for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601674, 0, 8, -1, 'Mana Well',        7718, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there restores 29 mana every 5 sec for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601675, 0, 8, -1, 'Camp Chair',       9636, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +2% critical strike chance for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601676, 0, 8, -1, 'Enchanted Drum',     7451, 2, 1, 15000, 3750, 0, 25, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +308 armor, +13 all stats and +22 all resistances for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601677, 0, 8, -1, 'Meditation Cushion', 9636, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +32 Spirit for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601678, 0, 8, -1, 'First Aid Kit',      7718, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +30 Stamina for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601679, 0, 8, -1, 'Fish Bowl',          7452, 2, 1, 15000, 3750, 0, 25, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: resting there grants +8% all stats for 30 min.', -1, 'item_temucraft_camp_feature', 0),
(601680, 0, 8, -1, 'Vendor Bot',         7450, 2, 1, 15000, 3750, 0, 25, 5, 0, 5, @DummySpell, 0, 0, -1, 0,
    'Set it up by a campfire: a vendor that buys anything and mends gear, for 30 min.', -1, 'item_temucraft_camp_feature', 0);

DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 601690 AND 601699;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`,
    `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`,
    `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`,
    `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(601690, 5, 2352, 'Camp Tent',        '', '', '', 0.35, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601691, 5, 166,  'Sharpening Wheel', '', '', '', 0.6,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601692, 5, 100,  'Incense Candle',   '', '', '', 2.0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601693, 5, 244,  'Lodestone',        '', '', '', 0.3,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601694, 5, 1667, 'Mana Well',        '', '', '', 0.5,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601695, 7, 138,  'Camp Chair',       '', '', '', 1.0,  1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601696, 5, 2572, 'Enchanted Drum',   '', '', '', 0.5,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601697, 5, 5911, 'Meditation Cushion','', '', '', 1.0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601698, 5, 6448, 'First Aid Kit',    '', '', '', 0.5,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(601699, 5, 445,  'Fish Bowl',        '', '', '', 1.0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0);

-- The engineer's Vendor Bot (summoned by the item next to the campfire): buys anything, repairs
DELETE FROM `creature_template` WHERE `entry` = 601699;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 601699;
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `unit_class`, `unit_flags`, `type`, `AIName`, `MovementType`, `HealthModifier`, `RegenHealth`, `flags_extra`,
    `ScriptName`, `VerifiedBuild`) VALUES
(601699, 'Vendor Bot', 'Camp Supplies', 50, 50, 35, 128 | 4096, 1, 1.14286, 1, 2 | 256 | 512, 9, '', 0, 1, 1, 2, '', 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(601699, 0, 15200, 1, 1, 0);

-- Crafted by professions: mod_temucraft_camping_camping_recipes.sql
DELETE FROM `npc_vendor` WHERE `item` BETWEEN 601670 AND 601680;
