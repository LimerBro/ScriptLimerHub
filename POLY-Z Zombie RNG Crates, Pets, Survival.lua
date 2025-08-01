-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://limerbro.github.io/Roblox-Limer/rayfield.lua'))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local HRP = player.Character and player.Character:WaitForChild("HumanoidRootPart")
local center = workspace:WaitForChild("BossArena"):FindFirstChild("Part")
local radius = 20
local angle = 0
local speed = 5
local spinning = false

-- UI Window
local Window = Rayfield:CreateWindow({
    Name = "LimerHub",
    Icon = "rbxassetid://71338090068856", -- Виправлено
    LoadingTitle = "✨POLY-Z Zombie RNG🎲Crates, Pets, Survival⚔️",
    LoadingSubtitle = "Developed by LimerBro",
    Theme = "DarkBlue",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ZombieHub",
        FileName = "Config"
    }
})

-- Get equipped weapon name
local function getEquippedWeaponName()
    local model = workspace:FindFirstChild("Players"):FindFirstChild(player.Name)
    if model then
        for _, child in ipairs(model:GetChildren()) do
            if child:IsA("Model") then
                return child.Name
            end
        end
    end
    return "M1911"
end

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", "Skull")

-- Weapon Label
local weaponLabel = CombatTab:CreateLabel("🔫 Current Weapon: Loading...")
task.spawn(function()
    while true do
        weaponLabel:Set("🔫 Current Weapon: " .. getEquippedWeaponName())
        task.wait(0.1)
    end
end)

-- Auto Headshots
local autoKill = false
local shootDelay = 0.1

CombatTab:CreateSlider({
    Name = "Delay between shots (sec)",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "сек",
    CurrentValue = shootDelay,
    Flag = "ShootDelay",
    Callback = function(value)
        shootDelay = value
    end
})

CombatTab:CreateToggle({
    Name = "Auto Headshot Zombies",
    CurrentValue = false,
    Flag = "AutoKillZombies",
    Callback = function(state)
        autoKill = state
        if state then
            task.spawn(function()
                while autoKill do
                    local enemies = workspace:FindFirstChild("Enemies")
                    local shootRemote = Remotes:FindFirstChild("ShootEnemy")
                    if enemies and shootRemote then
                        local weapon = getEquippedWeaponName()
                        for _, zombie in pairs(enemies:GetChildren()) do
                            if zombie:IsA("Model") then
                                local head = zombie:FindFirstChild("Head")
                                if head then
                                    local args = {zombie, head, head.Position, 2, weapon}
                                    pcall(function() shootRemote:FireServer(unpack(args)) end)
                                end
                            end
                        end
                    end
                    task.wait(shootDelay)
                end
            end)
        end
    end
})

