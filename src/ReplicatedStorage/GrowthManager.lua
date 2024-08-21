local GrowthManager = {}

local tilesList = _G.gameData.tilesList
local growthChancePerSecond = 0.1


function GrowthManager:run(deltaTime)
	for _, tile in tilesList do
		
		-- Verify completed tiles
		if tile:isComplete() then
			continue
		end
		
		-- Calculate chance
		local chance = growthChancePerSecond * deltaTime
		local mathChance = math.random()
		
		-- Pula para proxima iteracao caso mathChance seja maior que chance.
		if mathChance > chance then
			continue
		end
		
		tile:setStage(tile.stage + 1, tile.level)
		
	end
end

return GrowthManager