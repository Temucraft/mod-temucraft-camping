-- mod-temucraft-camping: camp features are crafted by professions now (recipes 95030-95035, from skill 20):
-- Leatherworking the Camp Tent, Blacksmithing the Sharpening Wheel, Inscription the Incense Candle, Mining
-- (smelting window) the Lodestone, Alchemy the Mana Well, Tailoring the Camp Chair and the Meditation Cushion,
-- Enchanting the Enchanted Drum, First Aid the First Aid Kit, Cooking the Fish Bowl, Engineering the Vendor Bot. Every trainer of the profession
-- teaches it. The vendors no longer sell them. Re-runnable.
DELETE FROM `npc_vendor` WHERE `item` BETWEEN 601670 AND 601680;
DELETE FROM `trainer_spell` WHERE `SpellId` BETWEEN 95030 AND 95040;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
SELECT t.`Id`, r.`spell`, 500, r.`skill`, 20, 0, 0, 0, 5, 0
FROM `trainer` t
JOIN (SELECT 95030 AS `spell`, 165 AS `skill` UNION ALL SELECT 95031, 164 UNION ALL SELECT 95032, 773
      UNION ALL SELECT 95033, 186 UNION ALL SELECT 95034, 171 UNION ALL SELECT 95035, 197
      UNION ALL SELECT 95036, 333 UNION ALL SELECT 95037, 197 UNION ALL SELECT 95038, 129 UNION ALL SELECT 95039, 185
      UNION ALL SELECT 95040, 202) r ON r.`skill` = t.`Requirement`
WHERE t.`Type` = 2;
