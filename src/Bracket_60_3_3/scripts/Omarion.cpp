#include "CombatAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "Vehicle.h"
enum CraftsSpellIds : uint32
{
    LEARN_GLACIAL_GLOVES        = 28212,
    HAS_GLACIAL_GLOVES          = 28205,
    LEARN_GLACIAL_WRISTS        = 28215,
    HAS_GLACIAL_WRISTS          = 28209,
    LEARN_GLACIAL_VEST          = 28213,
    HAS_GLACIAL_VEST            = 28207,
    LEARN_GLACIAL_CLOAK         = 28214,
    HAS_GLACIAL_CLOAK           = 28208,

    LEARN_POLAR_GLOVES          = 28229,
    HAS_POLAR_GLOVES            = 28220,
    LEARN_POLAR_BRACERS         = 28230,
    HAS_POLAR_BRACERS           = 28221,
    LEARN_POLAR_TUNIC           = 28228,
    HAS_POLAR_TUNIC             = 28219,

    LEARN_ICY_SCALE_GAUNTLETS   = 28232,
    HAS_ICY_SCALE_GAUNTLETS     = 28223,
    LEARN_ICY_SCALE_BRACERS     = 28233,
    HAS_ICY_SCALE_BRACERS       = 28224,
    LEARN_ICY_SCALE_BREASTPLATE = 28231,
    HAS_ICY_SCALE_BREASTPLATE   = 28222,

    LEARN_ICEBANE_GAUNTLETS     = 28248,
    HAS_ICEBANE_GAUNTLETS       = 28243,
    LEARN_ICEBANE_BRACERS       = 28249,
    HAS_ICEBANE_BRACERS         = 28244,
    LEARN_ICEBANE_BREASTPLATE   = 28245,
    HAS_ICEBANE_BREASTPLATE     = 28242,
};

enum Requirements
{
    FACTION_ARGENT_DAWN = 529,
    BOOK_REQ_RANK       = REP_REVERED,
    CRAFT1_REQ_RANK     = REP_REVERED,
    CRAFT2_REQ_RANK     = REP_EXALTED,
    MASTER_REQ_SKILL    = 255,
    LEARN_REQ_SKILL     = 300,
};

enum Quests
{
    QUEST_OMARIONS_HANDBOOK = 9233,
    OMARIONS_HANDBOOK       = 22719,
};

enum Gossips
{
    NPC_TEXT_INTRO                   = 8507,

    NPC_TEXT_NO_CRAFTER              = 8516,
    NPC_TEXT_NEW_ENTRY               = 24400,
    NPC_TEXT_TAILORING               = NPC_TEXT_NEW_ENTRY + 1,
    NPC_TEXT_BLACKSMITHING           = NPC_TEXT_NEW_ENTRY + 2,
    NPC_TEXT_LEATHERWORKING          = NPC_TEXT_NEW_ENTRY + 3,

    OPTION_TEXT_GOODBYE_NO_CRAFTER    = 12281,
    OPTION_TEXT_GOODBYE_CRAFTER       = 12270,

    OPTION_TEXT_NO_CRAFTER            = 12279,
    OPTION_TEXT_LEATHERWORKING        = 12257,
    OPTION_TEXT_BLACKSMITHING         = 12269,
    OPTION_TEXT_TAILORING             = 12251,

    OPTION_TEXT_GLACIAL_CLOAK         = 12254,
    OPTION_TEXT_GLACIAL_GLOVES        = 12255,
    OPTION_TEXT_GLACIAL_WRISTS        = 12256,
    OPTION_TEXT_GLACIAL_VEST          = 12253,

    OPTION_TEXT_ICEBANE_BRACERS       = 12268,
    OPTION_TEXT_ICEBANE_GAUNTLETS     = 12267,
    OPTION_TEXT_ICEBANE_BREASTPLATE   = 12266,

    OPTION_TEXT_POLAR_BRACERS         = 12264,
    OPTION_TEXT_POLAR_GLOVES          = 12263,
    OPTION_TEXT_POLAR_TUNIC           = 12262,
    OPTION_TEXT_ICY_SCALE_BRACERS     = 12261,
    OPTION_TEXT_ICY_SCALE_GAUNTLETS   = 12260,
    OPTION_TEXT_ICY_SCALE_BREASTPLATE = 12259,

    GOSSIP_CLOSE                        = 100,
};

class npc_omarion : public CreatureScript
{
public:
    npc_omarion() : CreatureScript("npc_omarion_gossip") { }


