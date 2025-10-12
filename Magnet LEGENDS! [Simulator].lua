-- // 🔋 LimerHub 🪫 Magnet Legends Simulator //
-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("FrameworkEvents")

-- // UI Library
local Rayfield = loadstring(game:HttpGet('https://limerbro.github.io/Roblox-Limer/rayfield.lua'))()

-- // Window
local Window = Rayfield:CreateWindow({
	Name = "🔋LimerHub > Magnet LEGENDS! [Simulator]",
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

-- Tabs
local MainTab = Window:CreateTab("⚙️ Main", "Settings")
local TpTab = Window:CreateTab("🌀 TP Lobby", "Map")
local EggTab = Window:CreateTab("🥚 Open Egg", "Egg")

-- Notification
local function showNotification(text)
	Rayfield:Notify({
		Title = "LimerHub",
		Content = text,
		Duration = 3
	})
end


------------------------------------------------
-- 💰 AUTO SELL через firetouchinterest
------------------------------------------------
local autoSell = false

MainTab:CreateToggle({
	Name = "💰 Auto Sell (Touch Trigger)",
	CurrentValue = false,
	Flag = "AutoSell",
	Callback = function(state)
		autoSell = state
		if autoSell then
			showNotification("Auto Sell ON")

			task.spawn(function()
				local character = player.Character or player.CharacterAdded:Wait()
				local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
				local sellTrigger = workspace.PersistentObjects:WaitForChild("VIPSellTrigger")

				while autoSell do
					pcall(function()
						firetouchinterest(humanoidRootPart, sellTrigger, 0)
						task.wait(0.1)
						firetouchinterest(humanoidRootPart, sellTrigger, 1)
					end)
					task.wait(0.5)
				end
			end)
		else
			showNotification("Auto Sell OFF")
		end
	end
})


------------------------------------------------
-- 🥥 AUTO COLLECT COCONUT
------------------------------------------------
local autoCoconut = false

MainTab:CreateToggle({
	Name = "🥥 Auto Collect Coconut",
	CurrentValue = false,
	Flag = "AutoCoconut",
	Callback = function(state)
		autoCoconut = state
		if autoCoconut then
			showNotification("Auto Coconut ON")
			task.spawn(function()
				while autoCoconut do
					pcall(function()
						Remotes.CollectCoconut:FireServer("Coconut_76")
					end)
					task.wait(1)
				end
			end)
		else
			showNotification("Auto Coconut OFF")
		end
	end
})


------------------------------------------------
-- 🏅 CONVERT TO GOLD
------------------------------------------------
MainTab:CreateButton({
	Name = "🏅 Convert Coins → Gold",
	Description = "Для крафта 1 золотого слітка потрібно 1B монет 💰",
	Callback = function()
		pcall(function()
			Remotes.FinishedSmelt:FireServer("Gold2")
		end)
		showNotification("1B coins converted to Gold Ingot 🪙")
	end
})


------------------------------------------------
-- 🌀 TELEPORTS (в правильному порядку)
------------------------------------------------
local orderedTPs = {
	["🏠 Spawn"] = CFrame.new(-510.9, -220.9, 577.4),
	["🌾 Farm"] = CFrame.new(-548.0, -220.9, 239.2),
	["🍬 Candy Land"] = CFrame.new(-571.2, -220.9, -9.6),
	["🏖️ Beach"] = CFrame.new(-578.5, -220.9, -488.8),
	["🌊 Underwater"] = CFrame.new(-277.5, -296.8, -855.1),
	["🈶 Zen"] = CFrame.new(141.3, -219.9, -860.4),
	["❄️ Ice"] = CFrame.new(602.1, -220.8, -858.0),
	["🌋 Volcano"] = CFrame.new(1121.4, -220.1, -949.2),
	["⛏️ Mine"] = CFrame.new(1770.0, -287.0, -975.3),
	["💎 VIP Zone"] = CFrame.new(112.8, -220.8, 792.5)
}

for _, name in ipairs({
	"🏠 Spawn",
	"🌾 Farm",
	"🍬 Candy Land",
	"🏖️ Beach",
	"🌊 Underwater",
	"🈶 Zen",
	"❄️ Ice",
	"🌋 Volcano",
	"⛏️ Mine",
	"💎 VIP Zone"
}) do
	local cf = orderedTPs[name]
	TpTab:CreateButton({
		Name = name,
		Callback = function()
			local TeleportEffect = player:WaitForChild("TeleportEffect")
			TeleportEffect:Fire(cf)
			showNotification("Teleported to " .. name)
		end
	})
end

------------------------------------------------
-- 🥚 OPEN EGG (повністю відсортовано)
------------------------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local eggList = {
	{ name = "Basic",        label = "1 Basic | 25 💸" },
	{ name = "Spotted",      label = "2 Spotted | 100 💸" },
	{ name = "Farm",         label = "3 Farm | 500 💸" },
	{ name = "Sweet",        label = "4 Sweet | 25k 💸" },
	{ name = "Beach",        label = "5 Beach | 750k 💸" },
	{ name = "Ocean",        label = "6 Ocean | 2.5m 💸" },
	{ name = "Samurai",      label = "7 Samurai | 20m 💸" },
	{ name = "Arctic",       label = "8 Arctic | 750m 💸" },
	{ name = "Volcanic",     label = "9 Volcanic | 2.21b 💸" },
	{ name = "Crystal",      label = "10 Crystal | 100 💰" },
	{ name = "GoldCrystal",  label = "11 Gold Crystal | 3k 💰" }
}

for _, egg in ipairs(eggList) do
	local toggleState = false

	EggTab:CreateToggle({
		Name = egg.label,
		CurrentValue = false,
		Flag = "Auto_" .. egg.name,
		Callback = function(state)
			toggleState = state
			if toggleState then
				Rayfield:Notify({
					Title = "🥚 Auto Hatch",
					Content = "Відкривається: " .. egg.name,
					Duration = 2
				})
				task.spawn(function()
					while toggleState do
						pcall(function()
							ReplicatedStorage.FrameworkEvents.Buy_Eggs:FireServer(egg.name, 3, false)
						end)
						task.wait(1.5)
					end
				end)
			else
				Rayfield:Notify({
					Title = "🥚 Auto Hatch",
					Content = "Зупинено: " .. egg.name,
					Duration = 2
				})
			end
		end
	})
end
