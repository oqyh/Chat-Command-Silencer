#include <sourcemod>

ConVar g_enable
ConVar g_exclamation;
ConVar g_dot;
ConVar g_slash;
ConVar g_space;

bool g_benable = false;
bool g_bexclamation = false;
bool g_bdot = false;
bool g_bslash = false;
bool g_bspace = false;

public Plugin myinfo = 
{
	name = "[ANY] Chat Command Silencer",
	author = "Gold KingZ",
	description = "Command Silencer ( ! / . Space Chat  Silencer)",
	version     = "1.0.1",
	url = "https://github.com/oqyh"
}

public OnPluginStart()
{
	g_enable = CreateConVar("cmd_slint_enable"		     , "1", "Enable Chat Command Silencer Plugin || 1= Yes || 0= No", _, true, 0.0, true, 1.0);
	g_exclamation = CreateConVar("cmd_slint_exclamation"		     , "0", "Silent Command Chat Begin With (!) || 1= Yes || 0= No", _, true, 0.0, true, 1.0);
	g_dot = CreateConVar("cmd_slint_dot"		     , "0", "Silent Command Chat Begin With (.) || 1= Yes || 0= No", _, true, 0.0, true, 1.0);
	g_slash = CreateConVar("cmd_slint_slash"		     , "0", "Silent Command Chat Begin With (/) || 1= Yes || 0= No", _, true, 0.0, true, 1.0);
	g_space = CreateConVar("cmd_slint_space"		     , "0", "Silent Command Chat Begin With ( )  Space || 1= Yes || 0= No", _, true, 0.0, true, 1.0);
	
	AddCommandListener(OnSayCmd, "say");
	AddCommandListener(OnSayCmd, "say_team");
	
	HookConVarChange(g_enable, OnSettingsChanged);
	HookConVarChange(g_exclamation, OnSettingsChanged);
	HookConVarChange(g_dot, OnSettingsChanged);
	HookConVarChange(g_slash, OnSettingsChanged);
	HookConVarChange(g_space, OnSettingsChanged);
	
	AutoExecConfig(true, "Chat_Command_Silencer");
} 

public void OnConfigsExecuted()
{
	g_benable = GetConVarBool(g_enable);
	g_bexclamation = GetConVarBool(g_exclamation);
	g_bdot = GetConVarBool(g_dot);
	g_bslash = GetConVarBool(g_slash);
	g_bspace = GetConVarBool(g_space);
}

public int OnSettingsChanged(Handle convar, const char[] oldValue, const char[] newValue)
{
	if(convar == g_enable)
	{
		g_benable = g_enable.BoolValue;
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
	
	if(convar == g_space)
	{
		g_bspace = g_space.BoolValue;
	}
	
	return 0;
}

public Action OnSayCmd(int client, char[] command, int argc)
{ 
	char text[256];
	GetCmdArg(1, text, sizeof(text));
	
	if (!g_benable) return Plugin_Continue;
	
	if (g_bexclamation)
	{
		if (StrContains(text, "!", false) == 0)
		{
			return Plugin_Handled; 
		}
	}
	
	if (g_bdot)
	{
		
		if (StrContains(text, ".", false) == 0)
		{
			return Plugin_Handled; 
		}
	}
	
	if (g_bslash)
	{
		if (StrContains(text, "/", false) == 0)
		{
			return Plugin_Handled; 
		}
	}
	
	if (g_bspace)
	{
		if (StrContains(text, " ", false) == 0)
		{
			return Plugin_Handled; 
		}
	}
	
	return Plugin_Continue;
}