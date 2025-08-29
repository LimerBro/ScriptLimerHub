-- Вкажи тут ID гри, де скрипт має працювати
local allowedGameId = 93004918890416  

-- Перевіряємо, чи ми в правильній грі
if game.PlaceId ~= allowedGameId then
    return -- Якщо не та гра, скрипт не виконується
end

-- If an old hub already exists, remove it
local player = game.Players.LocalPlayer
if player.PlayerGui:FindFirstChild("HubMenu") then
    player.PlayerGui.HubMenu:Destroy()
end

-- Create main GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HubMenu"
gui.ResetOnSpawn = false

-- Create performance stats frame
local statsFrame = Instance.new("Frame", gui)
statsFrame.Name = "PerformanceStats"
statsFrame.Size = UDim2.new(0, 200, 0, 80)
statsFrame.Position = UDim2.new(1, -210, 0, 10)
statsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statsFrame.BackgroundTransparency = 0.3
statsFrame.BorderSizePixel = 0

local statsCorner = Instance.new("UICorner", statsFrame)
statsCorner.CornerRadius = UDim.new(0, 8)

-- FPS counter
local fpsLabel = Instance.new("TextLabel", statsFrame)
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.new(1, -10, 0, 20)
fpsLabel.Position = UDim2.new(0, 5, 0, 5)
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamMedium
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ping counter
local pingLabel = Instance.new("TextLabel", statsFrame)
pingLabel.Name = "Ping"
pingLabel.Size = UDim2.new(1, -10, 0, 20)
pingLabel.Position = UDim2.new(0, 5, 0, 25)
pingLabel.Text = "Ping: 0ms"
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.BackgroundTransparency = 1
pingLabel.Font = Enum.Font.GothamMedium
pingLabel.TextSize = 14
pingLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Real time clock
local timeLabel = Instance.new("TextLabel", statsFrame)
timeLabel.Name = "Time"
timeLabel.Size = UDim2.new(1, -10, 0, 20)
timeLabel.Position = UDim2.new(0, 5, 0, 45)
timeLabel.Text = "00:00:00"
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.BackgroundTransparency = 1
timeLabel.Font = Enum.Font.GothamMedium
timeLabel.TextSize = 14
timeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- FPS calculation
local function calculateFPS()
    local fps = 0
    local lastTime = tick()
    local frameCount = 0
    
    return function()
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            fps = math.floor(frameCount / (currentTime - lastTime))
            frameCount = 0
            lastTime = currentTime
        end
        return fps
    end
end

local getFPS = calculateFPS()

-- Ping calculation
local function getPing()
    local stats = game:GetService("Stats")
    local network = stats.Network
    return math.floor(network.ServerStatsItem["Data Ping"]:GetValue())
end

-- Update performance stats
game:GetService("RunService").RenderStepped:Connect(function()
    -- Update FPS
    fpsLabel.Text = "FPS: " .. getFPS()
    
    -- Update Ping (every second to avoid performance issues)
    if math.random(1, 60) == 1 then -- Update approximately once per second
        pingLabel.Text = "Ping: " .. getPing() .. "ms"
    end
    
    -- Update real time
    local currentTime = os.date("*t")
    timeLabel.Text = string.format("%02d:%02d:%02d", currentTime.hour, currentTime.min, currentTime.sec)
end)

-- Зберігаємо стан кнопок
local buttonStates = {}
local activeEggButtons = {}

-- Notification system
local function showNotification(text)
    local notification = Instance.new("TextLabel")
    notification.Text = "🔔 " .. text
    notification.Size = UDim2.new(0, 300, 0, 40)
    notification.Position = UDim2.new(1, -310, 1, -50)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.Font = Enum.Font.GothamMedium
    notification.TextSize = 14
    notification.AnchorPoint = Vector2.new(0, 1)
    notification.Parent = gui
    
    local corner = Instance.new("UICorner", notification)
    corner.CornerRadius = UDim.new(0, 8)
    
    -- Анімація появи
    notification.Position = UDim2.new(1, -310, 1, 10)
    notification:TweenPosition(UDim2.new(1, -310, 1, -50), "Out", "Quad", 0.5, true)
    
    -- Автоматичне видалення через 5 секунд
    delay(5, function()
        if notification then
            notification:TweenPosition(UDim2.new(1, -310, 1, 10), "Out", "Quad", 0.5, true, 
                function()
                    notification:Destroy()
                end)
        end
    end)
