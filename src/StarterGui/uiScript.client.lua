-- Services
local RunService = game:GetService("RunService")

wait(1)

local coinsLabel = script.Parent.GameGui.CoinsText

local lastCoins = -1

local function updateUi(deltatime)
	wait(1)
	local coins = _G.gameData.coins
	local text = string.format("Coins: %d", coins)
	
	if coins ~= lastCoins then
		lastCoins = coins
		coinsLabel.Text = text
	end
end

RunService.Heartbeat:Connect(updateUi)