-- Auto Skip Round
local autoSkip = false
CombatTab:CreateToggle({
    Name = "Auto Skip Round",
    CurrentValue = false,
    Flag = "AutoSkipRound",
    Callback = function(state)
        autoSkip = state
        if state then
            task.spawn(function()
                while autoSkip do
                    local skip = Remotes:FindFirstChild("CastClientSkipVote")
                    if skip then
                        pcall(function() skip:FireServer() end)
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- WalkSpeed
CombatTab:CreateSlider({
    Name = "Walking speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "units",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        if player.Character then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
    end
})

-- Orbit Toggle
CombatTab:CreateToggle({
    Name = "Circling around the Boss",
    CurrentValue = false,
    Callback = function(value)
        spinning = value
    end,
})

-- Orbit Speed Slider
CombatTab:CreateSlider({
    Name = "Rotation speed",
    Range = {1, 20},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = speed,
    Callback = function(val)
        speed = val
    end,
})

-- Orbit Radius Slider
CombatTab:CreateSlider({
    Name = "Orbit radius",
    Range = {5, 100},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = radius,
    Callback = function(val)
        radius = val
    end,
})

-- Orbit Logic
RunService.RenderStepped:Connect(function(dt)
    if spinning and HRP and center then
        angle += dt * speed
        local x = math.cos(angle) * radius
        local z = math.sin(angle) * radius
        local targetPosition = center.Position + Vector3.new(x, 0, z)
        HRP.CFrame = CFrame.new(targetPosition, center.Position)
    end
end)

-- TP Button
CombatTab:CreateButton({
    Name = "TP to Safe Zone",
    Callback = function()
        if HRP then
            HRP.CFrame = CFrame.new(-1284.7, 256.2, -1166.1)
        end
    end,
})

local MiscTab = Window:CreateTab("Misc", "Skull")

MiscTab:CreateButton({
    Name = "Delete All Doors",
    Callback = function()
        local doorsFolder = workspace:FindFirstChild("Doors")
        if doorsFolder then
            for _, group in pairs(doorsFolder:GetChildren()) do
                if group:IsA("Folder") or group:IsA("Model") then
                    group:Destroy()
                end
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Activate All Perks",
    Callback = function()
        local vars = player:FindFirstChild("Variables")
        if not vars then return end

        local perks = {
            "Bandoiler_Perk",
            "DoubleUp_Perk",
            "Haste_Perk",
            "Tank_Perk"
        }

        for _, perk in ipairs(perks) do
            if vars:GetAttribute(perk) ~= nil then
                vars:SetAttribute(perk, true)
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Enhance Primary & Secondary",
    Callback = function()
        local vars = player:FindFirstChild("Variables")
        if not vars then return end

        local enchants = {
            "Primary_Enhanced",
            "Secondary_Enhanced"
        }

        for _, attr in ipairs(enchants) do
            if vars:GetAttribute(attr) ~= nil then
                vars:SetAttribute(attr, true)
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Set Mag to 1 Million",
    Callback = function()
        local vars = player:FindFirstChild("Variables")
        if not vars then return end

        local ammoAttributes = {
            "Primary_Mag",
            "Secondary_Mag"
        }

        for _, attr in ipairs(ammoAttributes) do
            if vars:GetAttribute(attr) ~= nil then
                vars:SetAttribute(attr, 100000000)
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Set All Guns to 'cosmic'",
    Callback = function()
        local gunData = player:FindFirstChild("GunData")
        if not gunData then return end

        for _, value in ipairs(gunData:GetChildren()) do
            if value:IsA("StringValue") then
                value.Value = "cosmic"
            end
        end
    end
})
local openTab = Window:CreateTab("Open", "Skull")
-- Перемикач для Камо ящика
openTab:CreateToggle({
    Name = "Auto Opening 🕶️",
    CurrentValue = false,
    Callback = function(state)
        autoOpenCamo = state
        if state then
            task.spawn(function()
                while autoOpenCamo do
                    pcall(function()
                        ReplicatedStorage.Remotes.OpenCamoCrate:InvokeServer("Random")
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- Перемикач для Одягу
openTab:CreateToggle({
    Name = "Auto Opening 👕",
    CurrentValue = false,
    Callback = function(state)
        autoOpenOutfit = state
        if state then
            task.spawn(function()
                while autoOpenOutfit do
                    pcall(function()
                        ReplicatedStorage.Remotes.OpenOutfitCrate:InvokeServer("Random")
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- Перемикач для Пета
openTab:CreateToggle({
    Name = "Auto Opening 😺",
    CurrentValue = false,
    Callback = function(state)
        autoOpenPet = state
        if state then
            task.spawn(function()
                while autoOpenPet do
                    pcall(function()
                        ReplicatedStorage.Remotes.OpenPetCrate:InvokeServer(1)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- Перемикач для Зброї
openTab:CreateToggle({
    Name = "Auto Opening 🔫",
    CurrentValue = false,
    Callback = function(state)
        autoOpenGun = state
        if state then
            task.spawn(function()
                while autoOpenGun do
                    pcall(function()
                        ReplicatedStorage.Remotes.OpenGunCrate:InvokeServer(1)
                    end)
                    task.wait(0.1)
                end
            end) 
        end
    end
})

-- Load config
Rayfield:LoadConfiguration()

