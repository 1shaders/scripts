-- ***********************************************************
-- * ,--.       ,--.                ,--.                     *
-- */   | ,---. |  ,---.  ,--,--. ,-|  | ,---. ,--.--. ,---. *
-- *`|  |(  .-' |  .-.  |' ,-.  |' .-. || .-. :|  .--'(  .-' *
-- * |  |.-'  `)|  | |  |\ '-'  |\ `-' |\   --.|  |   .-'  `)*
-- * `--'`----' `--' `--' `--`--' `---'  `----'`--'   `----' *
-- * https://www.youtube.com/@1shaders                       *
-- * Discord @ 1shaders                                      *
-- ***********************************************************

return function(options)
    options = options or {}
    local silent = options.silent or false
 
local v0 = cloneref or function(v) return v end
 
local v1 = v0(game:GetService("Players"))
local v2 = v0(game:GetService("CollectionService"))
local v3 = v0(game:GetService("RunService"))
local v4 = v0(game:GetService("UserInputService"))
local v5 = v0(game:GetService("ReplicatedStorage"))
local v6 = v0(game:GetService("CoreGui"))
 
local v7 = v1.LocalPlayer
local v8 = Instance.new('Folder')
local v8_name = string.format("%x", math.random(0x100000, 0xFFFFFF))
v8.Name = v8_name
v8.Parent = v6
 
local v9 = {Enabled = true}
local v10 = {Enabled = true}
local v11 = {Enabled = true}
local v12 = {Enabled = true}
local v13 = {Enabled = false}
local v14 = {Enabled = true}
local v15 = {Value = 'Original'}
local v16 = {Enabled = true}
local v17 = {Enabled = true}
 
local v18 = {}
 
local v19 = {
    [1] = {name = "Blue", color = Color3.fromRGB(85, 150, 255)},
    [2] = {name = "Orange", color = Color3.fromRGB(255, 150, 50)},
    [3] = {name = "Pink", color = Color3.fromRGB(255, 100, 200)},
    [4] = {name = "Yellow", color = Color3.fromRGB(255, 255, 50)}
}
 
local v20 = {
    diamond = {
        keywords = {'diamond'},
        color = Color3.fromRGB(85, 200, 255),
        icon = 'diamond',
        displayName = 'Diamond',
        isTeamGen = false
    },
    emerald = {
        keywords = {'emerald'},
        color = Color3.fromRGB(0, 255, 100),
        icon = 'emerald',
        displayName = 'Emerald',
        isTeamGen = false
    }
}
 
local v21 = {
    getIcon = function(v22, v23)
        return nil
    end
}
 
local v24 = Instance.new('ScreenGui')
v24.Name = v8_name
v24.Parent = v6
v24.Enabled = false
v24.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v24.DisplayOrder = 10
v24.ResetOnSpawn = false
 
local v25 = Instance.new('Frame')
v25.Name = 'MainFrame'
v25.Parent = v24
v25.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
v25.BackgroundTransparency = 0.3
v25.BorderSizePixel = 0
v25.Position = UDim2.new(1, -8, 1, -8)
v25.Size = UDim2.new(0, 120, 0, 100)
v25.AnchorPoint = Vector2.new(1, 1)
 
local v26 = Instance.new('UICorner')
v26.CornerRadius = UDim.new(0, 8)
v26.Parent = v25
 
local v27 = Instance.new('TextLabel')
v27.Name = 'Title'
v27.Parent = v25
v27.BackgroundTransparency = 1
v27.Size = UDim2.new(1, 0, 0, 25)
v27.Position = UDim2.new(0, 0, 0, 5)
v27.Text = "GEN ESP"
v27.TextColor3 = Color3.fromRGB(255, 255, 255)
v27.TextSize = 14
v27.Font = Enum.Font.GothamBold
v27.TextStrokeTransparency = 0.5
v27.TextStrokeColor3 = Color3.new(0, 0, 0)
 
local v28 = Instance.new('Frame')
v28.Name = 'DiamondFrame'
v28.Parent = v25
v28.BackgroundTransparency = 1
v28.Size = UDim2.new(1, -20, 0, 25)
v28.Position = UDim2.new(0, 10, 0, 35)
 
local v29 = Instance.new('ImageLabel')
v29.Name = 'DiamondIcon'
v29.Parent = v28
v29.BackgroundTransparency = 1
v29.Size = UDim2.new(0, 18, 0, 18)
v29.Position = UDim2.new(0, 0, 0.5, -9)
 
