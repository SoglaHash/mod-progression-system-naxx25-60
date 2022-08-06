-- Enable Naxxramas Map (mapID: 533)
DELETE FROM `disables` WHERE `entry` = 533;

-- Update map difficulty of Naxx10
-- See MapDifficultyDBC
-- https://wow.tools/dbc/?dbc=mapdifficulty&build=10.0.0.44895#page=1&search=533
DELETE FROM `mapdifficulty_dbc` WHERE `MapID` = 533;
INSERT INTO `mapdifficulty_dbc` (`ID`, `MapID`, `Difficulty`, `RaidDuration`, `MaxPlayers`, `Difficultystring`) VALUES (46, 533, 0, 604800, 25, 'RAID_DIFFICULTY_25PLAYER');

-- Set access to min level 60 for Naxx10
UPDATE `dungeon_access_template` SET `min_level` = 60 WHERE `map_id` = 533 AND `difficulty` = 0;

-- Disable achievements
DELETE FROM `disables` WHERE `entry` IN
(2176, 1858, 2184, 1856, 574, 1997, 572, 2178, 2182, 2180, 562, 564, 578, 576, 2146, 568, 1996, 2187)
AND `sourceType` = 4;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(4, 2176, 0, 0, 0, 'And They Would All Go Down Together (10 player)'),
(4, 1858, 0, 0, 0, 'Arachnophobia (10 player)'),
(4, 2184, 0, 0, 0, 'Just Can\'t Get Enough (10 player)'),
(4, 1856, 0, 0, 0, 'Make Quick Werk Of Him (10 player)'),
(4, 574,  0, 0, 0, 'Kel\'Thuzad\'s Defeat (10 player)'),
(4, 1997, 0, 0, 0, 'Momma Said Knock You Out (10 player)'),
(4, 572,  0, 0, 0, 'Sapphiron\'s Demise (10 player)'),
(4, 2178, 0, 0, 0, 'Shocking! (10 player)'),
(4, 2182, 0, 0, 0, 'Spore Loser (10 player)'),
(4, 2180, 0, 0, 0, 'Subtraction (10 player)'),
(4, 562,  0, 0, 0, 'The Arachnid Quarter (10 player)'),
(4, 564,  0, 0, 0, 'The Construct Quarter (10 player)'),
(4, 578,  0, 0, 0, 'The Dedicated Few (10 player)'),
(4, 576,  0, 0, 0, 'The Fall of Naxxramas (10 player)'),
(4, 2146, 0, 0, 0, 'The Hundred Club (10 player)'),
(4, 568,  0, 0, 0, 'The Military Quarter (10 player)'),
(4, 1996, 0, 0, 0, 'The Plague Quarter (10 player)'),
(4, 2187, 0, 0, 0, 'The Undying');

-- Disable loot for all Naxx non-bosses
UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0 WHERE `entry` IN (16124, 16125, 16126, 16127, 16148, 16149, 16150, 16573, 16698, 16803, 16505, 16506, 17055, 16027, 16290, 16360, 16981, 16982, 16983, 16984, 16286, 23561, 23562, 23563, 16441, 16029, 16400, 16145, 16146, 16154, 16156, 16163, 16164, 16165, 16167, 16168, 16447, 16193, 16194, 16215, 16216, 15974, 15975, 15976, 15977, 15978, 15979, 15980, 16236, 15981, 16243, 16244, 30071, 30085, 16017, 16018, 16020, 16021, 16022, 16024, 16025, 16034, 16036, 16037, 16297, 16056, 16057, 16067, 29912, 16980, 16082, 30083);

-- Disable loot for Bosses
DELETE FROM `creature_loot_template` WHERE `entry` IN (15928, 15931, 15932, 15936, 15952, 15953, 15954, 15956, 15989, 15990, 16011, 16028, 16060, 16061);

-- Add boss loot
-- Thaddius
INSERT INTO creature_loot_template (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15928, 22726, 0, 30,  0, 1, 1, 1, 1, 'Atiesh Splinter'),
(15928, 22353, 0, 100, 0, 1, 2, 1, 1, 'Desecrated Helmet'),
(15928, 22360, 0, 100, 0, 1, 2, 1, 1, 'Desecrated Headpiece'),
(15928, 22367, 0, 100, 0, 1, 2, 1, 1, 'Desecrated Circlet'),
(15928, 22801, 0, 100, 0, 1, 3, 1, 1, 'Spire of Twilight'),
(15928, 22808, 0, 100, 0, 1, 3, 1, 1, 'The Castigator'),
(15928, 23000, 0, 100, 0, 1, 3, 1, 1, 'Plated Abomination Ribcage'),
(15928, 23001, 0, 100, 0, 1, 3, 1, 1, 'Eye of Diminution'),
(15928, 23070, 0, 100, 0, 1, 3, 1, 1, 'Leggings of Polarity');

-- Set scaling with script

