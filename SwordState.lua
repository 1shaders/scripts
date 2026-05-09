local v0 = getgenv().spoof
local v1 = getgenv().swordtype
local v3 = cloneref(game:GetService("RunService"))

local success, err = pcall(function()
    local v4 = workspace:WaitForChild(v0)
    local v2 = v4:WaitForChild("HandInvItem")
    local v5 = game:GetService("ReplicatedStorage"):FindFirstChild(v1, true)

    print("user --> " .. v0)
    print("--> " .. tostring(v2))
    print("--> " .. tostring(v4))

    if v2 and v5 then
        for _, v in next, getconnections(v2.Changed) do 
            v:Disable() 
        end

        v3.RenderStepped:Connect(function()
            if v2 and v2.Parent then
                v2.Value = v5
            end
        end)

        v2.Value = v5
    else
        error("broken")
    end
end)

if not success then
    setclipboard(tostring(err))
    warn("fail: " .. tostring(err))
end