local v30 = Instance.new('TextLabel')
v30.Name = 'DiamondTimer'
v30.Parent = v28
v30.BackgroundTransparency = 1
v30.Size = UDim2.new(1, -25, 1, 0)
v30.Position = UDim2.new(0, 25, 0, 0)
v30.Text = "00"
v30.TextColor3 = Color3.fromRGB(85, 200, 255)
v30.TextSize = 18
v30.Font = Enum.Font.GothamBold
v30.TextXAlignment = Enum.TextXAlignment.Left
 
local v31 = Instance.new('Frame')
v31.Name = 'EmeraldFrame'
v31.Parent = v25
v31.BackgroundTransparency = 1
v31.Size = UDim2.new(1, -20, 0, 25)
v31.Position = UDim2.new(0, 10, 0, 65)
 
local v32 = Instance.new('ImageLabel')
v32.Name = 'EmeraldIcon'
v32.Parent = v31
v32.BackgroundTransparency = 1
v32.Size = UDim2.new(0, 18, 0, 18)
v32.Position = UDim2.new(0, 0, 0.5, -9)
 
local v33 = Instance.new('TextLabel')
v33.Name = 'EmeraldTimer'
v33.Parent = v31
v33.BackgroundTransparency = 1
v33.Size = UDim2.new(1, -25, 1, 0)
v33.Position = UDim2.new(0, 25, 0, 0)
v33.Text = "00"
v33.TextColor3 = Color3.fromRGB(0, 255, 100)
v33.TextSize = 18
v33.Font = Enum.Font.GothamBold
v33.TextXAlignment = Enum.TextXAlignment.Left
 
local v34 = {}
local v35 = {}
local v36 = {}
 
local function v37()
    local v38 = v7:GetAttribute('Team')
    if v38 == nil then return nil end
    return tonumber(v38)
end
 
local function v39(v40)
    local v41 = string.match(v40, "^(%d+)_generator")
    if v41 then
        return tonumber(v41)
    end
    return nil
end
 
local function v42(v43)
    return string.match(v43, "^%d+_generator") ~= nil
end
 
local function v44(v45)
    local v46 = string.lower(v45)
 
    if v42(v45) then
        return 'teamgen', {
            color = Color3.fromRGB(200, 200, 200),
            icon = 'iron',
            displayName = 'Team Gen',
            isTeamGen = true
        }
    end
 
    for v47, v48 in pairs(v20) do
        for v49, v50 in ipairs(v48.keywords) do
            if v46:find(v50) then
                return v47, v48
            end
        end
    end
    return nil, nil
end
 
local function v51(v52, v53)
    if v52 == 'diamond' then
        return v15.Value == 'Original' and v10.Enabled or (v15.Value == 'Compact' and v16.Enabled)
    elseif v52 == 'emerald' then
        return v15.Value == 'Original' and v11.Enabled or (v15.Value == 'Compact' and v17.Enabled)
    elseif v52 == 'teamgen' then
        if not v12.Enabled then return false end
        local v54 = v37()
        if not v54 or not v53 then return v12.Enabled end
        if v53 == v54 then
            return v13.Enabled
        else
            return v14.Enabled
        end
    end
    return false
end
 
local function v55(v56)
    local v57 = v21.getIcon({itemType = v56}, true)
    if not v57 or v57 == "" then return nil end
    return v57
end
 
local function v58(v59)
    if not v59 then return nil end
    if v59.Name ~= 'GeneratorAdornee' then return nil end
    local v60 = v59:FindFirstChild('RoactTree')
    if not v60 then return nil end
    local v61 = v60:FindFirstChild('TeamOreGeneratorApp')
    if not v61 then return nil end
    local v62 = v61:FindFirstChild('GlobalOreGenerator')
    if v62 then
        for v63, v64 in pairs(v62:GetDescendants()) do
            if v64:IsA('TextLabel') then
                local v65 = v64.Text
                if v65:find("Tier") or v65:match("^[IVX]+$") or v65 == "0" then
                    return v64
                end
            end
        end
    end
    local v66 = v61:FindFirstChild('TeamGenMain')
    if v66 then
        for v67, v68 in pairs(v66:GetDescendants()) do
            if v68:IsA('TextLabel') then
                local v69 = v68.Text
                if v69:find("Tier") or v69:match("^[IVX]+$") or v69 == "0" then
                    return v68
                end
            end
        end
    end
    return nil
