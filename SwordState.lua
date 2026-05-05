local v0 = getgenv().spoof
local v1 = getgenv().swordtype
local v2 = workspace:WaitForChild(v0):WaitForChild("HandInvItem")
local v3 = cloneref(game:GetService("RunService"))

for _, v in next, getconnections(v2.Changed) do 
    v:Disable() 
end

v3.RenderStepped:Connect(function()
    if v2 and v2.Parent then
        v2.Value = v1
    end
end)

v2.Value = v1
