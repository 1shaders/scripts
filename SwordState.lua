local v0, v1 = getgenv().spoof, getgenv().swordtype
local v3 = cloneref(game:GetService("RunService"))
local v4 = workspace:WaitForChild(v0)
local v2 = v4:WaitForChild("HandInvItem")

print("user --> " .. tostring(v4))
print("--> " .. tostring(v2))
print("--> " .. tostring(v1 or "stone_sword"))

if v2 then
    for _, v in next, getconnections(v2.Changed) do 
        v:Disable() 
    end

    v3.RenderStepped:Connect(function()
        if v2 and v2.Parent then
            v2.Value = v1 or "stone_sword"
        end
    end)

    v2.Value = v1 or "stone_sword"
end
