#pragma semicolon 1
#include <sourcemod>
#include <SteamWorks>
#include <sdktools>
#include <sdkhooks>
#include <cstrike>

#define PLUGIN_VERSION "1.1.0"

public Plugin myinfo = {
    name        = "NonPrimeKicker",
    author      = "Summer_Soldier",
    description = "Kick Non Prime players",
    version     = PLUGIN_VERSION,
    url         = "summer@ganggaming.in"
};


public void OnPluginStart()
{
    HookEvent("player_team", EventPlayerTeam);
}

public Action EventPlayerTeam(Event event,const char[] name, bool dontBroadcast) {

    new client = GetClientOfUserId(GetEventInt(event, "userid"));
    int playerlevel = GetEntProp(GetPlayerResourceEntity(), Prop_Send, "m_nPersonaDataPublicLevel", _, client);

    if (CheckCommandAccess(client, "BypassPremiumCheck", ADMFLAG_RESERVATION, true)) {
        PrintToServer("Here is client id %d and level=====>>>>>%d", client, playerlevel);
        PrintToServer("Reserverd/Admin client");
    } else if (playerlevel > 2) {
        PrintToServer("Here is client id %d and level=====>>>>>%d", client, playerlevel);
        PrintToServer("Level qualified client");
        if(k_EUserHasLicenseResultDoesNotHaveLicense == SteamWorks_HasLicenseForApp(client, 624820)){
            PrintToServer("Non Prime Setting tag");
            CS_SetClientClanTag(client, "[NON-PRIME]");
        }
    } else if (k_EUserHasLicenseResultDoesNotHaveLicense == SteamWorks_HasLicenseForApp(client, 624820)) {
        PrintToServer("Non Prime Client kicked");
        KickClient(client, "You need a Prime CS:GO account to play on this server, If you think this message is an error contact ADMIN");
        return;
    } else {
        PrintToServer("Unable to verify client no action taken");
    }

}
