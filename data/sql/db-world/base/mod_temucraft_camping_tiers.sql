-- mod-temucraft-camping: camping tiers (stronger camp items at skill 140 and 300), bigger campfires
-- (5 and 10 camp features, Cooking 140/300) and herb/ore growers (Alchemy / Mining, skill 20/140/300). Recipes 95280-95307.
-- Re-runnable.
SET @DummySpell := 18282;
DELETE FROM `item_template` WHERE `entry` BETWEEN 602020 AND 602047;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`,
    `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `ItemLevel`, `RequiredLevel`, `maxcount`, `stackable`,
    `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellcooldown_1`, `bonding`, `description`, `Material`, `ScriptName`,
    `VerifiedBuild`) VALUES
(602020, 0, 8, -1, 'Sturdy Camp Tent', 3568, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there tops your rested experience up to 7.5% of your level. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602030, 0, 8, -1, 'Masterwork Camp Tent', 3568, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there tops your rested experience up to 10% of your level. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602021, 0, 8, -1, 'Sturdy Sharpening Wheel', 7450, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +51 Strength for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602031, 0, 8, -1, 'Masterwork Sharpening Wheel', 7450, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +68 Strength for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602022, 0, 8, -1, 'Sturdy Incense Candle', 7451, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +37 Intellect for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602032, 0, 8, -1, 'Masterwork Incense Candle', 7451, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +50 Intellect for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602023, 0, 8, -1, 'Sturdy Lodestone', 7452, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +135 attack power for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602033, 0, 8, -1, 'Masterwork Lodestone', 7452, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +180 attack power for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602024, 0, 8, -1, 'Sturdy Mana Well', 7718, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there restores 43 mana every 5 sec for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602034, 0, 8, -1, 'Masterwork Mana Well', 7718, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there restores 58 mana every 5 sec for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602025, 0, 8, -1, 'Sturdy Camp Chair', 9636, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +3% critical strike chance for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602035, 0, 8, -1, 'Masterwork Camp Chair', 9636, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +4% critical strike chance for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602026, 0, 8, -1, 'Sturdy Enchanted Drum', 7451, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +462 armor, +19 all stats and +33 all resistances for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602036, 0, 8, -1, 'Masterwork Enchanted Drum', 7451, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +616 armor, +26 all stats and +44 all resistances for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602027, 0, 8, -1, 'Sturdy Meditation Cushion', 9636, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +48 Spirit for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602037, 0, 8, -1, 'Masterwork Meditation Cushion', 9636, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +64 Spirit for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602028, 0, 8, -1, 'Sturdy First Aid Kit', 7718, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +45 Stamina for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602038, 0, 8, -1, 'Masterwork First Aid Kit', 7718, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +60 Stamina for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602029, 0, 8, -1, 'Sturdy Fish Bowl', 7452, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +12% all stats for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602039, 0, 8, -1, 'Masterwork Fish Bowl', 7452, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: resting there grants +16% all stats for 30 min. Stronger than the plain one.', -1, 'item_temucraft_camp_feature', 0),
(602040, 0, 8, -1, 'Sturdy Campfire', 7451, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Builds a campfire that holds up to 5 camp features, for 30 min. You can cook at it.', -1, 'item_temucraft_camp_feature', 0),
(602041, 0, 8, -1, 'Grand Campfire', 7451, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Builds a campfire that holds up to 10 camp features, for 30 min. You can cook at it.', -1, 'item_temucraft_camp_feature', 0),
(602042, 0, 8, -1, 'Herb Planter', 7718, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for herbs.', -1, 'item_temucraft_camp_feature', 0),
(602043, 0, 8, -1, 'Sturdy Herb Planter', 7718, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for herbs.', -1, 'item_temucraft_camp_feature', 0),
(602044, 0, 8, -1, 'Masterwork Herb Planter', 7718, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for herbs.', -1, 'item_temucraft_camp_feature', 0),
(602045, 0, 8, -1, 'Ore Extractor', 7452, 1, 1, 15000, 3750, 0, 20, 5, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for ore.', -1, 'item_temucraft_camp_feature', 0),
(602046, 0, 8, -1, 'Sturdy Ore Extractor', 7452, 2, 1, 40000, 10000, 0, 35, 20, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for ore.', -1, 'item_temucraft_camp_feature', 0),
(602047, 0, 8, -1, 'Masterwork Ore Extractor', 7452, 3, 1, 90000, 22500, 0, 65, 40, 0, 5, @DummySpell, 0, 0, -1, 0, 'Set it up by a campfire: after 10 minutes it can be harvested for ore.', -1, 'item_temucraft_camp_feature', 0);

DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 602060 AND 602067;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`,
    `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`,
    `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`,
    `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(602060, 8, 6744, 'Sturdy Campfire', '', '', '', 1.0, 4,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602061, 8, 7748, 'Grand Campfire', '', '', '', 0.8, 4,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602062, 3, 8559, 'Herb Planter', '', '', '', 0.8, 1691,602062,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602063, 3, 8559, 'Sturdy Herb Planter', '', '', '', 0.8, 1691,602063,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602064, 3, 8559, 'Masterwork Herb Planter', '', '', '', 0.8, 1691,602064,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602065, 3, 291, 'Ore Extractor', '', '', '', 0.6, 1691,602065,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602066, 3, 291, 'Sturdy Ore Extractor', '', '', '', 0.6, 1691,602066,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0),
(602067, 3, 291, 'Masterwork Ore Extractor', '', '', '', 0.6, 1691,602067,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '', '', 0);

DELETE FROM `gameobject_loot_template` WHERE `Entry` BETWEEN 602062 AND 602067;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(602062, 2447, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602062, 765, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602062, 2450, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602062, 785, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602062, 2452, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602063, 3356, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602063, 3818, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602063, 3821, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602063, 3358, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602063, 8838, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602064, 22785, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602064, 22786, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602064, 22789, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602064, 22787, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602064, 22790, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602065, 2770, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602065, 2771, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602065, 2775, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602066, 2772, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602066, 3858, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602066, 7911, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602067, 23424, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602067, 23425, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602067, 23426, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(602062, 9602062, 9602062, 100, 0, 1, 0, 1, 1, 'camp grower: second pick'),
(602063, 9602063, 9602063, 100, 0, 1, 0, 1, 1, 'camp grower: second pick'),
(602064, 9602064, 9602064, 100, 0, 1, 0, 1, 1, 'camp grower: second pick'),
(602065, 9602065, 9602065, 100, 0, 1, 0, 1, 1, 'camp grower: second pick'),
(602066, 9602066, 9602066, 100, 0, 1, 0, 1, 1, 'camp grower: second pick'),
(602067, 9602067, 9602067, 100, 0, 1, 0, 1, 1, 'camp grower: second pick');
DELETE FROM `reference_loot_template` WHERE `Entry` BETWEEN 9602062 AND 9602067;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9602062, 2447, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602062, 765, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602062, 2450, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602062, 785, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602062, 2452, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602063, 3356, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602063, 3818, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602063, 3821, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602063, 3358, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602063, 8838, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602064, 22785, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602064, 22786, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602064, 22789, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602064, 22787, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602064, 22790, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602065, 2770, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602065, 2771, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602065, 2775, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602066, 2772, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602066, 3858, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602066, 7911, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602067, 23424, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602067, 23425, 0, 0, 0, 1, 1, 2, 4, 'camp grower'),
(9602067, 23426, 0, 0, 0, 1, 1, 2, 4, 'camp grower');

DELETE FROM `trainer_spell` WHERE `SpellId` BETWEEN 95280 AND 95307;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
SELECT t.`Id`, r.`spell`, r.`cost`, r.`skill`, r.`rank`, 0, 0, 0, r.`lvl`, 0
FROM `trainer` t
JOIN (
SELECT 95280 AS `spell`, 165 AS `skill`, 140 AS `rank`, 5000 AS `cost`, 20 AS `lvl`
      UNION ALL SELECT 95281, 165, 300, 20000, 40
      UNION ALL SELECT 95282, 164, 140, 5000, 20
      UNION ALL SELECT 95283, 164, 300, 20000, 40
      UNION ALL SELECT 95284, 773, 140, 5000, 20
      UNION ALL SELECT 95285, 773, 300, 20000, 40
      UNION ALL SELECT 95286, 186, 140, 5000, 20
      UNION ALL SELECT 95287, 186, 300, 20000, 40
      UNION ALL SELECT 95288, 171, 140, 5000, 20
      UNION ALL SELECT 95289, 171, 300, 20000, 40
      UNION ALL SELECT 95290, 197, 140, 5000, 20
      UNION ALL SELECT 95291, 197, 300, 20000, 40
      UNION ALL SELECT 95292, 333, 140, 5000, 20
      UNION ALL SELECT 95293, 333, 300, 20000, 40
      UNION ALL SELECT 95294, 197, 140, 5000, 20
      UNION ALL SELECT 95295, 197, 300, 20000, 40
      UNION ALL SELECT 95296, 129, 140, 5000, 20
      UNION ALL SELECT 95297, 129, 300, 20000, 40
      UNION ALL SELECT 95298, 185, 140, 5000, 20
      UNION ALL SELECT 95299, 185, 300, 20000, 40
      UNION ALL SELECT 95300, 185, 140, 5000, 20
      UNION ALL SELECT 95301, 185, 300, 20000, 40
      UNION ALL SELECT 95302, 171, 20, 500, 5
      UNION ALL SELECT 95303, 171, 140, 5000, 20
      UNION ALL SELECT 95304, 171, 300, 20000, 40
      UNION ALL SELECT 95305, 186, 20, 500, 5
      UNION ALL SELECT 95306, 186, 140, 5000, 20
      UNION ALL SELECT 95307, 186, 300, 20000, 40
) r ON r.`skill` = t.`Requirement`
WHERE t.`Type` = 2;
