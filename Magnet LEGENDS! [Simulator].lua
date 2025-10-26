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
	LoadingSubtitle = "Hi Player",
	Theme = "BlackYellowTheme",
	ToggleUIKeybind = Enum.KeyCode.K,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "ZombieHub",
		FileName = "Config"
	}
})

-- // Welcome Notification (один раз при запуску)
Rayfield:Notify({
	Title = "Welcome!",
	Content = "Welcome, " .. player.Name .. " to Magnet Legends Simulator",
	Duration = 3
})

-- Tabs
local MainTab = Window:CreateTab("Main", "Settings")
local TpTab = Window:CreateTab("TP Lobby", "Map")
local EggTab = Window:CreateTab("Open Egg", "Egg")
local OpenGUITab = Window:CreateTab("Shop", "Settings")
local SettingsTab = Window:CreateTab(" Settings", "Settings")
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
			Rayfield:Notify({Title="Auto Sell", Content="Auto Sell ON", Duration=2})
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
			Rayfield:Notify({Title="Auto Sell", Content="Auto Sell OFF", Duration=2})
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
			Rayfield:Notify({Title="Auto Coconut", Content="Auto Coconut ON", Duration=2})
			task.spawn(function()
				while autoCoconut do
					pcall(function()
						Remotes.CollectCoconut:FireServer("Coconut_76")
					end)
					task.wait(1)
				end
			end)
		else
			Rayfield:Notify({Title="Auto Coconut", Content="Auto Coconut OFF", Duration=2})
		end
	end
})

------------------------------------------------
-- 🏅 AUTO CONVERT COINS → GOLD
------------------------------------------------
local autoConvert = false

MainTab:CreateToggle({
	Name = "🏅 Auto Convert Coins → Gold",
	CurrentValue = false,
	Flag = "AutoConvert",
	Callback = function(state)
		autoConvert = state
		if autoConvert then
			Rayfield:Notify({Title="Auto Convert", Content="Auto Convert ON 🪙", Duration=2})
			task.spawn(function()
				while autoConvert do
					pcall(function()
						for i = 1, 15 do
							Remotes.FinishedSmelt:FireServer("Gold" .. i)
						end
					end)
					task.wait(0.1)
				end
			end)
		else
			Rayfield:Notify({Title="Auto Convert", Content="Auto Convert OFF ❌", Duration=2})
		end
	end
})

------------------------------------------------
-- VEGETABLE FARM
------------------------------------------------
MainTab:CreateSection("Vegetable Farm")
MainTab:CreateButton({
	Name = "🪴 Plant Vegetables (All Plots)",
	Callback = function()
		if not Remotes then return Rayfield:Notify({Title="Error", Content="Remotes not found.", Duration=2}) end
		for i = 1, 10 do
			pcall(function()
				Remotes.PlantPlant:FireServer("Plot" .. i)
			end)
			task.wait(0.08)
		end
		Rayfield:Notify({Title="Vegetable Farm", Content="All plots planted.", Duration=2})
	end
})

MainTab:CreateButton({
	Name = "🧺 Collect Vegetables (All Plots)",
	Callback = function()
		if not Remotes then return Rayfield:Notify({Title="Error", Content="Remotes not found.", Duration=2}) end
		for i = 1, 10 do
			pcall(function()
				Remotes.CollectFruit:FireServer("Plot" .. i)
			end)
			task.wait(0.08)
		end
		Rayfield:Notify({Title="Vegetable Farm", Content="All plots collected.", Duration=2})
	end
})

------------------------------------------------
-- 🎮 MINI GAMES / EXTRA FEATURES
------------------------------------------------
MainTab:CreateSection("Mini Games & Extras")

-- 🪨 ROCK PAPER SCISSORS
local autoRPS = false
MainTab:CreateToggle({
	Name = "🪨 Rock Paper Scissors",
	CurrentValue = false,
	Flag = "AutoRPS",
	Callback = function(state)
		autoRPS = state
		if autoRPS then
			Rayfield:Notify({Title="Mini Game", Content="Rock Paper Scissors ON", Duration=2})
			task.spawn(function()
				while autoRPS do
					pcall(function()
						local ev = game:GetService("ReplicatedStorage").FrameworkEvents.RockPaperScissor
						ev:FireServer("Paper")
						task.wait(0.5)
						ev:FireServer("Rock")
						task.wait(0.5)
						ev:FireServer("Scissors")
					end)
					task.wait(1)
				end
			end)
		else
			Rayfield:Notify({Title="Mini Game", Content="Rock Paper Scissors OFF", Duration=2})
		end
	end
})

