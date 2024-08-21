-- Loading
wait(2)

-- Load Global Gamedata
_G.gameData = require(game.ReplicatedStorage.gameData)

-- Services
local RunService = game:GetService("RunService")

--Houses
local houseRun = require(game:GetService("ReplicatedStorage").houseRun)

-- Dependencies
local GrowthManager = require(game.ReplicatedStorage.GrowthManager)

-- Fruits
local tile = require(game.ReplicatedStorage.tileClass) -- Script

-- Lista de Tiles
local tilesList = {}

-- Iterando sobre os tiles
wait(1)
local tilesChildren = game.Workspace.Tiles:GetChildren()

for _, tileModel:Model in tilesChildren do
	
	
	for _, tileInstance in tileModel:GetChildren() do
		
		local tileObject = tile:new(tileInstance)
		table.insert(_G.gameData.tilesList, tileObject)
	end


end

RunService.Heartbeat:Connect(function(deltatime)
	GrowthManager:run(deltatime)
	houseRun()
end)