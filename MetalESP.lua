local v1 = game:GetService("Players")
local v2 = game:GetService("CollectionService")
local v3 = game:GetService("UserInputService")
local v4 = game:GetService("Workspace")

repeat task.wait() until game:IsLoaded()

local v5 = v1.LocalPlayer
local v6 = shared.Keybind or Enum.KeyCode.RightShift
local v7 = {
	["iron"] = "rbxassetid://6850537969",
	["bee"] = "rbxassetid://7343272839",
	["natures_essence"] = "rbxassetid://11003449842",
	["thorns"] = "rbxassetid://9134549615",
	["mushrooms"] = "rbxassetid://9134534696",
	["wild_flower"] = "rbxassetid://9134545166",
	["crit_star"] = "rbxassetid://9866757805",
	["vitality_star"] = "rbxassetid://9866757969",
	["alchemy_crystal"] = "rbxassetid://9866757969"
}

local v8 = {
	["hidden-metal"] = "iron",
	["bee"] = "bee",
	["treeOrb"] = "natures_essence",
	["alchemy_crystal"] = "alchemy_crystal"
}

local v9 = {
	["Thorns"] = "thorns",
	["Mushrooms"] = "mushrooms",
	["Flower"] = "wild_flower",
	["CritStar"] = "crit_star",
	["VitalityStar"] = "vitality_star"
}

local v10 = Instance.new("ScreenGui")
v10.Name = game:GetService("HttpService"):GenerateGUID(false)
v10.ResetOnSpawn = false
v10.Parent = v5:WaitForChild("PlayerGui")

local v11 = {}

local v12 = function(obj, key)
	if not obj or v11[obj] then return end
	local p = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
	if not p then return end

	local b = Instance.new("BillboardGui")
	b.Adornee = p
	b.Size = UDim2.new(0, 26, 0, 26)
	b.AlwaysOnTop = true
	b.Parent = v10

	local i = Instance.new("ImageLabel")
	i.Size = UDim2.new(1, 0, 1, 0)
	i.BackgroundTransparency = 0.5
	i.Image = v7[key] or ""
	i.Parent = b
	Instance.new("UICorner", i)
	
	v11[obj] = b
end

for tag, icon in pairs(v8) do
	v2:GetInstanceAddedSignal(tag):Connect(function(o) v12(o, icon) end)
	v2:GetInstanceRemovedSignal(tag):Connect(function(o) if v11[o] then v11[o]:Destroy() v11[o] = nil end end)
	for _, o in pairs(v2:GetTagged(tag)) do v12(o, icon) end
end

v4.ChildAdded:Connect(function(c) if v9[c.Name] then v12(c, v9[c.Name]) end end)
v4.ChildRemoved:Connect(function(c) if v11[c] then v11[c]:Destroy() v11[c] = nil end end)

for _, c in pairs(v4:GetChildren()) do if v9[c.Name] then v12(c, v9[c.Name]) end end

v3.InputBegan:Connect(function(i, p)
	if p then return end
	if i.KeyCode == (typeof(v6) == "string" and Enum.KeyCode[v6] or v6) then
		v10.Enabled = not v10.Enabled
	end
end)