-- 🐚 AUTO COLLECT CLAMS (Pearls)
local autoClams = false
MainTab:CreateToggle({
	Name = "🐚 Auto Collect Clams",
	CurrentValue = false,
	Flag = "AutoClams",
	Callback = function(state)
		autoClams = state
		if autoClams then
			Rayfield:Notify({Title="Pearl Collector", Content="Collecting Clams ON", Duration=2})
			task.spawn(function()
				while autoClams do
					pcall(function()
						for i = 1, 6 do
							game:GetService("ReplicatedStorage").FrameworkEvents.ClaimClam:FireServer("Clam_" .. i)
						end
					end)
					task.wait(2)
				end
			end)
		else
			Rayfield:Notify({Title="Pearl Collector", Content="Collecting Clams OFF", Duration=2})
		end
	end
})

-- 🎣 AUTO FISHING
local autoFishing = false
MainTab:CreateToggle({
	Name = "🎣 Auto Fishing",
	CurrentValue = false,
	Flag = "AutoFishing",
	Callback = function(state)
		autoFishing = state
		if autoFishing then
			Rayfield:Notify({Title="Fishing", Content="Auto Fishing ON", Duration=2})
			task.spawn(function()
				while autoFishing do
					pcall(function()
						-- Закидуємо вудку
						game:GetService("ReplicatedStorage").FrameworkEvents.StartFishing:FireServer("Excellent")
						-- 20 кліків за секунду (0.05 сек між кліками)
						for i = 1, 20 do
							game:GetService("ReplicatedStorage").FrameworkEvents.FishingPowerClick:FireServer()
							task.wait(0.05)
						end
					end)
					task.wait(1) -- пауза між циклами
				end
			end)
		else
			Rayfield:Notify({Title="Fishing", Content="Auto Fishing OFF", Duration=2})
		end
	end
})

MainTab:CreateSection("🎃 Trick or Treat")

local TrickFarm = false

MainTab:CreateToggle({
	Name = "🍬 Auto Trick or Treat",
	CurrentValue = false,
	Flag = "TrickFarm",
	Callback = function(Value)
		TrickFarm = Value
		if TrickFarm then
			task.spawn(function()
				while TrickFarm do
					pcall(function()
						game:GetService("ReplicatedStorage").FrameworkEvents.DoorbellRing:FireServer("TrickHouse_1")
					end)
					task.wait(1) -- затримка між викликами (можеш змінити)
				end
			end)
		end
	end,
})

------------------------------------------------
-- 🌀 TELEPORTS
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
	["🎪 Carnival"] = CFrame.new(1601.3, -221.1, -1520.7),
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
	"🎪 Carnival",
	"💎 VIP Zone"
}) do
	local cf = orderedTPs[name]
	TpTab:CreateButton({
		Name = name,
		Callback = function()
			pcall(function()
				local TeleportEffect = player:WaitForChild("TeleportEffect")
				TeleportEffect:Fire(cf)
			end)
			Rayfield:Notify({Title="Teleport", Content="Teleported to " .. name, Duration=2})
		end
	})
end

------------------------------------------------
-- 🥚 OPEN EGG
------------------------------------------------
local eggList = {
	{ name = "Basic",       label = "1 Basic | 25 💸" },
	{ name = "Spotted",     label = "2 Spotted | 100 💸" },
	{ name = "Farm",        label = "3 Farm | 500 💸" },
	{ name = "Sweet",       label = "4 Sweet | 25k 💸" },
	{ name = "Beach",       label = "5 Beach | 750k 💸" },
	{ name = "Ocean",       label = "6 Ocean | 2.5m 💸" },
	{ name = "Samurai",     label = "7 Samurai | 20m 💸" },
	{ name = "Arctic",      label = "8 Arctic | 750m 💸" },
	{ name = "Volcanic",    label = "9 Volcanic | 2.21b 💸" },
	{ name = "Crystal",     label = "10 Crystal | 100 💰" },
	{ name = "GoldCrystal", label = "11 Gold Crystal | 3k 💰" },
	{ name = "Carnival",    label = "12 Carnival | 2k 💰" }
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
					Content = "Opening: " .. egg.name,
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
					Content = "Stopped: " .. egg.name,
					Duration = 2
				})
			end
		end
	})