end
 
local function v70(v71)
    if not v71 or v71 == "" then return "0" end
    if v71 == "0" then return "0" end
    local v72 = v71:match("Tier%s+([IVX]+)")
    if v72 then return v72 end
    if v71:match("^[IVX]+$") then return v71 end
    local v73 = v71:match("Tier%s+(%d+)")
    if v73 then
        local v74 = tonumber(v73)
        if v74 == 0 then return "0"
        elseif v74 == 1 then return "I"
        elseif v74 == 2 then return "II"
        elseif v74 == 3 then return "III"
        end
    end
    return "0"
end
 
local function v75(v76)
    if not v76 then return nil end
    if v76.Name ~= 'GeneratorAdornee' then return nil end
    local v77 = v76:FindFirstChild('RoactTree')
    if not v77 then return nil end
    local v78 = v77:FindFirstChild('TeamOreGeneratorApp')
    if not v78 then return nil end
    local v79 = v78:FindFirstChild('GlobalOreGenerator')
    if not v79 then return nil end
    local v80 = v79:FindFirstChild('Countdown')
    if not v80 then return nil end
    local v81 = v80:FindFirstChild('Text')
    if not v81 then
        if v80:IsA('TextLabel') then return v80 end
        return nil
    end
    return v81
end
 
local function v82(v83)
    if not v83 or v83 == "" then return 0 end
    local v84 = v83:match("%[(%d+)%]")
    if v84 then return tonumber(v84) or 0 end
    local v85 = v83:match("(%d+)")
    if v85 then return tonumber(v85) or 0 end
    return 0
end
 
local function v86(v87, v88)
    local v89 = 0
    for v90, v91 in pairs(v2:GetTagged('ItemDrop')) do
        if v91:FindFirstChild('Handle') then
            local v92 = v91.Name:lower()
            if v92:find(v88) then
                local v93 = (v91.Handle.Position - v87).Magnitude
                if v93 <= 10 then
                    local v94 = v91:GetAttribute('Amount') or 1
                    v89 = v89 + v94
                end
            end
        end
    end
    return v89
end
 
local function v95()
    table.clear(v36)
    for v96, v97 in pairs(workspace:GetDescendants()) do
        if v97.Name == 'GeneratorAdornee' then
            local v98, v99 = pcall(function() return v97:GetAttribute('Id') end)
            if v98 and v99 and type(v99) == 'string' and v99 ~= '' then
                local v100 = v44(v99)
                if v100 == 'diamond' or v100 == 'emerald' then
                    table.insert(v36, {obj = v97, genType = v100})
                end
            end
        end
    end
end
 
local function v101()
    if not v9.Enabled or v15.Value ~= 'Compact' then
        v24.Enabled = false
        return
    end
    v24.Enabled = true
    local v102 = math.huge
    local v103 = math.huge
    for v104 = #v36, 1, -1 do
        local v105 = v36[v104]
        if not v105.obj or not v105.obj.Parent then
            table.remove(v36, v104)
            continue
        end
        local v106 = v75(v105.obj)
        if v106 and v106.Text then
            local v107 = v82(v106.Text)
            if v105.genType == 'diamond' and v107 > 0 and v107 < v102 then
                v102 = v107
            elseif v105.genType == 'emerald' and v107 > 0 and v107 < v103 then
                v103 = v107
            end
        end
    end
    local v108 = v16 and v16.Enabled
    local v109 = v17 and v17.Enabled
 
    if not v108 and not v109 then
        v24.Enabled = false
        return
    end
 
    v28.Visible = v108
    v31.Visible = v109
 
    if v108 then
        v28.Position = UDim2.new(0, 10, 0, 35)
    end
    if v109 then
        v31.Position = UDim2.new(0, 10, 0, v108 and 65 or 35)
    end
 
    v34[1] = v102 ~= math.huge and v102 or 0
    v35[1] = v103 ~= math.huge and v103 or 0
    if v102 == math.huge then
        v30.Text = "00"
    else
        v30.Text = string.format("%02d", v102)
        if v102 <= 5 then
            v30.TextColor3 = Color3.fromRGB(255, 50, 50)
        elseif v102 <= 10 then
            v30.TextColor3 = Color3.fromRGB(255, 165, 0)
        else
            v30.TextColor3 = Color3.fromRGB(85, 200, 255)
        end
    end
    if v103 == math.huge then
        v33.Text = "00"
    else
        v33.Text = string.format("%02d", v103)
        if v103 <= 5 then
            v33.TextColor3 = Color3.fromRGB(255, 50, 50)
        elseif v103 <= 10 then
            v33.TextColor3 = Color3.fromRGB(255, 165, 0)
        else
            v33.TextColor3 = Color3.fromRGB(0, 255, 100)
        end
    end