end

-- Main frame (container)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0.5, -125, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Rounded corners
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Scrollable area
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- will update automatically
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Auto-update CanvasSize for scrolling
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- Toggle button
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Menu"
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
local tbCorner = Instance.new("UICorner", toggleButton)
tbCorner.CornerRadius = UDim.new(0, 8)
toggleButton.Draggable = true

local opened = true
toggleButton.MouseButton1Click:Connect(function()
    opened = not opened
    frame.Visible = opened
end)

-- Label "Chicken Clicker 2" above buttons
local titleLabel = Instance.new("TextLabel", scroll)
titleLabel.Size = UDim2.new(1, -20, 0, 40)
titleLabel.LayoutOrder = 0
titleLabel.Text = "Chicken Clicker 2"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Function to create buttons
local function createButton(name, order, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.LayoutOrder = order
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = true
    btn.Name = name

    local btnCorner = Instance.new("UICorner", btn)  
    btnCorner.CornerRadius = UDim.new(0, 8)  

    btn.MouseButton1Click:Connect(function()
        local newState = callback()
        if newState ~= nil then
            buttonStates[name] = newState
            if newState then
                btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                showNotification("Активовано: " .. name)
            else
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                showNotification("Вимкнено: " .. name)
            end
        else
            showNotification("Активовано: " .. name)
        end
    end)

    return btn
end

-- Speed Hack (постійний)
local SPEED = 60
local function setSpeed(character)  
    local humanoid = character:FindFirstChildOfClass("Humanoid")  
    if humanoid then  
        humanoid.WalkSpeed = SPEED  
    end  
end

-- Застосувати спідхак одразу
if player.Character then
    setSpeed(player.Character)
end

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    setSpeed(char)
end)

showNotification("Спідхак активовано: швидкість " .. SPEED)

-- Buttons
local autoClick = false
createButton("Auto Click", 1, function()
    autoClick = not autoClick
    if autoClick then
        spawn(function()
            while autoClick do
                game:GetService("ReplicatedStorage").Remotes.Clicker:FireServer()
                task.wait(0)
            end
        end)
    end
    return autoClick
end)


createButton("Teleport Lobby 1", 3, function()
    player.Character:MoveTo(Vector3.new(245.6, 15.5, 719.0))
end)

createButton("Teleport Lobby 2", 4, function()
    player.Character:MoveTo(Vector3.new(312.8, 31.5, 949.7))
end)

createButton(" Hide Pets", 5, function()
    local playerPets = workspace:WaitForChild("PlayerPets")
    for _, obj in pairs(playerPets:GetChildren()) do
        obj:Destroy()
    end
    playerPets.ChildAdded:Connect(function(child)
        child:Destroy()
    end)
end)

createButton("Toggle Game UI", 6, function()
    local gameUI = player.PlayerGui:FindFirstChild("GameUI")
    if gameUI and gameUI:FindFirstChild("Popups") then
        gameUI.Popups.Visible = not gameUI.Popups.Visible
    end
end)

createButton("Buy Luck", 7, function()
    player.Data.Gamepasses.Lucky.Value = true
end)

-- Auto Egg Menu
local eggMenuOpen = false
local eggMenuFrame = nil
local autoEggActive = false
local currentEggType = ""

