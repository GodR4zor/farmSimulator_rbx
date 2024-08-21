local RP = game:GetService("ReplicatedStorage")
local houseModel = RP:FindFirstChild("houseModel")

local houses = {
	{name = houseModel.First.Name,price = 100,model = houseModel.First,id = "rbxassetid://135490025149111"},
	{name = houseModel.Secund.Name,price = 1000,houseModel.Secund,id = "rbxassetid://101205320899673"},
	{name = houseModel.Thirth.Name,price = 5000,houseModel.Thirth,id = "rbxassetid://94212464661494"},
}

return houses