end
 
local function v110()
    v8:ClearAllChildren()
    table.clear(v18)
    v24.Enabled = false
end
 
local function v111(v112)
    local v113 = Instance.new("ImageLabel")
    v113.Name = "Blur"
    v113.BackgroundTransparency = 1
    v113.Image = "rbxassetid://8992230677"
    v113.ImageColor3 = Color3.new(0, 0, 0)
    v113.ImageTransparency = 0.5
    v113.ScaleType = Enum.ScaleType.Slice
    v113.SliceCenter = Rect.new(100, 100, 100, 100)
    v113.SliceScale = 1
    v113.Size = UDim2.new(1, 120, 1, 116)
    v113.Position = UDim2.new(0, -60, 0, -58)
    v113.Parent = v112
    return v113
end
 
local function v114(v115, v116, v117, v118, v119)
    if not v51(v116, v119) then return end
    if v18[v115] then return end
 
    if v15.Value == 'Compact' then
        v18[v115] = {
            genType = v116,
            position = v118,
            teamId = v119,
            isTeamGen = v117.isTeamGen
        }
        return
    end
 
    local v120 = v117.color
    local v121 = nil
    if v117.isTeamGen and v119 and v19[v119] then
        v120 = v19[v119].color
        v121 = v19[v119].name
    end
 
    local v122 = Instance.new('BillboardGui')
    v122.Parent = v8
    v122.Name = 'generator-esp-' .. v116
    v122.AlwaysOnTop = true
    v122.ClipsDescendants = false
    v122.Adornee = v115
 
    if v117.isTeamGen then
        v122.Size = UDim2.fromOffset(180, 55)
        v122.StudsOffsetWorldSpace = Vector3.new(0, 5, 0)
    else
        v122.Size = UDim2.fromOffset(80, 30)
        v122.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
    end
 
    local v123 = v111(v122)
    v123.Visible = true
 
    if v117.isTeamGen and v121 then
        local v124 = Instance.new('Frame')
        v124.Name = 'TeamDot'
        v124.Parent = v122
        v124.Size = UDim2.fromOffset(8, 8)
        v124.Position = UDim2.new(0, 10, 0, 5)
        v124.BackgroundColor3 = v120
        v124.BorderSizePixel = 0
        local v125 = Instance.new('UICorner')
        v125.CornerRadius = UDim.new(1, 0)
        v125.Parent = v124
 
        local v126 = Instance.new('TextLabel')
        v126.Name = 'TeamLabel'
        v126.Parent = v122
        v126.BackgroundTransparency = 1
        v126.Size = UDim2.new(1, 0, 0, 18)
        v126.Position = UDim2.new(0, 0, 0, 0)
        v126.Text = v121
        v126.TextColor3 = v120
        v126.TextSize = 13
        v126.Font = Enum.Font.GothamBold
        v126.TextStrokeTransparency = 0.4
        v126.TextStrokeColor3 = Color3.new(0, 0, 0)
        v126.TextXAlignment = Enum.TextXAlignment.Center
    end
 
    local v127 = Instance.new('Frame')
    v127.Size = v117.isTeamGen and UDim2.new(1, 0, 0, 35) or UDim2.fromScale(1, 1)
    v127.Position = v117.isTeamGen and UDim2.new(0, 0, 0, 20) or UDim2.new(0, 0, 0, 0)
    v127.BackgroundColor3 = Color3.new(0, 0, 0)
    v127.BackgroundTransparency = 0.3
    v127.BorderSizePixel = 0
    v127.Parent = v122
 
    if v117.isTeamGen and v119 and v19[v119] then
        local v128 = Instance.new('Frame')
        v128.Name = 'TeamStripe'
        v128.Parent = v127
        v128.Size = UDim2.new(0, 3, 1, 0)
        v128.Position = UDim2.new(0, 0, 0, 0)
        v128.BackgroundColor3 = v120
        v128.BorderSizePixel = 0
        local v129 = Instance.new('UICorner')
        v129.CornerRadius = UDim.new(0, 3)
        v129.Parent = v128
    end
 
    local v130 = Instance.new('UICorner')
    v130.CornerRadius = UDim.new(0, 6)
    v130.Parent = v127
 
    if v117.isTeamGen then
        local v131 = Instance.new('TextLabel')
        v131.Name = 'Tier'
        v131.Size = UDim2.new(0, 25, 1, 0)
        v131.Position = UDim2.new(0, 8, 0, 0)
        v131.BackgroundTransparency = 1
        v131.Text = "0"
        v131.TextColor3 = Color3.fromRGB(255, 255, 100)
        v131.TextSize = 16
        v131.Font = Enum.Font.GothamBold
        v131.TextStrokeTransparency = 0.5
        v131.TextStrokeColor3 = Color3.new(0, 0, 0)
        v131.Parent = v127
 
        local v132 = {
            {name = 'iron',    color = Color3.fromRGB(200, 200, 200), icon = 'iron',    xOffset = 35},
            {name = 'diamond', color = Color3.fromRGB(85, 200, 255),  icon = 'diamond', xOffset = 85},
            {name = 'emerald', color = Color3.fromRGB(0, 255, 100),   icon = 'emerald', xOffset = 135}
        }
 
        local v133 = {}
        for v134, v135 in ipairs(v132) do
            local v136 = v55(v135.icon)
            if v136 then
                local v137 = Instance.new('ImageLabel')
                v137.Size = UDim2.fromOffset(18, 18)
                v137.Position = UDim2.new(0, v135.xOffset, 0.5, 0)
                v137.AnchorPoint = Vector2.new(0, 0.5)
                v137.BackgroundTransparency = 1
                v137.Image = v136
                v137.Parent = v127
            end
            local v138 = Instance.new('TextLabel')
            v138.Name = v135.name .. '_count'
            v138.Size = UDim2.new(0, 25, 1, 0)
            v138.Position = UDim2.new(0, v135.xOffset + 20, 0, 0)
            v138.BackgroundTransparency = 1
            v138.Text = "0"
            v138.TextColor3 = v135.color
            v138.TextSize = 16
            v138.Font = Enum.Font.GothamBold
            v138.TextStrokeTransparency = 0.5
            v138.TextStrokeColor3 = Color3.new(0, 0, 0)
            v138.TextXAlignment = Enum.TextXAlignment.Left
            v138.Parent = v127
            v133[v135.name] = v138
        end
 
        v18[v115] = {
            billboard = v122,
            tierLabel = v131,
            ironLabel = v133.iron,
            diamondLabel = v133.diamond,
            emeraldLabel = v133.emerald,
            genType = v116,
            position = v118,
            teamId = v119,
            isTeamGen = true
        }
    else
        local v139 = v55(v117.icon)
        if v139 then
            local v140 = Instance.new('ImageLabel')
            v140.Size = UDim2.fromOffset(20, 20)
            v140.Position = UDim2.new(0, 5, 0.5, 0)
            v140.AnchorPoint = Vector2.new(0, 0.5)
            v140.BackgroundTransparency = 1
            v140.Image = v139
            v140.Parent = v127
        end
        local v141 = Instance.new('TextLabel')
        v141.Name = 'Timer'
        v141.Size = UDim2.new(0, 30, 1, 0)
        v141.Position = UDim2.new(0.5, 0, 0, 0)
        v141.AnchorPoint = Vector2.new(0.5, 0)
        v141.BackgroundTransparency = 1
        v141.Text = "00"
        v141.TextColor3 = v120
        v141.TextSize = 18
        v141.Font = Enum.Font.GothamBold
        v141.TextStrokeTransparency = 0.5
        v141.TextStrokeColor3 = Color3.new(0, 0, 0)
        v141.Parent = v127
        local v142 = Instance.new('TextLabel')
        v142.Name = 'Amount'
        v142.Size = UDim2.new(0, 20, 1, 0)
        v142.Position = UDim2.new(1, -20, 0, 0)
        v142.BackgroundTransparency = 1
        v142.Text = "0"
        v142.TextColor3 = Color3.fromRGB(255, 255, 255)
        v142.TextSize = 16
        v142.Font = Enum.Font.GothamBold
        v142.TextStrokeTransparency = 0.5
        v142.TextStrokeColor3 = Color3.new(0, 0, 0)
        v142.Parent = v127
        v18[v115] = {
            billboard = v122,
            timerLabel = v141,
            amountLabel = v142,
            genType = v116,
            position = v118,
            teamId = v119,
            isTeamGen = false
        }
    end
