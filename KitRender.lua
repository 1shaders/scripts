-- ***********************************************************
-- * ,--.       ,--.                ,--.                     *
-- */   | ,---. |  ,---.  ,--,--. ,-|  | ,---. ,--.--. ,---. *
-- *`|  |(  .-' |  .-.  |' ,-.  |' .-. || .-. :|  .--'(  .-' *
-- * |  |.-'  `)|  | |  |\ '-'  |\ `-' |\   --.|  |   .-'  `)*
-- * `--'`----' `--' `--' `--`--' `---'  `----'`--'   `----' *
-- * https://www.youtube.com/@1shaders                       *
-- * Discord @ 1shaders                                      *
-- ***********************************************************

local cloneref = cloneref or function(v) return v end

local Players    = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local RS         = cloneref(game:GetService("ReplicatedStorage"))

local lplr    = Players.LocalPlayer
local kitMeta = require(RS.TS.games.bedwars.kit["bedwars-kit-meta"]).BedwarsKitMeta

local connections      = {}
local icons            = {}
local loops            = {}
local debounce         = {}
local active           = false

local function getKitImage(plr)
    local kit  = plr:GetAttribute("PlayingAsKits") or "none"
    local meta = kitMeta[kit] or kitMeta.none
    return meta and meta.renderImage or ""
end

local function cleanup()
    for _, conn in pairs(connections) do conn:Disconnect() end
    connections = {}
    icons       = {}
    for k in pairs(loops)   do loops[k]   = nil end
    for k in pairs(debounce) do debounce[k] = nil end
end

-- Squads mode

local function updateSquadsIcon(slot, plr)
    if not slot or not slot.Parent then return end
    local img      = getKitImage(plr)
    local existing = icons[slot]
    if existing and existing.Parent then
        existing.Image = img
    else
        local icon = Instance.new("ImageLabel")
        icon.Name               = "KitRender"
        icon.Size               = UDim2.new(1, 0, 1, 0)
        icon.Position           = UDim2.new(1.1, 0, 0, 0)
        icon.BackgroundTransparency = 1
        icon.Image              = img
        icon.Parent             = slot
        icons[slot]             = icon
    end
end

local function setupSquadsIcon(obj)
    if obj.Name ~= "PlayerRender" then return end

    local p = obj
    local found = false
    for _ = 1, 5 do
        p = p.Parent
        if not p then return end
        if p.Name == "MatchDraftTeamCardRow" then found = true break end
    end
    if not found then return end

    local slot = obj.Parent and obj.Parent:FindFirstChild("3")
    if not slot then return end

    local userId = tonumber(string.match(obj.Image, "id=(%d+)"))
    if not userId then return end

    local plr = Players:GetPlayerByUserId(userId)
    if not plr then return end

    if connections[plr.UserId] then return end

    updateSquadsIcon(slot, plr)

    connections[plr.UserId] = plr:GetAttributeChangedSignal("PlayingAsKits"):Connect(function()
        local t = tick()
        if not debounce[plr.UserId] or (t - debounce[plr.UserId]) >= 0.1 then
            debounce[plr.UserId] = t
            updateSquadsIcon(slot, plr)
        end
    end)
end

local function setupSquads(app)
    task.wait(0.5)
    for _, obj in app:GetDescendants() do
        task.spawn(setupSquadsIcon, obj)
    end
    app.DescendantAdded:Connect(function(obj)
        task.wait(0.1)
        setupSquadsIcon(obj)
    end)
end

-- Regular mode (5v5 / duos)

local function findPlayer(label, container)
    local render = container:FindFirstChild("PlayerRender", true)
    if render and render:IsA("ImageLabel") then
        local userId = string.match(render.Image or "", "id=(%d+)")
        if userId then
            local plr = Players:GetPlayerByUserId(tonumber(userId))
            if plr then return plr end
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name == label.Text or plr.DisplayName == label.Text then return plr end
    end
end

local function handleLabel(label)
    if not (label:IsA("TextLabel") and label.Name == "PlayerName") then return end
    task.spawn(function()
        local container = label.Parent
        for _ = 1, 3 do
            if container then container = container.Parent end
        end
        if not container or not container:IsA("Frame") then return end

        local plr = findPlayer(label, container)
        if not plr then
            task.wait(0.5)
            plr = findPlayer(label, container)
        end
        if not plr then return end

        local card = container:FindFirstChild("1") and container["1"]:FindFirstChild("MatchDraftPlayerCard")
        if not card then return end

        local icon = card:FindFirstChild("KitRender")
        if not icon then
            icon = Instance.new("ImageLabel")
            icon.Name               = "KitRender"
            icon.AnchorPoint        = Vector2.new(1, 0.5)
            icon.BackgroundTransparency = 1
            icon.Position           = UDim2.new(1.05, 0, 0.5, 0)
            icon.Size               = UDim2.new(1.5, 0, 1.5, 0)
            icon.SizeConstraint     = Enum.SizeConstraint.RelativeYY
            icon.Parent             = card
            local uar = Instance.new("UIAspectRatioConstraint")
            uar.AspectRatio   = 1
            uar.AspectType    = Enum.AspectType.FitWithinMaxSize
            uar.DominantAxis  = Enum.DominantAxis.Width
            uar.Parent        = icon
        end

        icon.Image = getKitImage(plr)

        local key = plr.UserId
        if loops[key] then return end
        loops[key] = true
        task.spawn(function()
            while loops[key] do
                if not container or not container.Parent then break end
                if icon and icon.Parent then
                    local img = getKitImage(plr)
                    if icon.Image ~= img then icon.Image = img end
                end
                task.wait(0.3)
            end
            loops[key] = nil
        end)
    end)
end

local function setupRegular(app)
    for _, child in ipairs(app:GetDescendants()) do
        handleLabel(child)
    end
    app.DescendantAdded:Connect(function(child)
        handleLabel(child)
    end)
end

-- Main loop

Players.PlayerRemoving:Connect(function(plr)
    local conn = connections[plr.UserId]
    if conn then conn:Disconnect() connections[plr.UserId] = nil end
    loops[plr.UserId]   = nil
    debounce[plr.UserId] = nil
end)

RunService.Heartbeat:Connect(function()
    if active then return end
    local app = lplr.PlayerGui:FindFirstChild("MatchDraftApp")
    if not app then return end

    active = true
    local isSquads = app:FindFirstChild("MatchDraftTeamCardRow", true) ~= nil

    if isSquads then
        setupSquads(app)
    else
        setupRegular(app)
    end

    app.AncestryChanged:Connect(function()
        if not app.Parent then
            active = false
            cleanup()
        end
    end)
end)
