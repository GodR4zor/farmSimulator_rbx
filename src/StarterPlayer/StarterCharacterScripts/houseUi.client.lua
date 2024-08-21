local proximityPrompt = game:GetService("ProximityPromptService")
local player = game:GetService("Players").LocalPlayer
local houses = require(game:GetService("ReplicatedStorage").housesControl)

local BUY_STAGE = "Buy"
local ACTUALLY_HOUSE = nil

--Frames
local playerUi = player:FindFirstChild("PlayerGui")
local buyHouse = playerUi:FindFirstChild("buyHouse")
local Background = buyHouse:FindFirstChild("background")
local buyground = Background:FindFirstChild("buyground")

--houses
local First = buyground:FindFirstChild("First")
local Secund = buyground:FindFirstChild("Secund")
local Thirth = buyground:FindFirstChild("Thirth")

local houseTable = {First,Secund,Thirth}

--Buttons
local close = Background:FindFirstChild("close")
local openclose = buyHouse:FindFirstChild("open/close")
local buy = Background:FindFirstChild("buyButton")

close.Activated:Connect(function()
	Background.Visible = false
end)

openclose.Activated:Connect(function()
	Background.Visible = not Background.Visible
end)

local function checkHousesInPlayer()
	if ACTUALLY_HOUSE == nil then return end
	local has = false
	for _,v in pairs(_G.gameData.houses) do
		if v == ACTUALLY_HOUSE.name then has = true end
	end
	return has
end

local function equipOrUnequip()
	if BUY_STAGE == "Buy" then
		buy.Text = "Buy"
		buy.Interactable = true
		buy.BackgroundColor3 = Color3.new(0.196078, 1, 0.137255)
		buy.TextColor3 = Color3.new(1, 1, 1)
	elseif BUY_STAGE == "Equip" then
		buy.Text = "Equip"
		buy.Interactable = true
		buy.BackgroundColor3 = Color3.new(0.0823529, 0.647059, 1)
		buy.TextColor3 = Color3.new(1, 1, 1)
	elseif BUY_STAGE == "Equiped" then
		buy.Text = "Equiped"
		buy.Interactable = false
		buy.BackgroundColor3 = Color3.new(0.454902, 0.027451, 0.027451)
		buy.TextColor3 = Color3.new(0.541176, 0.541176, 0.541176)
	end
end

local function setEffectInUiImage(i)
	for j = 1,#houseTable,1 do
		houseTable[j]:FindFirstChild("ImageButton").ImageColor3 = Color3.new(1, 1, 1)
		if i == j then
			local ImageButton = houseTable[i]:FindFirstChild("ImageButton")
			ImageButton.ImageColor3 = Color3.new(0.670588, 0.670588, 0.670588)
		end
	end
end

for i = 1,#houseTable,1 do
	houseTable[i]:FindFirstChild("TextLabel").Text = "$"..houses[i].price
	houseTable[i]:FindFirstChild("ImageButton").Image = houses[i].id
	houseTable[i]:FindFirstChild("ImageButton").Activated:Connect(function()
		ACTUALLY_HOUSE = houses[i]
		setEffectInUiImage(i)
		if checkHousesInPlayer() and ACTUALLY_HOUSE.name == _G.gameData.actuallyHouse then
			BUY_STAGE = "Equiped"
		elseif checkHousesInPlayer()  then
			BUY_STAGE = "Equip"
		else
			BUY_STAGE = "Buy"
		end
		equipOrUnequip()
	end)
end

buy.Activated:Connect(function()
	if ACTUALLY_HOUSE == nil then return end
	if not checkHousesInPlayer() and _G.gameData.coins >= ACTUALLY_HOUSE.price then
		_G.gameData.coins = _G.gameData.coins - ACTUALLY_HOUSE.price
		table.insert(_G.gameData.houses,ACTUALLY_HOUSE.name)
		BUY_STAGE = "Equip"
		equipOrUnequip()
	elseif BUY_STAGE == "Equip" then
		_G.gameData.actuallyHouse = ACTUALLY_HOUSE.name
		BUY_STAGE = "Equiped"
		equipOrUnequip()
	end
end)