end
 
local function v143(v144)
    local v145 = v18[v144]
    if not v145 then return end
    if v15.Value == 'Compact' then return end
 
    if v145.isTeamGen then
        if v145.tierLabel then
            local v146 = v58(v144)
            if v146 and v146.Text then
                v145.tierLabel.Text = v70(v146.Text)
            else
                v145.tierLabel.Text = "0"
            end
        end
        if v145.ironLabel then
            v145.ironLabel.Text = tostring(v86(v145.position, 'iron'))
        end
        if v145.diamondLabel then
            v145.diamondLabel.Text = tostring(v86(v145.position, 'diamond'))
        end
        if v145.emeraldLabel then
            v145.emeraldLabel.Text = tostring(v86(v145.position, 'emerald'))
        end
    else
        local v147 = v75(v144)
        if v147 and v147.Text then
            local v148 = v82(v147.Text)
            if v145.timerLabel then
                v145.timerLabel.Text = string.format("%02d", v148)
                if v148 <= 5 then
                    v145.timerLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif v148 <= 10 then
                    v145.timerLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
                else
                    v145.timerLabel.TextColor3 = v20[v145.genType].color
                end
            end
        else
            if v145.timerLabel then
                v145.timerLabel.Text = "00"
                v145.timerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        if v145.amountLabel then
            v145.amountLabel.Text = tostring(v86(v145.position, v145.genType))
        end
    end
