-- Generated from template
require('events')
require('HeroSelection')

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function GameMode:OnGameRulesStateChange(keys)
if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then 
	HeroSelection:Start()
end 
  DebugPrint("[hide&seek] GameRules State Changed")
  DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end



function GiveDust(hero)
	if hero:HasRoomForItem("item_dust", true, true) then
		local dust = CreateItem("item_dust", hero, hero)
		dust:SetPurchaseTime(0)
		hero:AddItem(dust)
	end 
end 

function OnHeroPicked(event)
	local hero = EntIndexToHScript(event.heroindex)
	GiveDust(hero)
end 



function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	ListenToGameEvent("game_rules_state_change", OnGameRulesStateChange, nil)
    ListenToGameEvent("dota_player_pick_hero", OnHeroPicked, nil)
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
	

end


function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 5)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 5)
    GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_sniper")	
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end