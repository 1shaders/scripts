-- ***********************************************************
-- * ,--.       ,--.                ,--.                     *
-- */   | ,---. |  ,---.  ,--,--. ,-|  | ,---. ,--.--. ,---. *
-- *`|  |(  .-' |  .-.  |' ,-.  |' .-. || .-. :|  .--'(  .-' *
-- * |  |.-'  `)|  | |  |\ '-'  |\ `-' |\   --.|  |   .-'  `)*
-- * `--'`----' `--' `--' `--`--' `---'  `----'`--'   `----' *
-- * https://www.youtube.com/@1shaders                       *
-- * Discord @ 1shaders                                      *
-- ***********************************************************

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local KitMeta
pcall(function()
    KitMeta = require(ReplicatedStorage.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta
end)

local function getKitImage(kitName)
    if KitMeta then
        local meta = KitMeta[kitName] or KitMeta["none"]
        if meta then return meta.renderImage end
    end
    return "rbxassetid://16493320215"
end

local activeLoops = {}
local updateDebounce = {}
local connections = {}
local enabled = true

local function createKitIcon(plr)
    local icon = Instance.new("ImageLabel")
    icon.Name = "StandaloneKitRender"
    icon.AnchorPoint = Vector2.new(1, 0.5)
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(1.05, 0, 0.5, 0)
    icon.Size = UDim2.new(1.5, 0, 1.5, 0)
    icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
    icon.ImageTransparency = 0.4
    icon.ScaleType = Enum.ScaleType.Crop
    icon.Image = getKitImage(plr:GetAttribute("PlayingAsKit"))
    local uar = Instance.new("UIAspectRatioConstraint")
    uar.AspectRatio = 1
    uar.AspectType = Enum.AspectType.FitWithinMaxSize
    uar.DominantAxis = Enum.DominantAxis.Width
    uar.Parent = icon
    return icon
end

local function cleanup()
    enabled = false
    for _, c in ipairs(connections) do c:Disconnect() end
    table.clear(connections)
    table.clear(activeLoops)
    table.clear(updateDebounce)
    for _, v in ipairs(PlayerGui:GetDescendants()) do
        if v:IsA("ImageLabel") and v.Name == "StandaloneKitRender" then
            v:Destroy()
        end
    end
end

local function findPlayer(label, container)
    local render = container:FindFirstChild("PlayerRender", true)
    if render and render:IsA("ImageLabel") and render.Image then
        local userId = string.match(render.Image, "id=(%d+)")
        if userId then
            local plr = Players:GetPlayerByUserId(tonumber(userId))
            if plr then return plr end
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name == label.Text or plr.DisplayName == label.Text or plr:GetAttribute("DisguiseDisplayName") == label.Text then
            return plr
        end
    end
end

local function handleLabel(label)
    if not (label:IsA("TextLabel") and label.Name == "PlayerName") then return end
    task.spawn(function()
        local container = label.Parent
        for _ = 1, 3 do
            if container and container.Parent then
                container = container.Parent
            end
        end
        if not container or not container:IsA("Frame") then return end

        local plr = findPlayer(label, container)
        if not plr then
            task.wait(0.5)
            plr = findPlayer(label, container)
        end
        if not plr then return end

        container.Name = plr.Name
        local card = container:FindFirstChild("1") and container["1"]:FindFirstChild("MatchDraftPlayerCard")
        if not card then return end

        local icon = card:FindFirstChild("StandaloneKitRender") or createKitIcon(plr)
        icon.Parent = card

        local loopKey = plr.UserId
        activeLoops[loopKey] = true

        task.spawn(function()
            while activeLoops[loopKey] and container and container.Parent and enabled do
                local now = tick()
                if not updateDebounce[loopKey] or (now - updateDebounce[loopKey]) >= 0.3 then
                    updateDebounce[loopKey] = now
                    local current = findPlayer(label, container)
                    if current then plr = current end
                    if icon and icon.Parent then
                        local img = getKitImage(plr:GetAttribute("PlayingAsKit"))
                        if icon.Image ~= img then icon.Image = img end
                    end
                end
                task.wait(0.3)
            end
            activeLoops[loopKey] = nil
            updateDebounce[loopKey] = nil
        end)
    end)
end

local function setup()
    local ok, team2 = pcall(function()
        return PlayerGui:FindFirstChild("MatchDraftApp")
            and PlayerGui.MatchDraftApp:FindFirstChild("DraftAppBackground")
            and PlayerGui.MatchDraftApp.DraftAppBackground:FindFirstChild("BodyContainer")
            and PlayerGui.MatchDraftApp.DraftAppBackground.BodyContainer:FindFirstChild("Team2Column")
    end)
    if not ok or not team2 then return false end

    for _, child in ipairs(team2:GetDescendants()) do
        handleLabel(child)
    end
    table.insert(connections, team2.DescendantAdded:Connect(handleLabel))
    return true
end

-- retry until the draft UI appears
task.spawn(function()
    while enabled do
        if setup() then break end
        task.wait(1)
    end
end)

-- expose cleanup so callers can do: local stop = require(...) / stop()
return cleanup

