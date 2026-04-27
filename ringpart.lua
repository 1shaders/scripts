return function(v0)
    v0 = v0 or {}
    local v1 = v0.silent or false
 
local v2 = cloneref or function(v) return v end
 
local v3 = v2(game:GetService("Players"))
local v4 = v2(game:GetService("RunService"))
local v5 = v2(game:GetService("UserInputService"))
 
local v6 = v3.LocalPlayer
local v7 = string.format("%x", math.random(0x100000, 0xFFFFFF))
 
local v8 = {
    radius = 50,
    height = 100,
    speed = 10,
    strength = 1000,
    enabled = false
}
 
local v9 = {}
 
local function v10(v11)
    if not v11:IsA("BasePart") then return false end
    if v11.Anchored then return false end
    if not v11:IsDescendantOf(workspace) then return false end
    if v11.Parent == v6.Character or v11:IsDescendantOf(v6.Character) then return false end
    return true
end
 
local function v12(v13)
    if v10(v13) then
        if not table.find(v9, v13) then
            v13.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            v13.CanCollide = false
            table.insert(v9, v13)
        end
    end
end
 
local function v14(v15)
    local v16 = table.find(v9, v15)
    if v16 then
        table.remove(v9, v16)
    end
end
 
for v17, v18 in pairs(workspace:GetDescendants()) do
    v12(v18)
end
 
workspace.DescendantAdded:Connect(v12)
workspace.DescendantRemoving:Connect(v14)
 
if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }
    v6.ReplicationFocus = workspace
    v4.Heartbeat:Connect(function()
        sethiddenproperty(v6, "SimulationRadius", math.huge)
        for v19, v20 in pairs(getgenv().Network.BaseParts) do
            if v20:IsDescendantOf(workspace) then
                v20.Velocity = getgenv().Network.Velocity
            end
        end
    end)
end
 
v4.Heartbeat:Connect(function()
    if not v8.enabled then return end
    
    local v21 = v6.Character and v6.Character:FindFirstChild("HumanoidRootPart")
    if not v21 then return end
    
    local v22 = v21.Position
    
    for v23, v24 in pairs(v9) do
        if v24.Parent and not v24.Anchored then
            local v25 = v24.Position
            local v26 = Vector3.new(v25.X, v22.Y, v25.Z)
            local v27 = (v26 - v22).Magnitude
            
            if v27 > 0.1 then
                local v28 = math.atan2(v25.Z - v22.Z, v25.X - v22.X)
                local v29 = v28 + math.rad(v8.speed)
                local v30 = math.min(v8.radius, v27)
                
                local v31 = Vector3.new(
                    v22.X + math.cos(v29) * v30,
                    v22.Y + (v8.height * math.abs(math.sin((v25.Y - v22.Y) / v8.height))),
                    v22.Z + math.sin(v29) * v30
                )
                
                local v32 = (v31 - v24.Position).Unit
                v24.Velocity = v32 * v8.strength
            end
        end
    end
end)
 
local v33 = Instance.new("ScreenGui")
v33.Name = v7
v33.ResetOnSpawn = false
v33.Parent = v6:WaitForChild("PlayerGui")
 
local v34 = Instance.new("Frame")
v34.Size = UDim2.new(0, 200, 0, 150)
v34.Position = UDim2.new(0.5, -100, 0.5, -75)
v34.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
v34.BorderSizePixel = 0
v34.Parent = v33
 
local v35 = Instance.new("UICorner")
v35.CornerRadius = UDim.new(0, 12)
v35.Parent = v34
 
local v36 = Instance.new("TextLabel")
v36.Size = UDim2.new(1, 0, 0, 30)
v36.Position = UDim2.new(0, 0, 0, 0)
v36.Text = "Tornado"
v36.TextColor3 = Color3.fromRGB(255, 255, 255)
v36.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
v36.Font = Enum.Font.GothamBold
v36.TextSize = 16
v36.Parent = v34
 
local v37 = Instance.new("UICorner")
v37.CornerRadius = UDim.new(0, 12)
v37.Parent = v36
 
local v38 = Instance.new("TextButton")
v38.Size = UDim2.new(0.9, 0, 0, 35)
v38.Position = UDim2.new(0.05, 0, 0, 40)
v38.Text = "OFF"
v38.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
v38.TextColor3 = Color3.fromRGB(255, 255, 255)
v38.Font = Enum.Font.GothamBold
v38.TextSize = 14
v38.Parent = v34
 
local v39 = Instance.new("UICorner")
v39.CornerRadius = UDim.new(0, 8)
v39.Parent = v38
 