end


-- 🔧 Функція для торкання об'єктів
local function touchTrigger(objectPath)
	pcall(function()
		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")
		local obj = objectPath
		if obj and obj:IsA("BasePart") then
			firetouchinterest(hrp, obj, 0)
			task.wait(0.1)
			firetouchinterest(hrp, obj, 1)
		end
	end)
end

------------------------------------------------
-- 🐾 PET CRAFT MACHINES
------------------------------------------------
OpenGUITab:CreateSection("🐾 Pet Craft Machines")

OpenGUITab:CreateButton({
	Name = "✨ Golden Pet Machine",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.GoldenTrigger)
		Rayfield:Notify({Title="Golden Machine", Content="Opened Golden Machine GUI", Duration=2})
	end
})

OpenGUITab:CreateButton({
	Name = "🌈 Rainbow Pet Machine",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.RainbowMachineTrigger)
		Rayfield:Notify({Title="Rainbow Machine", Content="Opened Rainbow Machine GUI", Duration=2})
	end
})

------------------------------------------------
-- 🛠️ UPGRADE SHOPS
------------------------------------------------
OpenGUITab:CreateSection("🛠️ Upgrade Shops")

OpenGUITab:CreateButton({
	Name = "🛍️ Upgrade Area",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.UpgradeArea)
		Rayfield:Notify({Title="Upgrade Area", Content="Opened Upgrade Area", Duration=2})
	end
})

OpenGUITab:CreateButton({
	Name = "💸 Upgrade Shop 1",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.UpgradeShop2)
		Rayfield:Notify({Title="Upgrade Shop 1", Content="Opened Upgrade Shop 1", Duration=2})
	end
})

OpenGUITab:CreateButton({
	Name = "💸 Upgrade Shop 2",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.UpgradeShop3)
		Rayfield:Notify({Title="Upgrade Shop 2", Content="Opened Upgrade Shop 2", Duration=2})
	end
})

OpenGUITab:CreateButton({
	Name = "💸 Upgrade Shop 3",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.UpgradeShop4)
		Rayfield:Notify({Title="Upgrade Shop 3", Content="Opened Upgrade Shop 3", Duration=2})
	end
})

------------------------------------------------
-- 💎 GEM CRAFT
------------------------------------------------
OpenGUITab:CreateSection("💎 Gem Craft")

OpenGUITab:CreateButton({
	Name = "💠 Diamond Smelt Machine",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.DiamondSmeltTrigger)
		Rayfield:Notify({Title="Gem Craft", Content="Opened Diamond Smelt Machine", Duration=2})
	end
})

------------------------------------------------
-- 🎁 CHEST COLLECTION
------------------------------------------------
OpenGUITab:CreateSection("🎁 Chests")

OpenGUITab:CreateButton({
	Name = "🍬 Candyland Chest",
	Callback = function()
		touchTrigger(workspace.PersistentObjects.CandylandChest)
		Rayfield:Notify({Title="Chest", Content="Collected Candyland Chest", Duration=2})
	end
})


------------------------------------------------
-- ⚙️ SETTINGS / PLAYER MODS
------------------------------------------------

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

------------------------------------------------
-- 🏃 SPEED / JUMP
------------------------------------------------
SettingsTab:CreateSection("🏃 Player Movement")

local speedValue = 16
local jumpValue = 50
local infiniteJump = false

SettingsTab:CreateSlider({
	Name = "🏃 Speed",
	Range = {16, 300},
	Increment = 1,
	CurrentValue = speedValue,
	Flag = "PlayerSpeed",
	Callback = function(v)
		speedValue = v
	end
})

SettingsTab:CreateSlider({
	Name = "🦘 Jump Power",
	Range = {50, 500},
	Increment = 5,
	CurrentValue = jumpValue,
	Flag = "JumpPower",
	Callback = function(v)
		jumpValue = v
	end
})

