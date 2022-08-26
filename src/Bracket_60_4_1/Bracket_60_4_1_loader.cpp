/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ProgressionSystem.h"

void AddSC_auto_balance_60_4_A();
void AddSC_naxx_entry_flag_60_4_A();
void AddSC_omarion_60_4_A();

void AddBracket_60_4_D_Scripts()
{
    if (!(sConfigMgr->GetOption<int>("ProgressionSystem.Brackets", 0) & PROGRESSION_BRACKET_60_TIER_4_A_NAXXRAMAS))
        return;
    AddSC_auto_balance_60_4_A();
    AddSC_naxx_entry_flag_60_4_A();
    AddSC_omarion_60_4_A();
}
