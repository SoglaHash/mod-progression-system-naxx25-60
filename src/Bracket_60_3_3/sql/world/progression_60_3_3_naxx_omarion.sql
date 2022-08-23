-- Add creature to map
DELETE FROM `creature` WHERE `guid` = 88811;
INSERT INTO `creature`
(`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`,
`phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`,
`orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
`curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
`ScriptName`, `VerifiedBuild`)
VALUES
(88811, 16365, 0, 0, 533, 0, 0, 3, 1, 0, 2853.57, -3251.69, 298.21, 5.19, 3520,
0.0, 0, 3052, 0, 0, 0, 0, 0, '', 0);

-- fix
SET @ID:= 24400;
DELETE FROM `gossip_menu` WHERE (`MenuID` = @ID+4);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@ID+4, 8507);
UPDATE `npc_text` SET `em0_0`=1, `em0_1`=0, `em0_2`=0, `em0_3`=0, `em0_4`=0, `em0_5`=0 WHERE ID=8507;
UPDATE `creature_template` SET `gossip_menu_id` = @ID+4 WHERE (`entry` = 16365);
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
DELETE FROM `gossip_menu` WHERE (`MenuID` = @ID);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@ID, 8516);
UPDATE npc_text SET `em0_0`=1, `em0_1`=0, `em0_2`=0, `em0_3`=0, `em0_4`=0, `em0_5`=0 WHERE `ID`=8516;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN
(@ID, @ID+1, @ID+2, @ID+3, @ID+4);
INSERT INTO `gossip_menu_option`
(`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`,
`OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`,
`BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
(@ID,   1, 0, 'Thank you, Omarion. You have taken a fatal blow for the team on this day.', 12281, 1, 1, 0,     0, 0, 0, '', 0, 0),
(@ID+1, 1, 0, 'Glacial Cloak.',                                                            12254, 1, 1, @ID+1, 0, 0, 0, '', 0, 0),
(@ID+1, 2, 0, 'Glacial Gloves.',                                                           12255, 1, 1, @ID+1, 0, 0, 0, '', 0, 0),
(@ID+1, 3, 0, 'Glacial Wrists.',                                                           12256, 1, 1, @ID+1, 0, 0, 0, '', 0, 0),
(@ID+1, 4, 0, 'Glacial Vest.',                                                             12253, 1, 1, @ID+1, 0, 0, 0, '', 0, 0),
(@ID+1, 5, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,     0, 0, 0, '', 0, 0),
(@ID+2, 1, 0, 'Icebane Bracers.',                                                          12268, 1, 1, @ID+2, 0, 0, 0, '', 0, 0),
(@ID+2, 2, 0, 'Icebane Gauntlets.',                                                        12267, 1, 1, @ID+2, 0, 0, 0, '', 0, 0),
(@ID+2, 3, 0, 'Icebane Breastplate.',                                                      12266, 1, 1, @ID+2, 0, 0, 0, '', 0, 0),
(@ID+2, 4, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,     0, 0, 0, '', 0, 0),
(@ID+3, 1, 0, 'Polar Bracers.',                                                            12264, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 2, 0, 'Polar Gloves.',                                                             12263, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 3, 0, 'Polar Tunic.',                                                              12262, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 4, 0, 'Icy Scale Bracers.',                                                        12261, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 5, 0, 'Icy Scale Gauntlets.',                                                      12260, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 6, 0, 'Icy Scale Breastplate.',                                                    12259, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+3, 7, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,     0, 0, 0, '', 0, 0),
(@ID+4, 1, 0, 'I am a master leatherworker, Omarion.',                                     12257, 1, 1, @ID+3, 0, 0, 0, '', 0, 0),
(@ID+4, 2, 0, 'I am a master blacksmith, Omarion.',                                        12269, 1, 1, @ID+2, 0, 0, 0, '', 0, 0),
(@ID+4, 3, 0, 'I am a master tailor, Omarion.',                                            12251, 1, 1, @ID+1, 0, 0, 0, '', 0, 0),
(@ID+4, 4, 0, 'Omarion, I am not a craftsman. Can you still help me?',                     12279, 1, 1, @ID,   0, 0, 0, '', 0, 0);

-- (@ID,   1, 0, 'Thank you, Omarion. You have taken a fatal blow for the team on this day.', 12281, 1, 1, 0,    0, 244001, 0, '', 0, 0),
-- (@ID+1, 1, 0, 'Glacial Cloak.',                                                            12254, 1, 1, 24401, 0, 244011, 0, '', 0, 0),
-- (@ID+1, 2, 0, 'Glacial Gloves.',                                                           12255, 1, 1, 24401, 0, 244012, 0, '', 0, 0),
-- (@ID+1, 3, 0, 'Glacial Wrists.',                                                           12256, 1, 1, 24401, 0, 244013, 0, '', 0, 0),
-- (@ID+1, 4, 0, 'Glacial Vest.',                                                             12253, 1, 1, 24401, 0, 244014, 0, '', 0, 0),
-- (@ID+1, 5, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,    0, 0,      0, '', 0, 0),
-- (@ID+2, 1, 0, 'Icebane Bracers.',                                                          12268, 1, 1, 24402, 0, 244021, 0, '', 0, 0),
-- (@ID+2, 2, 0, 'Icebane Gauntlets.',                                                        12267, 1, 1, 24402, 0, 244022, 0, '', 0, 0),
-- (@ID+2, 3, 0, 'Icebane Breastplate.',                                                      12266, 1, 1, 24402, 0, 244023, 0, '', 0, 0),
-- (@ID+2, 4, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,    0, 0,      0, '', 0, 0),
-- (@ID+3, 1, 0, 'Polar Bracers.',                                                            12264, 1, 1, 24403, 0, 244031, 0, '', 0, 0),
-- (@ID+3, 2, 0, 'Polar Gloves.',                                                             12263, 1, 1, 24403, 0, 244032, 0, '', 0, 0),
-- (@ID+3, 3, 0, 'Polar Tunic.',                                                              12262, 1, 1, 24403, 0, 244033, 0, '', 0, 0),
-- (@ID+3, 4, 0, 'Icy Scale Bracers.',                                                        12261, 1, 1, 24403, 0, 244034, 0, '', 0, 0),
-- (@ID+3, 5, 0, 'Icy Scale Gauntlets.',                                                      12260, 1, 1, 24403, 0, 244035, 0, '', 0, 0),
-- (@ID+3, 6, 0, 'Icy Scale Breastplate.',                                                    12259, 1, 1, 24403, 0, 244036, 0, '', 0, 0),
-- (@ID+3, 7, 0, 'I need to go. Evil stirs. Die well, Omarion.',                              12270, 1, 1, 0,    0, 0,      0, '', 0, 0),
-- (@ID+4, 1, 0, 'I am a master leatherworker, Omarion.',                                     12257, 1, 1, 24403, 0, 0,      0, '', 0, 0),
-- (@ID+4, 2, 0, 'I am a master blacksmith, Omarion.',                                        12269, 1, 1, 24402, 0, 0,      0, '', 0, 0),
-- (@ID+4, 3, 0, 'I am a master tailor, Omarion.',                                            12251, 1, 1, 24401, 0, 0,      0, '', 0, 0),
-- (@ID+4, 4, 0, 'Omarion, I am not a craftsman. Can you still help me?',                     12279, 1, 1, 24400, 0, 0,      0, '', 0, 0);
-- 
-- 
-- 
-- 
-- 
-- 