local v40 = Instance.new("Frame")
v40.Size = UDim2.new(0.9, 0, 0, 35)
v40.Position = UDim2.new(0.05, 0, 0, 85)
v40.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
v40.BorderSizePixel = 0
v40.Parent = v34
 
local v41 = Instance.new("UICorner")
v41.CornerRadius = UDim.new(0, 8)
v41.Parent = v40
 
local v42 = Instance.new("TextButton")
v42.Size = UDim2.new(0.15, 0, 1, 0)
v42.Position = UDim2.new(0, 0, 0, 0)
v42.Text = "-"
v42.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
v42.TextColor3 = Color3.fromRGB(255, 255, 255)
v42.Font = Enum.Font.GothamBold
v42.TextSize = 18
v42.Parent = v40
 
local v43 = Instance.new("UICorner")
v43.CornerRadius = UDim.new(0, 8)
v43.Parent = v42
 
local v44 = Instance.new("TextLabel")
v44.Size = UDim2.new(0.7, 0, 1, 0)
v44.Position = UDim2.new(0.15, 0, 0, 0)
v44.Text = "Radius: 50"
v44.BackgroundTransparency = 1
v44.TextColor3 = Color3.fromRGB(255, 255, 255)
v44.Font = Enum.Font.Gotham
v44.TextSize = 14
v44.Parent = v40
 
local v45 = Instance.new("TextButton")
v45.Size = UDim2.new(0.15, 0, 1, 0)
v45.Position = UDim2.new(0.85, 0, 0, 0)
v45.Text = "+"
v45.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
v45.TextColor3 = Color3.fromRGB(255, 255, 255)
v45.Font = Enum.Font.GothamBold
v45.TextSize = 18
v45.Parent = v40
 
local v46 = Instance.new("UICorner")
v46.CornerRadius = UDim.new(0, 8)
v46.Parent = v45
 
local v47 = Instance.new("TextButton")
v47.Size = UDim2.new(0, 25, 0, 25)
v47.Position = UDim2.new(1, -30, 0, 2.5)
v47.Text = "-"
v47.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
v47.TextColor3 = Color3.fromRGB(255, 255, 255)
v47.Font = Enum.Font.GothamBold
v47.TextSize = 16
v47.Parent = v34
 
local v48 = Instance.new("UICorner")
v48.CornerRadius = UDim.new(0, 6)
v48.Parent = v47
 
local v49 = false
v47.MouseButton1Click:Connect(function()
    v49 = not v49
    if v49 then
        v34:TweenSize(UDim2.new(0, 200, 0, 30), "Out", "Quad", 0.2, true)
        v47.Text = "+"
        v38.Visible = false
        v40.Visible = false
    else
        v34:TweenSize(UDim2.new(0, 200, 0, 150), "Out", "Quad", 0.2, true)
        v47.Text = "-"
        v38.Visible = true
        v40.Visible = true
    end
end)
 
local v50
local v51
local v52
local v53
 
local function v54(v55)
    local v56 = v55.Position - v52
    v34.Position = UDim2.new(v53.X.Scale, v53.X.Offset + v56.X, v53.Y.Scale, v53.Y.Offset + v56.Y)
end
 
v34.InputBegan:Connect(function(v55)
    if v55.UserInputType == Enum.UserInputType.MouseButton1 or v55.UserInputType == Enum.UserInputType.Touch then
        v50 = true
        v52 = v55.Position
        v53 = v34.Position
        
        v55.Changed:Connect(function()
            if v55.UserInputState == Enum.UserInputState.End then
                v50 = false
            end
        end)
    end
end)
 
v34.InputChanged:Connect(function(v55)
    if v55.UserInputType == Enum.UserInputType.MouseMovement or v55.UserInputType == Enum.UserInputType.Touch then
        v51 = v55
    end
end)
 
v5.InputChanged:Connect(function(v55)
    if v55 == v51 and v50 then
        v54(v55)
    end
end)
 
v38.MouseButton1Click:Connect(function()
    v8.enabled = not v8.enabled
    v38.Text = v8.enabled and "ON" or "OFF"
    v38.BackgroundColor3 = v8.enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)
 
v42.MouseButton1Click:Connect(function()
    v8.radius = math.max(10, v8.radius - 5)
    v44.Text = "Radius: " .. v8.radius
end)
 
v45.MouseButton1Click:Connect(function()
    v8.radius = math.min(150, v8.radius + 5)
    v44.Text = "Radius: " .. v8.radius
end)
 
end