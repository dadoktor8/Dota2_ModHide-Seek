

function GameMode:OnPlayerPickHero( keys )

	local heroClass = keys.hero
	local heroEntitiy = EntIndexToHScript(keys.heroindex)
	local player = EntIndexToHScript(keys.player)

	if heroEntitiy:GetTeamNumber() == DOTA_TEAM_BADGUYS then 
		PlayerResource:ReplaceHeroWith(heroEntitiy:GetPlayerOwnerID(), "npc_dota_hero_riki", PlayerResource:GetGold(heroEntitiy:GetPlayerOwnerID()), 0)
	end
end
