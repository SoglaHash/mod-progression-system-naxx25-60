-- Add creature to map
DELETE FROM `creature` WHERE `guid` = 88811 and `id1` = 16365;
INSERT INTO `creature`
(`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`,
`phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`,
`orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
`curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
`ScriptName`, `VerifiedBuild`)
VALUES
(88811, 16365, 0, 0, 533, 0, 0, 3, 1, 0, 2853.57, -3251.69, 298.21, 5.19, 3520,
0.0, 0, 3052, 0, 0, 0, 0, 0, '', 0);

-- Handle gossip with cpp script
UPDATE `creature_template` SET `ScriptName`='npc_omarion_gossip',`gossip_menu_id`=0 WHERE `entry` = 16365;

-- fix to npc_text
SET @ID:= 24400;
-- Set correct text when gossip tailor/leatherwork/blacksmith option
DELETE FROM `npc_text` WHERE `ID` in (@ID+1, @ID+2, @ID+3);
INSERT INTO `npc_text`
(`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`)
VALUES
(@ID+1, 'A tailor, eh? Very well. What would you like to learn about, tailor?', '', 12252, 0, 1.0, 6, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, 0),
(@ID+2, 'I have what you need, $c.',                                            '', 12265, 0, 1.0, 1, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, 0),
(@ID+3, 'Perhaps I can teach you something...',                                 '', 12258, 0, 1.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0.0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `gossip_menu` WHERE `MenuID` IN (@ID+1, @ID+2, @ID+3);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES
(@ID+1, @ID+1),
(@ID+2, @ID+2),
(@ID+3, @ID+3);
-- Handle emote with cpp script when opening gossip
UPDATE `npc_text` SET `em0_0`=0, `em0_1`=0, `em0_2`=0, `em0_3`=0, `em0_4`=0, `em0_5`=0 WHERE `ID`=8507;
-- Handle emote with cpp script when non-craft option is selected
UPDATE `npc_text` SET `em0_0`=0, `em0_1`=0, `em0_2`=0, `em0_3`=0, `em0_4`=0, `em0_5`=0 WHERE `ID`=8516;