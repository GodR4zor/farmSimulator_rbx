local class = require(game.ReplicatedStorage.middleclass)

local Tile = class("Tile")

local COINSQUANTY = 1

local MAX_STAGE = 2

function Tile:initialize(tileInstance)
	self.price = 10
	self.coins = 1
	self.stage = 0
	self.level = 1
	self.position = tileInstance.Position
	self.model = nil
	self.nextImageID = "rbxassetid://108133780981734"
	self.tilesStage = {
		game.ReplicatedStorage.tilesModel.pumpkinTile["Pumpkin 1"],
		game.ReplicatedStorage.tilesModel.pumpkinTile["Pumpkin 2"]}
end

function Tile:verifyLevel(level)
	local MAXLEVEL = 4
	
	if level == nil then
		return
	end
	
	if level > 4 then
		return
	end
	
	if level == 2 then
		self.tilesStage = {
			game.ReplicatedStorage.tilesModel.waterMelonTile["waterMelon 1"],
			game.ReplicatedStorage.tilesModel.waterMelonTile["waterMelon 2"]
		}
		self.coins = 2
		self.price = 30
		self.nextImageID = "rbxassetid://138258822260172"
	
	elseif level == 3 then
		self.tilesStage = {
			game.ReplicatedStorage.tilesModel.cornTile["corn 1"],
			game.ReplicatedStorage.tilesModel.cornTile["corn 2"]
		}
		self.coins = 3
		self.price = 90
		self.nextImageID = "rbxassetid://133844260128592"
	
	elseif level == 4 then
		self.tilesStage = {
			game.ReplicatedStorage.tilesModel.grapesTile["grapes 1"],
			game.ReplicatedStorage.tilesModel.grapesTile["grapes 2"]
		}
		self.coins = 4
		self.price = "MAX"
	end
end

function Tile:isComplete()
	return self.stage >= MAX_STAGE
end

function Tile:getPosition()
	return self.position
end

function Tile:setStage(stage, level)
	
	self:verifyLevel(level)
	self.stage = stage
	
	if self.model ~= nil then
		self.model:Destroy()
	end
	
	if self.stage > 0 then
		local prefab = self.tilesStage[self.stage]
		local model: Model = prefab:Clone()
		model.Parent = game.Workspace
		model:TranslateBy(self.position - model:GetPrimaryPartCFrame().p)

		self.model = model
		
		if self.stage == MAX_STAGE then
			model.ClickDetector.MouseClick:Connect(function()
				self:setStage(0)
				_G.gameData.coins += self.coins
			end)
		end
	end
end

return Tile