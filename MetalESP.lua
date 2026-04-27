repeat task.wait() until game:IsLoaded()
 
local v1 = shared.Keybind or Enum.KeyCode.RightShift
local v2 = game:GetService("CollectionService")
local v3 = game:GetService("Players").LocalPlayer
 
local v4 = {
    ["iron"] = "rbxassetid://6850537969",
    ["bee"] = "rbxassetid://7343272839",
    ["natures_essence_1"] = "rbxassetid://11003449842",
    ["thorns"] = "rbxassetid://9134549615",
    ["mushrooms"] = "rbxassetid://9134534696",
    ["wild_flower"] = "rbxassetid://9134545166",
    ["crit_star"] = "rbxassetid://9866757805",
    ["vitality_star"] = "rbxassetid://9866757969",
    ["alchemy_crystal"] = "rbxassetid://9866757969",
    ["blackmarket_coin"] = "rbxassetid://18938976671"
}
 
local v5 = {
    ["hidden-metal"] = "iron",
    ["bee"] = "bee",
    ["treeOrb"] = "natures_essence_1",
    ["alchemy_crystal"] = "alchemy_crystal",
    ["shadow_coin"] = "blackmarket_coin",
    ["blackmarket_coin"] = "blackmarket_coin"
}
 
local v6 = {
    ["Thorns"] = "thorns",
    ["Mushrooms"] = "mushrooms",
    ["Flower"] = "wild_flower",
    ["CritStar"] = "crit_star",
    ["VitalityStar"] = "vitality_star",
    ["ShadowCoin"] = "blackmarket_coin"
}
 
local v7 = Instance.new("ScreenGui")
v7.Name = game:GetService("HttpService"):GenerateGUID(false)
v7.ResetOnSpawn = false
v7.Parent = v3.PlayerGui
 
local v8 = {}
 
local function v9(v10, v11)
    if v8[v10] then return end
    local v12 = v10:IsA("Model") and (v10.PrimaryPart or v10:FindFirstChildWhichIsA("BasePart")) or v10
    if not v12 then return end
 
    local v13 = Instance.new("BillboardGui")
    v13.Adornee = v12
    v13.Size = UDim2.new(0, 50, 0, 50)
    v13.StudsOffsetWorldSpace = Vector3.new(0, 3, 1.5)
    v13.AlwaysOnTop = true
    v13.Parent = v7
 
    local v14 = Instance.new("ImageLabel")
    v14.Size = UDim2.new(1, 0, 1, 0)
    v14.BackgroundTransparency = 0.5
    v14.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    v14.Image = v4[v11] or ""
    v14.Parent = v13
    
    Instance.new("UICorner", v14).CornerRadius = UDim.new(0, 4)
    v8[v10] = v13
end
 
for v15, v16 in pairs(v5) do
    v2:GetInstanceAddedSignal(v15):Connect(function(v17) v9(v17, v16) end)
    v2:GetInstanceRemovedSignal(v15):Connect(function(v17) if v8[v17] then v8[v17]:Destroy() v8[v17] = nil end end)
    for _, v17 in pairs(v2:GetTagged(v15)) do v9(v17, v16) end
end
 
workspace.ChildAdded:Connect(function(v18) if v6[v18.Name] then v9(v18, v6[v18.Name]) end end)
workspace.ChildRemoved:Connect(function(v18) if v8[v18] then v8[v18]:Destroy() v8[v18] = nil end end)
for _, v18 in pairs(workspace:GetChildren()) do if v6[v18.Name] then v9(v18, v6[v18.Name]) end end
 
game:GetService("UserInputService").InputBegan:Connect(function(v19, v20)
    if v20 then return end
    if v19.KeyCode == (typeof(v1) == "string" and Enum.KeyCode[v1] or v1) then
        v7.Enabled = not v7.Enabled
    end
end)
 