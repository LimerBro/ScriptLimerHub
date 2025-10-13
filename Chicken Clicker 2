-- Вкажи тут ID гри, де скрипт має працювати
local allowedGameId = 93004918890416  

-- Перевіряємо, чи ми в правильній грі
if game.PlaceId ~= allowedGameId then
    return -- Якщо не та гра, скрипт не виконується
end
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Workspace = game:GetService("Workspace")

-- // UI Library
local Rayfield = loadstring(game:HttpGet('https://limerbro.github.io/Roblox-Limer/rayfield.lua'))()

-- // Window
local Window = Rayfield:CreateWindow({
	Name = "🔋 LimerHub > Chicken Clicker 2",
	Icon = 105792205668394,
	LoadingTitle = "Loading...",
	LoadingSubtitle = "By LimerBoy",
	Theme = "BlackYellowTheme",
	ToggleUIKeybind = Enum.KeyCode.K,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "ZombieHub",
		FileName = "Config"
	}
})

------------------------------------------------------------
-- ⚙️ MAIN TAB
------------------------------------------------------------
local MainTab = Window:CreateTab("⚙️ Main", "Settings")

-- 🔁 Auto Clicker
local autoClick = false
MainTab:CreateToggle({
	Name = "🖱️ Auto Clicker",
	CurrentValue = false,
	Flag = "AutoClicker",
	Callback = function(Value)
		autoClick = Value
		task.spawn(function()
			while autoClick do
				pcall(function()
					Remotes.Clicker:FireServer()
				end)
				task.wait(0.1)
			end
		end)
	end,
})

-- 🎃 Halloween Auto Click
local autoHalloween = false
MainTab:CreateToggle({
	Name = "🎃 Auto Click (Halloween Event)",
	CurrentValue = false,
	Flag = "AutoHalloweenClick",
	Callback = function(Value)
		autoHalloween = Value
		task.spawn(function()
			while autoHalloween do
				pcall(function()
					Remotes.PileClickEvent:FireServer()
				end)
				task.wait(0.1)
			end
		end)
	end,
})

-- 🔕 Hide Popups
MainTab:CreateToggle({
	Name = "❌ Hide Popups",
	CurrentValue = false,
	Flag = "HidePopups",
	Callback = function(Value)
		local popups = player.PlayerGui:FindFirstChild("GameUI") and player.PlayerGui.GameUI:FindFirstChild("Popups")
		if popups then
			popups.Visible = not Value
		end
	end,
})

-- 🐾 Delete All Pets (Button)
MainTab:CreateButton({
	Name = "🐾 Delete All Pets (workspace.PlayerPets)",
	Callback = function()
		for _, folder in pairs(Workspace:WaitForChild("PlayerPets"):GetChildren()) do
			folder:Destroy()
		end
		Rayfield:Notify({
			Title = "LimerHub",
			Content = "✅ All pets have been deleted from workspace.PlayerPets.",
			Duration = 3
		})
	end,
})

------------------------------------------------------------
-- 🌀 TELEPORT TAB
------------------------------------------------------------
local TpTab = Window:CreateTab("🌀 Teleports", "Map")

local tpLocations = {
	["🌿 Nature Obby"] = Vector3.new(245.2, 15.8, 719.6),
	["🍭 Candy Obby"] = Vector3.new(309.7, 31.8, 949.4),
	["😈 Evil Obby"] = Vector3.new(242.2, 15.8, 1179.9),
	["😇 Good Obby"] = Vector3.new(243.5, 15.8, 1445.6)
}

for name, pos in pairs(tpLocations) do
	TpTab:CreateButton({
		Name = name,
		Callback = function()
			player.Character:PivotTo(CFrame.new(pos))
		end,
	})
end

------------------------------------------------------------
-- 🥚 EGG TAB
------------------------------------------------------------
local EggTab = Window:CreateTab("🥚 Eggs", "Egg")

local eggsFolder = Workspace:WaitForChild("Map"):WaitForChild("Eggs")
local eggToggles = {}

for _, egg in pairs(eggsFolder:GetChildren()) do
	if egg:IsA("Model") then
		local eggName = egg.Name
		eggToggles[eggName] = false

		EggTab:CreateToggle({
			Name = "🥚 Auto Open " .. eggName,
			CurrentValue = false,
			Flag = eggName .. "_AutoOpen",
			Callback = function(Value)
				eggToggles[eggName] = Value
				task.spawn(function()
					while eggToggles[eggName] do
						pcall(function()
							Remotes.Egg:InvokeServer(eggName, 3)
						end)
						task.wait(1)
					end
				end)
			end,
		})
	end
end

------------------------------------------------------------
-- 🔔 Notification
------------------------------------------------------------
Rayfield:Notify({
	Title = "LimerHub",
	Content = "✅ Loaded successfully! Connected to Magnet LEGENDS!",
	Duration = 4
})
