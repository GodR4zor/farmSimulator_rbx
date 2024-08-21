local RP = game:GetService("ReplicatedStorage")
local houseModel = RP.houseModel
local houseControl = RP.housesControl

local function houseRun()
	if _G.gameData.actuallyHouse == nil then return end
	
	local houseInWorkspace = workspace.house:FindFirstChild(_G.gameData.actuallyHouse)
	
	if houseInWorkspace then return end
	
	for _,v in pairs(workspace.house:GetChildren()) do v:Destroy() end
	
	for _,houses in pairs(houseModel:GetChildren()) do
		if houses.Name == _G.gameData.actuallyHouse then
			local houseClone = houses:Clone()
			houseClone.Parent = workspace.house
		end
	end
end

return houseRun