end
 
local function v149(v150)
    if v150.Name ~= 'GeneratorAdornee' then return end
    local v151, v152 = pcall(function() return v150:GetAttribute('Id') end)
    if not v151 then return end
    if v152 == nil then return end
    if type(v152) ~= 'string' then return end
    if v152 == '' then return end
 
    local v153 = v150:GetPivot().Position
    local v154, v155 = v44(v152)
    if not v154 or not v155 then return end
 
    local v156 = v39(v152)
    if v51(v154, v156) then
        v114(v150, v154, v155, v153, v156)
    end
end
 
local function v157()
    for v158, v159 in pairs(workspace:GetDescendants()) do
        pcall(v149, v159)
    end
end
 
local function v160()
    v110()
    if v9.Enabled then
        v157()
    end
end
 
local function v162()
    local v163 = v55('diamond')
    if v163 then v29.Image = v163 end
    local v164 = v55('emerald')
    if v164 then v32.Image = v164 end
end
 
v162()
 
v4.InputBegan:Connect(function(v165, v166)
    if v166 then return end
 
    if v165.KeyCode == Enum.KeyCode.RightShift then
        if not silent then print(true) end
        v9.Enabled = not v9.Enabled
        v160()
    elseif v165.KeyCode == Enum.KeyCode.Home then
        if not silent then print(true) end
        v15.Value = v15.Value == 'Original' and 'Compact' or 'Original'
        v160()
    end
end)
 
v4.InputEnded:Connect(function(v165, v166)
    if v166 then return end
 
    if v165.KeyCode == Enum.KeyCode.RightShift then
        if not silent then print(false) end
    elseif v165.KeyCode == Enum.KeyCode.Home then
        if not silent then print(false) end
    end
end)
 
v157()
v95()
 
workspace.DescendantAdded:Connect(function(v167)
    if not v9.Enabled then return end
    task.wait(0.2)
    pcall(v149, v167)
    if v167.Name == 'GeneratorAdornee' then
        v95()
    end
end)
 
v3.Heartbeat:Connect(function(v168)
    if not v9.Enabled then return end
 
    for v169, v170 in pairs(v18) do
        if v169 and v169.Parent then
            v143(v169)
        else
            if v170.billboard then v170.billboard:Destroy() end
            v18[v169] = nil
        end
    end
    v101()
end)
 
workspace.DescendantRemoving:Connect(function(v171)
    if not v9.Enabled then return end
    if v18[v171] then
        if v18[v171].billboard then v18[v171].billboard:Destroy() end
        v18[v171] = nil
    end
end)
 
end