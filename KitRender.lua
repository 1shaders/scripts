local v0 = cloneref or function(v) return v end

local v1 = v0(game:GetService("Players"))
local v2 = v0(game:GetService("RunService"))
local v3 = v0(game:GetService("ReplicatedStorage"))

local v4 = v1.LocalPlayer
local v5 = require(v3.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta

local v6 = {}
local v7 = {}

local function v8()
    return v4.PlayerGui:FindFirstChild("MatchDraftApp")
end

local function v9(v10, v11, v12)
    local v13 = v10
    for v14 = 1, v12 do
        v13 = v13.Parent
        if not v13 then return nil end
        if v13.Name == v11 then return v13 end
    end
    return nil
end

local function v15(v16, v17)
    local v18 = v7[v16]
    if v18 then
        v18.Image = v17
    else
        v18 = Instance.new("ImageLabel")
        v18.Name = "KitRender"
        v18.Size = UDim2.new(1, 0, 1, 0)
        v18.Position = UDim2.new(1.1, 0, 0, 0)
        v18.BackgroundTransparency = 1
        v18.Image = v17
        v18.Parent = v16
        v7[v16] = v18
    end
end

local function v19(v20)
    local v21 = v6[v20]
    if v21 then
        v21:Disconnect()
        v6[v20] = nil
    end
end

local function v22(v23, v24)
    if not v24 or not v24.Parent then
        v19(v23.UserId)
        local v25 = v7[v24]
        if v25 then
            v25:Destroy()
            v7[v24] = nil
        end
        return
    end

    local v26 = v23:GetAttribute("PlayingAsKits") or "none"
    local v27 = v5[v26] or v5.none
    v15(v24, v27.renderImage)
end

local function v28(v29)
    if v29.Name ~= "PlayerRender" then return end

    if not v9(v29, "MatchDraftTeamCardRow", 5) then return end

    local v30 = v29.Parent and v29.Parent:FindFirstChild("3")
    if not v30 then return end

    local v31 = tonumber(v29.Image:match("id=(%d+)"))
    if not v31 then return end

    local v32 = v1:GetPlayerByUserId(v31)
    if not v32 then return end

    if v6[v32.UserId] then return end

    v22(v32, v30)

    v6[v32.UserId] = v32:GetAttributeChangedSignal("PlayingAsKits"):Connect(function()
        v22(v32, v30)
    end)
end

local function v33(v34)
    for v35, v36 in v34:GetDescendants() do
        task.spawn(v28, v36)
    end

    v34.DescendantAdded:Connect(function(v37)
        task.spawn(v28, v37)
    end)
end

v1.PlayerRemoving:Connect(function(v38)
    v19(v38.UserId)
end)

local v39 = false
v2.Heartbeat:Connect(function()
    if v39 then return end

    local v40 = v8()
    if not v40 then return end

    v39 = true
    v33(v40)

    v40.AncestryChanged:Connect(function()
        if not v40.Parent then
            v39 = false
        end
    end)
end)
