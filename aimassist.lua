local Players = game:GetService('Players')
local Workspace = game:GetService('Workspace')
local UserInputService = game:GetService('UserInputService')
local Camera = Workspace.CurrentCamera
local RunService = game:GetService('RunService')

-- Initialize GUI
local screenGui = Instance.new('ScreenGui')
local frame = Instance.new('Frame')
local titleLabel = Instance.new('TextLabel')
local toggleButton = Instance.new('TextButton')
local aimbotEnabled = false
local guiVisible = true
local smoothness = 86 -- Default smoothness value

-- Debug print
print('Setting up GUI gng...')

-- Setup GUI properties
screenGui.Name = 'terrible Aimbot'
screenGui.Parent = Players.LocalPlayer:WaitForChild('PlayerGui')

frame.Size = UDim2.new(0.5, 0, 0.5, 0)
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Parent = screenGui

titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = 'teribble Aimbot'
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextScaled = true
titleLabel.Parent = frame

toggleButton.Size = UDim2.new(0.5, 0, 0.2, 0)
toggleButton.Position = UDim2.new(0.25, 0, 0.4, 0)
toggleButton.Text = 'Toggle the worst Aimbot oat :fire:'
toggleButton.Parent = frame

-- Toggle button functionality
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    toggleButton.Text = aimbotEnabled and 'Aimbot ON' or 'Aimbot OFF'
    print('Aimbot toggled: ' .. tostring(aimbotEnabled))
end

toggleButton.MouseButton1Click:Connect(toggleAimbot)

-- Function to toggle GUI visibility
local function toggleGui()
    guiVisible = not guiVisible
    screenGui.Enabled = guiVisible
    print('GUI visibility toggled: ' .. tostring(guiVisible))
end

-- Key press functionality
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.RightShift then
            toggleGui()
        elseif input.KeyCode == Enum.KeyCode.Q then
            toggleAimbot()
        end
    end
end)

-- Aimbot functionality
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local myPosition = Camera.CFrame.Position
    local myTeam = Players.LocalPlayer.Team

    for _, player in ipairs(Players:GetPlayers()) do
        if
            player ~= Players.LocalPlayer
            and player.Team ~= myTeam
            and player.Character
        then
            local torso = player.Character:FindFirstChild('UpperTorso')
                or player.Character:FindFirstChild('UpperTorso')
            if torso then
                local torsoPosition = torso.Position
                local distance = (myPosition - torsoPosition).magnitude

                if distance < shortestDistance and distance <= 28 then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end

local function aimbot()
    if aimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character then
            local torso = target.Character:FindFirstChild('UpperTorso')
                or target.Character:FindFirstChild('UpperTorso')
            if torso then
                local targetPosition = torso.Position
                local currentPosition = Camera.CFrame.Position
                local direction = (targetPosition - currentPosition).unit

                -- Smooth aimbot logic for first-person and third-person
                if
                    UserInputService.MouseBehavior
                    == Enum.MouseBehavior.LockCenter
                then
                    -- First-person mode adjustments
                    Camera.CFrame = CFrame.new(currentPosition, targetPosition)
                else
                    -- Third-person mode adjustments
                    local smoothPosition =
                        Camera.CFrame.Position:Lerp(targetPosition, smoothness)
                    Camera.CFrame = CFrame.new(smoothPosition, targetPosition)
                end
            end
        end
    end
end

-- Update aimbot on every frame
RunService.RenderStepped:Connect(function()
    aimbot()
end)

-- Shooting functionality
local function onMouseClick()
    if aimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character then
            local torso = target.Character:FindFirstChild('UpperTorso')
                or target.Character:FindFirstChild('UpperTorso')
            if torso then
                -- Simulate shooting (example: fire a projectile or call a function)
                -- For example, you might trigger a RemoteEvent to shoot:
                -- game.ReplicatedStorage.ShootEvent:FireServer(torso.Position)
            end
        end
    end
end

-- Handle mouse click
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if
        not gameProcessedEvent
        and input.UserInputType == Enum.UserInputType.MouseButton1
    then
        onMouseClick()
    end
end)

-- Debug print to confirm script execution
print('Script loaded successfully!')
