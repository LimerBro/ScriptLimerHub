local allowedPlaceId = 140521540051276

if game.PlaceId ~= allowedPlaceId then
    warn("Цей скрипт не підтримується в цій грі.")
    return
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "LimerHub",
    Icon = 71338090068856,
    LoadingTitle = "Rebirth Masters X!",
    LoadingSubtitle = "Автор LimerBro",
    Theme = "Default",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LimerHubConfigs",
        FileName = "LimerHubSettings",
        Autosave = true
    },
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 6961018885) -- нова іконка


-- Функція 1. Авто Rebirth
PlayerTab:CreateToggle({
    Name = "Авто Rebirth",
    Info = "Постійно робить Rebirth поки активний перемикач",
    CurrentValue = false,
    Callback = function(Value)
        autoRebirth = Value
        while autoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(0.5)
        end
    end,
})

PlayerTab:CreateSection("Телепортує всі монети леше на 8 World")
-- Функція 2.  монети
PlayerTab:CreateToggle({
    Name = "Притягнути всі монети до себе",
    Info = "Телепортує всі монети в зоні 13 до вас",
    CurrentValue = false,
    Callback = function(Value)
        autoCollect = Value
        while autoCollect do
            pcall(function()
                local player = game.Players.LocalPlayer
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local area = workspace.Map.CollectAreas["13"]
                for _, item in pairs(area:GetDescendants()) do
                    if item:IsA("BasePart") and item.Name:lower():find("coin") or item.Name:lower():find("currency") then
                        item.CFrame = hrp.CFrame + Vector3.new(0, 1, 0)
                    end
                end
            end)
            task.wait(0.5)
        end
    end,
})

-- Вкладка "Телепорт" з координатами
local TeleportTab = Window:CreateTab("Телепорт", 6034977807) -- нова іконка
TeleportTab:CreateSection("Телепорт до зон (координати)")

local function tpToCoords(x, y, z)
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(x, y, z)
    end
end

TeleportTab:CreateButton({
    Name = "Spawn",
    Callback = function()
        tpToCoords(628.9, -8.7, -196.8)
    end,
})

TeleportTab:CreateButton({
    Name = "1 World",
    Callback = function()
        tpToCoords(225.9, -11.8, -369.3)
    end,
})

TeleportTab:CreateButton({
    Name = "2 World",
    Callback = function()
        tpToCoords(5.2, -28.1, 28.5)
    end,
})

TeleportTab:CreateButton({
    Name = "3 World",
    Callback = function()
        tpToCoords(-508.5, -7.5, -73.5)
    end,
})

TeleportTab:CreateButton({
    Name = "4 World",
    Callback = function()
        tpToCoords(-517.3, -7.0, -349.2)
    end,
})

TeleportTab:CreateButton({
    Name = "5 World",
    Callback = function()
        tpToCoords(-93.9, 16.8, -420.7)
    end,
})

TeleportTab:CreateButton({
    Name = "6 World",
    Callback = function()
        tpToCoords(226.3, -78.1, -1612.6)
    end,
})

TeleportTab:CreateButton({
    Name = "7 World",
    Callback = function()
        tpToCoords(116.2, 2.2, -1031.9)
    end,
})

TeleportTab:CreateButton({
    Name = "8 World",
    Callback = function()
        tpToCoords(3305.2, -32.1, -228.0)
    end,
})

-- Створюємо нову вкладку для яєць
local EggsTab = Window:CreateTab("Яйця", 6034287531) -- Іконка яйця

-- Додаємо секцію з поясненням
EggsTab:CreateSection("Автоматичне відкриття яєць")

-- Функція для створення перемикача для кожного яйця
local function CreateEggToggle(eggName, eggDisplayName)
    local toggleState = false
    
    EggsTab:CreateToggle({
        Name = eggDisplayName,
        CurrentValue = toggleState,
        Callback = function(Value)
            toggleState = Value
            if Value then
                coroutine.wrap(function()
                    while toggleState do
                        local success = pcall(function()
                            game:GetService("ReplicatedStorage").Remotes.Egg:InvokeServer(eggName, 3)
                        end)
                        
                        if not success then
                            warn("Помилка при відкритті "..eggName)
                            toggleState = false
                            Rayfield:Notify({
                                Title = "Помилка",
                                Content = "Не вдалося відкрити "..eggDisplayName,
                                Duration = 3,
                                Image = 7733925145
                            })
                        end
                        
                        -- Чекаємо 1 секунду перед наступною спробою
                        for i = 1, 10 do
                            if not toggleState then break end
                            task.wait(0.1)
                        end
                    end
                end)()
            end
        end,
    })
end

-- Створюємо перемикачі для всіх типів яєць
CreateEggToggle("Common Egg", "Звичайне яйце")
CreateEggToggle("Forest Egg", "Лісове яйце")
CreateEggToggle("Beach Egg", "Пляжне яйце")
CreateEggToggle("Desert Egg", "Пустельне яйце")
CreateEggToggle("Winter Egg", "Зимове яйце")
CreateEggToggle("Volcano Egg", "Вулканічне яйце")
CreateEggToggle("Crystal Egg", "Кришталеве яйце")
CreateEggToggle("Mystic Egg", "Містичне яйце")
CreateEggToggle("Moon Egg", "Місячне яйце")

-- Додаємо інформаційну секцію
EggsTab:CreateSection("Інформація")
EggsTab:CreateLabel("Кожен перемикач активує авто-відкриття")
EggsTab:CreateLabel("Відкривається по 3 яйця кожну секунду")