SettingsTab:CreateToggle({
	Name = "♾ Infinite Jump",
	CurrentValue = false,
	Flag = "InfiniteJump",
	Callback = function(state)
		infiniteJump = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			local char = player.Character or player.CharacterAdded:Wait()
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = speedValue
				hum.JumpPower = jumpValue
			end
		end)
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infiniteJump then
		local char = player.Character or player.CharacterAdded:Wait()
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

------------------------------------------------
-- ✈️ FLY / NOCLIP
------------------------------------------------
SettingsTab:CreateSection("✈️ Fly / Noclip")

local noclip = false

SettingsTab:CreateButton({
	Name = "✈️ Activate Fly GUI",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LimerBro/ScriptLimerHub/refs/heads/main/Fly%20Limer%20GUI"))()
		Rayfield:Notify({Title="Fly Loaded", Content="Fly GUI activated!", Duration=2})
	end
})

SettingsTab:CreateToggle({
	Name = "🚫 Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",
	Callback = function(state)
		noclip = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		if noclip and player.Character then
			pcall(function()
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end)
		end
	end
end)

------------------------------------------------
-- 🤖 BOT RUN
------------------------------------------------
SettingsTab:CreateSection("🤖 Bot Run")

SettingsTab:CreateButton({
	Name = "⚙️ Activate Bot Run",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LimerBro/ScriptLimerHub/refs/heads/main/Bot%20Run"))()
		Rayfield:Notify({Title="Bot Run", Content="Bot Run activated!", Duration=2})
	end
})

------------------------------------------------
-- 👁 ESP PLAYERS
------------------------------------------------
SettingsTab:CreateSection("👁 ESP Players")

local espEnabled = false
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "LimerHub_ESP"

local function createESP(plr)
	if plr == player then return end
	if not plr.Character then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = plr.Name .. "_ESP"
	highlight.FillTransparency = 0.7
	highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
	highlight.Adornee = plr.Character
	highlight.Parent = espFolder

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NameTag"
	billboard.Adornee = plr.Character:WaitForChild("Head")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.AlwaysOnTop = true
	billboard.Parent = espFolder

	local text = Instance.new("TextLabel", billboard)
	text.Size = UDim2.new(1, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.Text = plr.Name
	text.TextColor3 = Color3.new(0, 1, 0)
	text.TextScaled = true
end

SettingsTab:CreateToggle({
	Name = "👁 Enable ESP",
	CurrentValue = false,
	Flag = "ESP",
	Callback = function(state)
		espEnabled = state
		espFolder:ClearAllChildren()
		if state then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then createESP(plr) end
			end
			Players.PlayerAdded:Connect(function(p)
				p.CharacterAdded:Connect(function()
					if espEnabled then createESP(p) end
				end)
			end)
		end
	end
})

------------------------------------------------
-- 📍 TELEPORT TO PLAYER
------------------------------------------------
SettingsTab:CreateSection("📍 Teleport")

local function refreshPlayers()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then table.insert(list, p.Name) end
	end
	return list
end

local playersList = refreshPlayers()
local selectedPlayer = playersList[1] or ""

SettingsTab:CreateDropdown({
	Name = "🧍 Choose Player",
	Options = playersList,
	CurrentOption = selectedPlayer,
	Flag = "TPPlayer",
	Callback = function(v)
		selectedPlayer = v
	end
})

SettingsTab:CreateButton({
	Name = "⚡ Teleport to Player",
	Callback = function()
		local target = Players:FindFirstChild(selectedPlayer)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character:WaitForChild("HumanoidRootPart")
			hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			Rayfield:Notify({Title="Teleported!", Content="Teleported to "..selectedPlayer, Duration=2})
		else
			Rayfield:Notify({Title="Error", Content="Player not found or not loaded", Duration=2})
		end
	end
})

------------------------------------------------
-- ⚡ FPS BOOST
------------------------------------------------
SettingsTab:CreateSection("⚡ FPS Boost")

SettingsTab:CreateButton({
	Name = "💨 Apply FPS Boost",
	Callback = function()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
			if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
			if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
		end
		game.Lighting.GlobalShadows = false
		game.Lighting.FogEnd = 1e10
		Rayfield:Notify({Title="FPS Boost", Content="Textures removed, shadows disabled", Duration=2})
	end
})
