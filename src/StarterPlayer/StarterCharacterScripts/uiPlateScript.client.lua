-- Services
local ProximityPrompt = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- CONSTANTS
local LINEPRICE = 100

-- Local Player
local player:Player = Players.LocalPlayer

-- Tile Module
local tile = require(ReplicatedStorage.tileClass)

local tilesModel = ReplicatedStorage.tilesModel
local tilesLine = tilesModel.tilesLines

local lines = {tilesLine["line 2"], tilesLine["line 3"], tilesLine["line 4"], tilesLine["line 5"], tilesLine["line 6"], tilesLine["line 7"],
	tilesLine["line 8"], tilesLine["line 9"], tilesLine["line 10"]}

-- Plate
local platePast = ReplicatedStorage.terrainPlates

local platesArray = {platePast["buyLine 3"], platePast["buyLine 4"], platePast["buyLine 5"], platePast["buyLine 6"],
	platePast["buyLine 7"], platePast["buyLine 8"], platePast["buyLine 9"], platePast["buyLine 10"]}


-- UI UPGRADE
local playerGui = player:WaitForChild("PlayerGui")
local buyLineTile:ScreenGui = playerGui:WaitForChild("buyLineTile")
local lineTileFrame:Frame = buyLineTile:WaitForChild("lineTileFrame")
local buyLineButton:TextButton = lineTileFrame:WaitForChild("buyLineButton")
local priceText:TextLabel = lineTileFrame:WaitForChild("priceText")
local exitButton:TextButton = lineTileFrame:WaitForChild("exitButton")


-- Plate Settings
local plate
local lineValue = 1
local plateIndex = 1

local function onTrigerred(proximityObject:ProximityPrompt, player:Player)

	if proximityObject.Name ~= "buildTerrain" then
		return
	end

	plate = proximityObject.Parent
	
	priceText.Text = LINEPRICE
	
	lineTileFrame.Visible = true
end

-- Button Settings
local debouncingButton = false

local function onButtonActivated()
	
	if _G.gameData.coins < LINEPRICE then
		return
	end
	
	debouncingButton = true
	
	_G.gameData.coins -= LINEPRICE
	LINEPRICE += 100
	priceText.Text = LINEPRICE
	
	lines[lineValue].Parent = workspace.Tiles

	local tilesModel = lines[lineValue]

	for _, tileInstance in tilesModel:GetChildren() do

		local tileObject = tile:new(tileInstance)
		table.insert(_G.gameData.tilesList, tileObject)
	end
	
	plate:Destroy()
	
	-- Manda a proxima placa pro Workspace
	if platesArray[plateIndex] then
		platesArray[plateIndex].Parent = workspace
		
		plateIndex += 1
	end
	
	lineValue += 1
	
	lineTileFrame.Visible = false
	debouncingButton = false
end

local function onExitButton()
	lineTileFrame.Visible = false
end



buyLineButton.Activated:Connect(onButtonActivated)
exitButton.Activated:Connect(onExitButton)
ProximityPrompt.PromptTriggered:Connect(onTrigerred)