    bool OnGossipHello(Player* player, Creature* creature) override
    {
        uint32 tailorSkill      = player->GetSkillValue(SKILL_TAILORING);
        uint32 blacksmithSkill  = player->GetSkillValue(SKILL_BLACKSMITHING);
        uint32 leatherworkSkill = player->GetSkillValue(SKILL_LEATHERWORKING);
        if (tailorSkill >= MASTER_REQ_SKILL)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_TAILORING, GOSSIP_SENDER_MAIN, OPTION_TEXT_TAILORING);
        }

        if(blacksmithSkill >= MASTER_REQ_SKILL)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_BLACKSMITHING, GOSSIP_SENDER_MAIN, OPTION_TEXT_BLACKSMITHING);
        }

        if(leatherworkSkill >= MASTER_REQ_SKILL)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_LEATHERWORKING, GOSSIP_SENDER_MAIN, OPTION_TEXT_LEATHERWORKING);
        }

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_NO_CRAFTER, GOSSIP_SENDER_MAIN, OPTION_TEXT_NO_CRAFTER);

        SendGossipMenuFor(player, NPC_TEXT_INTRO, creature->GetGUID());
        creature->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
        return true;
    }

    void LearnCraftIfNotAlreadyKnown(uint32 learnId, uint32 knowId, Player *player)
    {
        if (!player->HasSpell(knowId))
        {
            player->CastSpell(player, learnId, false);
        }
    }

    void CloseGossipEmoteAndSpitOnPlayer(Player* player, Creature* creature)
    {
        CloseGossipMenuFor(player);
        creature->TextEmote(TEXT_EMOTE_SPIT, player);
        creature->HandleEmoteCommand(EMOTE_ONESHOT_RUDE);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        uint32 argentDawnRep    = player->GetReputationRank(FACTION_ARGENT_DAWN);

        uint32 tailorSkill      = player->GetSkillValue(SKILL_TAILORING);
        uint32 blacksmithSkill  = player->GetSkillValue(SKILL_BLACKSMITHING);
        uint32 leatherworkSkill = player->GetSkillValue(SKILL_LEATHERWORKING);

        ClearGossipMenuFor(player);

        switch(action)
        {
            case GOSSIP_CLOSE:
                CloseGossipMenuFor(player);
                break;
            case OPTION_TEXT_TAILORING:
                if (argentDawnRep < CRAFT1_REQ_RANK || tailorSkill < LEARN_REQ_SKILL)
                {
                    CloseGossipEmoteAndSpitOnPlayer(player, creature);
                }
                if (argentDawnRep >= CRAFT1_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_GLACIAL_WRISTS, GOSSIP_SENDER_MAIN, OPTION_TEXT_GLACIAL_WRISTS);
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_GLACIAL_GLOVES, GOSSIP_SENDER_MAIN, OPTION_TEXT_GLACIAL_GLOVES);
                }
                if (argentDawnRep >= CRAFT2_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_GLACIAL_VEST, GOSSIP_SENDER_MAIN, OPTION_TEXT_GLACIAL_VEST);
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_GLACIAL_CLOAK, GOSSIP_SENDER_MAIN, OPTION_TEXT_GLACIAL_CLOAK);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_GOODBYE_CRAFTER, GOSSIP_SENDER_MAIN, GOSSIP_CLOSE);
                SendGossipMenuFor(player, NPC_TEXT_TAILORING, creature->GetGUID());
                break;
            case OPTION_TEXT_BLACKSMITHING:
                if (argentDawnRep < CRAFT1_REQ_RANK || blacksmithSkill < LEARN_REQ_SKILL)
                {
                    CloseGossipEmoteAndSpitOnPlayer(player, creature);
                }
                if (argentDawnRep >= CRAFT1_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICEBANE_BRACERS, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICEBANE_BRACERS);
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICEBANE_GAUNTLETS, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICEBANE_GAUNTLETS);
                }
                if (argentDawnRep >= CRAFT2_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICEBANE_BREASTPLATE, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICEBANE_BREASTPLATE);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_GOODBYE_CRAFTER, GOSSIP_SENDER_MAIN, GOSSIP_CLOSE);
                SendGossipMenuFor(player, NPC_TEXT_BLACKSMITHING, creature->GetGUID());
                break;
            case OPTION_TEXT_LEATHERWORKING:
                if (argentDawnRep < CRAFT1_REQ_RANK || leatherworkSkill < LEARN_REQ_SKILL)
                {
                    CloseGossipEmoteAndSpitOnPlayer(player, creature);
                }
                if (argentDawnRep >= CRAFT1_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_POLAR_BRACERS, GOSSIP_SENDER_MAIN, OPTION_TEXT_POLAR_BRACERS);
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_POLAR_GLOVES, GOSSIP_SENDER_MAIN, OPTION_TEXT_POLAR_GLOVES);
                }
                if (argentDawnRep >= CRAFT2_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_POLAR_TUNIC, GOSSIP_SENDER_MAIN, OPTION_TEXT_POLAR_TUNIC);
                }
                if (argentDawnRep >= CRAFT1_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICY_SCALE_BRACERS, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICY_SCALE_BRACERS);
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICY_SCALE_GAUNTLETS, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICY_SCALE_GAUNTLETS);
                }
                if (argentDawnRep >= CRAFT2_REQ_RANK)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TRAINER, OPTION_TEXT_ICY_SCALE_BREASTPLATE, GOSSIP_SENDER_MAIN, OPTION_TEXT_ICY_SCALE_BREASTPLATE);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_GOODBYE_CRAFTER, GOSSIP_SENDER_MAIN, GOSSIP_CLOSE);
                SendGossipMenuFor(player, NPC_TEXT_LEATHERWORKING, creature->GetGUID());
                break;
            case OPTION_TEXT_NO_CRAFTER:
                if (argentDawnRep < BOOK_REQ_RANK)
                {
                    CloseGossipEmoteAndSpitOnPlayer(player, creature);
                }
                if (player->GetQuestStatus(QUEST_OMARIONS_HANDBOOK) == QUEST_STATUS_NONE && !player->HasItemCount(OMARIONS_HANDBOOK, 1, true))
                {
                    player->AddItem(OMARIONS_HANDBOOK, 1);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, OPTION_TEXT_GOODBYE_NO_CRAFTER, GOSSIP_SENDER_MAIN, GOSSIP_CLOSE);
                SendGossipMenuFor(player, NPC_TEXT_NO_CRAFTER, creature->GetGUID());
                break;
            case OPTION_TEXT_GLACIAL_CLOAK:
                LearnCraftIfNotAlreadyKnown(LEARN_GLACIAL_CLOAK, HAS_GLACIAL_CLOAK, player);
                break;
            case OPTION_TEXT_GLACIAL_GLOVES:
                LearnCraftIfNotAlreadyKnown(LEARN_GLACIAL_GLOVES, HAS_GLACIAL_GLOVES, player);
                break;
            case OPTION_TEXT_GLACIAL_WRISTS:
                LearnCraftIfNotAlreadyKnown(LEARN_GLACIAL_WRISTS, HAS_GLACIAL_WRISTS, player);
                break;
            case OPTION_TEXT_GLACIAL_VEST:
                LearnCraftIfNotAlreadyKnown(LEARN_GLACIAL_VEST, HAS_GLACIAL_VEST, player);
                break;
            case OPTION_TEXT_ICEBANE_BRACERS:
                LearnCraftIfNotAlreadyKnown(LEARN_ICEBANE_BRACERS, HAS_ICEBANE_BRACERS, player);
                break;
            case OPTION_TEXT_ICEBANE_GAUNTLETS:
                LearnCraftIfNotAlreadyKnown(LEARN_ICEBANE_GAUNTLETS, HAS_ICEBANE_GAUNTLETS, player);
                break;
            case OPTION_TEXT_ICEBANE_BREASTPLATE:
                LearnCraftIfNotAlreadyKnown(LEARN_ICEBANE_BREASTPLATE, HAS_ICEBANE_BREASTPLATE, player);
                break;
            case OPTION_TEXT_POLAR_BRACERS:
                LearnCraftIfNotAlreadyKnown(LEARN_POLAR_BRACERS, HAS_POLAR_BRACERS, player);
                break;
            case OPTION_TEXT_POLAR_GLOVES:
                LearnCraftIfNotAlreadyKnown(LEARN_POLAR_GLOVES, HAS_POLAR_GLOVES, player);
                break;
            case OPTION_TEXT_POLAR_TUNIC:
                LearnCraftIfNotAlreadyKnown(LEARN_POLAR_TUNIC, HAS_POLAR_TUNIC, player);
                break;
            case OPTION_TEXT_ICY_SCALE_BRACERS:
                LearnCraftIfNotAlreadyKnown(LEARN_ICY_SCALE_BRACERS, HAS_ICY_SCALE_BRACERS, player);
                break;
            case OPTION_TEXT_ICY_SCALE_GAUNTLETS:
                LearnCraftIfNotAlreadyKnown(LEARN_ICY_SCALE_GAUNTLETS, HAS_ICY_SCALE_GAUNTLETS, player);
                break;
            case OPTION_TEXT_ICY_SCALE_BREASTPLATE:
                LearnCraftIfNotAlreadyKnown(LEARN_ICY_SCALE_BREASTPLATE, HAS_ICY_SCALE_BREASTPLATE, player);
                break;
        }
        return true;
    }
};

void AddSC_omarion_60_3_C()
{
    new npc_omarion();
}
