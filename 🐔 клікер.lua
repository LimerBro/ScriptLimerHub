-- Якщо вже є старий хаб - видаляємо
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("HubMenu") then
	game.Players.LocalPlayer.PlayerGui.HubMenu:Destroy()
end

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HubMenu"

-- Головний фрейм
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0.5, -125, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true

-- Заокруглення
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Кнопка для відкриття/скривання
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Меню"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.new(0,225,0)
local tbCorner = Instance.new("UICorner", toggleButton)
tbCorner.CornerRadius = UDim.new(0, 8)

-- Функція скривання/відкривання
local opened = true
toggleButton.MouseButton1Click:Connect(function()
	opened = not opened
	frame.Visible = opened
end)

-- Функція створення кнопок

local function createButton(name, order, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 25, 0, 20 + (order * 50))
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	btn.TextColor3 = Color3.new(1,1,1)
	local bCorner = Instance.new("UICorner", btn)
	bCorner.CornerRadius = UDim.new(0, 8)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Автоклік
local autoClick = false
createButton("1. Автоклік", 0, function()
	autoClick = not autoClick
	if autoClick then
		spawn(function()
			while autoClick do
				game:GetService("ReplicatedStorage").Remotes.Clicker:FireServer()
				task.wait(0.1)
			end
		end)
	end
end)

-- Авто ребітх
local autoReb = false
createButton("2. Авто Ребітх", 1, function()
	autoReb = not autoReb
	if autoReb then
		spawn(function()
			while autoReb do
				game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
				task.wait(1)
			end
		end)
	end
end)

-- Телепорт Лобі 1
createButton("3. Телепорт Лобі 1", 2, function()
	player.Character:MoveTo(Vector3.new(245.6, 15.5, 719.0))
end)

-- Телепорт Лобі 2
createButton("4. Телепорт Лобі 2", 3, function()
	player.Character:MoveTo(Vector3.new(312.8, 31.5, 949.7))
end)

-- Купити 100 спінів
createButton("5. Купити 100 Спінів", 4, function()
	game:GetService("ReplicatedStorage").Remotes.Spins.BuySpin:FireServer(100)
end)

-- Скрить GUI ігри
createButton("6. Скрить GameUI", 5, function()
	player.PlayerGui.GameUI.Popups.Visible = not player.PlayerGui.GameUI.Popups.Visible
end)

-- Купити Удачу
createButton("7. Купити Удачу", 6, function()
	player.Data.Gamepasses.Lucky.Value = true
end)
-- Автояйце
local autoClick = false
createButton("8. Авто Яйце", 7, function()
	autoClick = not autoClick
	if autoClick then
		spawn(function()
			while autoClick do
				game:GetService("ReplicatedStorage").Remotes.Egg:InvokeServer("Stone Egg",3)
				task.wait(0.1)
			end
		end)
	end
end)
-- Купити двойной клік
createButton("9. Купити х2 клік", 8, function()
	player.Data.Gamepasses.DoubleCurrency = true
end)

