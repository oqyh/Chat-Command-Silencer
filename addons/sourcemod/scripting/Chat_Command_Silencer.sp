#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

#define PLUGIN_VERSION	"1.0.3"

ConVar g_enable;
ConVar g_exclamation;
ConVar g_dot;
ConVar g_slash;
ConVar g_admin;
ConVar g_hAdmFlag;
ConVar g_caps;

bool g_benable = false;
bool g_badmin = false;
bool g_bexclamation = false;
bool g_bdot = false;
bool g_bslash = false;
bool g_bcaps = false;



public Plugin myinfo = 
{
	name = "[ANY] Chat Command Silencer",
	author = "Gold KingZ",
	description = "Command Silencer ( ! / . ) + Force Lower Case Commands",
	version     = PLUGIN_VERSION,
	url = "https://github.com/oqyh"
}

public void OnPluginStart()
{
	CreateConVar("cmd_slint_version", PLUGIN_VERSION, "[ANY] Chat Command Silencer Plugin Version", FCVAR_NOTIFY|FCVAR_DONTRECORD);
	
	g_enable = CreateConVar("cmd_slint_enable"		     , "1", "Enable Chat Command Silencer Plugin\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	g_admin = CreateConVar("cmd_slint_admin"		     , "0", "Make Chat Command Silencer For Admins Only\n1= Yes ( Specific Flags cmd_slint_admin_flag )\n0= No ( Everyone )", _, true, 0.0, true, 1.0);
	g_hAdmFlag = CreateConVar("cmd_slint_admin_flag",	"abcdefghijklmnoz",	"if cmd_slint_admin 1 which flags is it");
	g_caps = CreateConVar("cmd_slint_caps"		     , "0", "Force After Commands ( ! . / ) UPPERCASE To lowercase\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	g_exclamation = CreateConVar("cmd_slint_exclamation"		     , "0", "Silent Command Chat Begin With (!)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	g_dot = CreateConVar("cmd_slint_dot"		     , "0", "Silent Command Chat Begin With (.)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	g_slash = CreateConVar("cmd_slint_slash"		     , "0", "Silent Command Chat Begin With (/)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	AddCommandListener(OnSayCmd, "say");
	AddCommandListener(OnSayCmd, "say_team");
	
	HookConVarChange(g_enable, OnSettingsChanged);
	HookConVarChange(g_admin, OnSettingsChanged);
	HookConVarChange(g_caps, OnSettingsChanged);
	HookConVarChange(g_exclamation, OnSettingsChanged);
	HookConVarChange(g_dot, OnSettingsChanged);
	HookConVarChange(g_slash, OnSettingsChanged);
	
	AutoExecConfig(true, "Chat_Command_Silencer");
} 

public void OnConfigsExecuted()
{
	g_benable = GetConVarBool(g_enable);
	g_badmin = GetConVarBool(g_admin);
	g_bcaps = GetConVarBool(g_caps);
	g_bexclamation = GetConVarBool(g_exclamation);
	g_bdot = GetConVarBool(g_dot);
	g_bslash = GetConVarBool(g_slash);
}

public int OnSettingsChanged(Handle convar, const char[] oldValue, const char[] newValue)
{
	if(convar == g_enable)
	{
		g_benable = g_enable.BoolValue;
	}
	
	if(convar == g_admin)
	{
		g_badmin = g_admin.BoolValue;
	}
	
	if(convar == g_caps)
	{
		g_bcaps = g_caps.BoolValue;
	}
	
	if(convar == g_exclamation)
	{
		g_bexclamation = g_exclamation.BoolValue;
	}
	
	if(convar == g_dot)
	{
		g_bdot = g_dot.BoolValue;
	}
	
	if(convar == g_slash)
	{
		g_bslash = g_slash.BoolValue;
	}
	
	return 0;
}

public Action OnSayCmd(int client, const char[] command, int argc)
{
	if (!g_benable || !IsValidClient(client)) return Plugin_Continue;

	char zText[1024];
	GetCmdArgString(zText, sizeof(zText));

	StripQuotes(zText);
	TrimString(zText);
	
	if (StrEqual(zText, " ") || !zText[0]) return Plugin_Handled;
	
	if(g_bcaps)
	{
		if ((zText[0] == '/') || (zText[0] == '!') || (zText[0] == '.'))
		{
			if (IsCharUpper(zText[1]))
			{
				for (int i = 0; i <= strlen(zText); ++i)
					zText[i] = CharToLower(zText[i]);
				FakeClientCommand(client, "say %s", zText);
				return Plugin_Handled;
			}
		}
	}
	
	if(g_badmin)
	{
		char zFlags[32];
		GetConVarString(g_hAdmFlag, zFlags, sizeof(zFlags));
		
		if(CheckAdminFlagsByString(client, zFlags))
		{
			if (g_bslash)
			{
				if (StrContains(zText, "/", false) == 0)
				return Plugin_Handled;
			}
			
			if (g_bexclamation)
			{
				if (StrContains(zText, "!", false) == 0)
				return Plugin_Handled;
			}
			
			if (g_bdot)
			{
				if (StrContains(zText, ".", false) == 0)
				return Plugin_Handled;
			}
		}
	}else if(!g_badmin)
	{
		if (g_bslash)
		{
			if (StrContains(zText, "/", false) == 0)
			return Plugin_Handled;
		}
		
		if (g_bexclamation)
		{
			if (StrContains(zText, "!", false) == 0)
			return Plugin_Handled;
		}
		
		if (g_bdot)
		{
			if (StrContains(zText, ".", false) == 0)
			return Plugin_Handled;
		}
	}
	
	return Plugin_Continue;
}

stock bool CheckAdminFlagsByString(int client, const char[] flagString)
{
    AdminId admin = view_as<AdminId>(GetUserAdmin(client));
    if (admin != INVALID_ADMIN_ID)
    {
        int flags = ReadFlagString(flagString);
        for (int i = 0; i <= 20; i++)
        {
            if (flags & (1<<i))
            {
                if(GetAdminFlag(admin, view_as<AdminFlag>(i)))
                    return true;
              }
          }
    }
    return false;
} 

stock bool IsValidClient(int client)
{
	if (client >= 1 && client <= MaxClients && IsClientInGame(client))
		return true;
	return false;
}