local success, err = pcall(function()
    repeat task.wait() until getgenv().spoof ~= nil
    
    local v0 = getgenv().spoof
    local v1 = getgenv().swordtype
    local v3 = cloneref(game:GetService("RunService"))

    local v4 = workspace:WaitForChild(tostring(v0), 10)
    local v2 = v4:WaitForChild("HandInvItem", 10)
    
    local v5 = game:GetService("ReplicatedStorage"):FindFirstChild(v1 or "wood_sword", true)

    print("user --> " .. tostring(v0))
    print("--> " .. tostring(v2))
    print("--> " .. tostring(v4))

    for _, v in next, getconnections(v2.Changed) do 
        v:Disable() 
    end

    v3.RenderStepped:Connect(function()
        if v2 and v2.Parent then
            v2.Value = v5 or v1 or "wood_sword"
        end
    end)

    v2.Value = v5 or v1 or "wood_sword"
end)

if not success then
    setclipboard(tostring(err))
end
