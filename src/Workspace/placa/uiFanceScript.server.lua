local parent:Model = script.Parent
local proximity = parent.build


local function onTrigerred(player:Player)
	local playerGui = player:WaitForChild("PlayerGui")
	local screenGui = playerGui:WaitForChild("buyFance")

	screenGui.Enabled = true
end

proximity.Triggered:Connect(onTrigerred)