local function stopAllEggOpening()
    autoEggActive = false
    -- Скидаємо колір всіх кнопок яєць
    if eggMenuFrame then
        for _, btn in pairs(activeEggButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end
    activeEggButtons = {}
    showNotification("Зупинено всі авто-відкриття яєць")
end

local function createEggMenu()
    if eggMenuFrame then
        eggMenuFrame:Destroy()
        eggMenuFrame = nil
        eggMenuOpen = false
        return
    end
    
    eggMenuOpen = true
    eggMenuFrame = Instance.new("Frame", gui)
    eggMenuFrame.Size = UDim2.new(0, 200, 0, 350)
    eggMenuFrame.Position = UDim2.new(0.5, 150, 0.5, -175)
    eggMenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    eggMenuFrame.BorderSizePixel = 0
    eggMenuFrame.Active = true
    eggMenuFrame.Draggable = true
    
    local corner = Instance.new("UICorner", eggMenuFrame)
    corner.CornerRadius = UDim.new(0, 12)
    
    local title = Instance.new("TextLabel", eggMenuFrame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "Виберіть яйце"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    
    local scroll = Instance.new("ScrollingFrame", eggMenuFrame)
    scroll.Size = UDim2.new(1, -10, 1, -80)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Список яєць
    local eggTypes = {
        "Starter Egg", "Beginner Egg", "Advanced Egg", "Release Egg", 
        "Sand Egg", "Beach Egg", "Pink Egg", "Candy Egg",
        "Toxic Egg", "Nuclear Egg", "Graveyard Egg", "Stone Egg"
    }
    
    for i, eggName in ipairs(eggTypes) do
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.LayoutOrder = i
        btn.Text = eggName
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.AutoButtonColor = true
        btn.Name = eggName
        
        local btnCorner = Instance.new("UICorner", btn)  
        btnCorner.CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            if activeEggButtons[eggName] then
                -- Якщо кнопка вже активна, вимикаємо
                activeEggButtons[eggName] = nil
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                showNotification("Зупинено: " .. eggName)
            else
                -- Вимикаємо всі інші кнопки
                for name, eggBtn in pairs(activeEggButtons) do
                    eggBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
                activeEggButtons = {}
                
                -- Активуємо поточну кнопку
                activeEggButtons[eggName] = btn
                btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                currentEggType = eggName
                autoEggActive = true
                showNotification("Авто-відкриття: " .. eggName)
                
                spawn(function()
                    while autoEggActive and activeEggButtons[eggName] do
                        game:GetService("ReplicatedStorage").Remotes.Egg:InvokeServer(eggName, 3)
                        task.wait(0.1)
                    end
                end)
            end
        end)
    end
    
    -- Кнопка зупинки всіх авто-відкриттів
    local stopBtn = Instance.new("TextButton", eggMenuFrame)
    stopBtn.Size = UDim2.new(1, -10, 0, 30)
    stopBtn.Position = UDim2.new(0, 5, 1, -35)
    stopBtn.Text = "STOP ALL"
    stopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopBtn.AutoButtonColor = true
    
    local stopCorner = Instance.new("UICorner", stopBtn)  
    stopCorner.CornerRadius = UDim.new(0, 6)
    
    stopBtn.MouseButton1Click:Connect(function()
        stopAllEggOpening()
    end)
    
    -- Кнопка закриття
    local closeBtn = Instance.new("TextButton", eggMenuFrame)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local btnCorner = Instance.new("UICorner", closeBtn)  
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    closeBtn.MouseButton1Click:Connect(function()
        eggMenuFrame:Destroy()
        eggMenuFrame = nil
        eggMenuOpen = false
    end)
end

createButton(" Auto Egg", 8, createEggMenu)

createButton("Buy x2 Click", 9, function()
    player.Data.Gamepasses.DoubleCurrency.Value = true
end)

-- 11. Anti-AFK
local antiAFK = false
createButton(" Anti-AFK", 11, function()
    antiAFK = not antiAFK
    if antiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        spawn(function()
            while antiAFK do
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
                task.wait(60)
            end
        end)
    end
    return antiAFK
end)
