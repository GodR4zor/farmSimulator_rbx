-- Services:
local ProximityPrompt = game:GetService("ProximityPromptService")
local Players = game:GetService("Players")

-- Player
local player = Players.LocalPlayer

-- PlayerGui
local playerGui = player:WaitForChild("PlayerGui")
local upgradeTile = playerGui:WaitForChild("upgradeTile")
local upgradeTileFrame:Frame = upgradeTile:WaitForChild("upgradeFrame")
local upgradeTileButton:TextButton = upgradeTileFrame:WaitForChild("upgradeButton")
local costText:TextLabel = upgradeTileFrame:WaitForChild("costText") -- Cost Text
local exitButton:TextButton = upgradeTileFrame:WaitForChild("exitButton") -- Exit Button
local imageLabel:ImageLabel = upgradeTileFrame:WaitForChild("imageUpgrade")

local LEVELUP = 1

local debouncingButton = false
local debouncingProximity = false

local tileIndex = nil
local price = nil

local function onPromptTrigerred(proximityObject:ProximityPrompt, player:Player)
	if proximityObject.Name == "tileUpgrade" then
		

		if debouncingProximity then
			return
		end
		
		debouncingProximity = true
		
		-- Object
		local tile:Part = proximityObject.Parent
		local tilePosition = tile.Position
	
		
		local function checkUpdateUI()
			for i, tileObj in _G.gameData.tilesList do
				if tileObj.position == tilePosition then
					tileIndex = i
					price = tileObj.price
					local image = tileObj.nextImageID
					imageLabel.Image = image
					costText.Text = price
				end
			end
		end
		
		checkUpdateUI()
		
		-- Visible UI
		upgradeTileFrame.Visible = true
		
	end
	
end

---- UPGRADE BUTTON
upgradeTileButton.MouseButton1Click:Connect(function()
	local MAXLEVEL = 4

	if debouncingButton then
		return
	end

	debouncingButton = true
	
	if price == "MAX" then
		costText.Text = price
		return
	end
	

	if _G.gameData.tilesList[tileIndex].level > MAXLEVEL then
		return
	end

	if _G.gameData.coins >= price then
		_G.gameData.coins -= price
		_G.gameData.tilesList[tileIndex].level += LEVELUP
		local newLevel = _G.gameData.tilesList[tileIndex].level
		_G.gameData.tilesList[tileIndex]:verifyLevel(newLevel)
		costText.Text = _G.gameData.tilesList[tileIndex].price
		local nextImageID = _G.gameData.tilesList[tileIndex].nextImageID
		imageLabel.Image = nextImageID
		price = _G.gameData.tilesList[tileIndex].price
	end 

	wait(1)
	debouncingButton = false
end)


exitButton.Activated:Connect(function()
	upgradeTileFrame.Visible = false
	debouncingProximity = false
end)

ProximityPrompt.PromptTriggered:Connect(onPromptTrigerred)