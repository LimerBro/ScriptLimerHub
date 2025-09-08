-- If an old hub already exists, remove it
local player = game.Players.LocalPlayer
if player.PlayerGui:FindFirstChild("HubMenu") then
    player.PlayerGui.HubMenu:Destroy()
end

-- Create main GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "limHub"
gui.ResetOnSpawn = false

-- Gradient function
local function addGradient(parent, color1, color2)
    local gradient = Instance.new("UIGradient", parent)
    gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, color1),
    ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = 90
    return gradient
end

-- Notification function
local function showNotification(message)
    local notif = Instance.new("TextLabel", gui)
    notif.Size = UDim2.new(0, 200, 0, 40)
    notif.Position = UDim2.new(0.5, -100, 0, 10)
    notif.Text = message
    notif.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
    notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
    notif.Font = Enum.Font.FredokaOne
    notif.TextSize = 25
    notif.ZIndex = 10
    
    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0, 8)
    
    game:GetService("TweenService"):Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, -50)}):Play()
    wait(2)
    game:GetService("TweenService"):Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, 10)}):Play()
    wait(0.5)
    notif:Destroy()
end

-- Create performance stats frame
local statsFrame = Instance.new("Frame", gui)
statsFrame.Name = "PerformanceStats"
statsFrame.Size = UDim2.new(0, 200, 0, 80)
statsFrame.Position = UDim2.new(1, -210, 0, 10)
statsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
statsFrame.BackgroundTransparency = 0.15
statsFrame.BorderSizePixel = 0

local statsCorner = Instance.new("UICorner", statsFrame)
statsCorner.CornerRadius = UDim.new(0, 10)

-- Add gradient and shadow
addGradient(statsFrame, Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))

local shadow = Instance.new("ImageLabel", statsFrame)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0) -- Чорна тінь
shadow.ImageTransparency = 0.5
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1

-- FPS counter
local fpsLabel = Instance.new("TextLabel", statsFrame)
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.new(1, -10, 0, 20)
fpsLabel.Position = UDim2.new(0, 5, 0, 5)
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Font = Enum.Font.FredokaOne

-- Ping counter
local pingLabel = fpsLabel:Clone()
pingLabel.Parent = statsFrame
pingLabel.Name = "Ping"
pingLabel.Position = UDim2.new(0, 5, 0, 25)
pingLabel.Text = "Ping: 0ms"
pingLabel.Font = Enum.Font.FredokaOne

-- Real time clock
local timeLabel = fpsLabel:Clone()
timeLabel.Parent = statsFrame
timeLabel.Name = "Time"
timeLabel.Position = UDim2.new(0, 5, 0, 45)
timeLabel.Text = "00:00:00"
timeLabel.Font = Enum.Font.FredokaOne -- Виправлено опечатку

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

local function getPing()
    local stats = game:GetService("Stats")
    local network = stats.Network
    return math.floor(network.ServerStatsItem["Data Ping"]:GetValue())
end

-- Update performance stats
game:GetService("RunService").RenderStepped:Connect(function()
    fpsLabel.Text = "FPS: " .. getFPS()
    if math.random(1, 60) == 1 then
        pingLabel.Text = "Ping: " .. getPing() .. "ms"
    end
    local currentTime = os.date("*t")
    timeLabel.Text = string.format("%02d:%02d:%02d", currentTime.hour, currentTime.min, currentTime.sec)
end)

-- Main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 420)
frame.Position = UDim2.new(0.5, -130, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 14)
addGradient(frame, Color3.fromRGB(40, 40, 40), Color3.fromRGB(0, 0, 0))

-- Shadow for frame
local frameShadow = shadow:Clone()
frameShadow.Parent = frame

-- Scroll
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- Toggle button
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 110, 0, 42)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Menu"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
toggleButton.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 25
toggleButton.Draggable = true
toggleButton.Font = Enum.Font.FredokaOne

local tbCorner = Instance.new("UICorner", toggleButton)
tbCorner.CornerRadius = UDim.new(0, 10)

local opened = true
toggleButton.MouseButton1Click:Connect(function()
    opened = not opened
    if opened then
        frame:TweenPosition(UDim2.new(0.5, -130, 0.5, -210), "Out", "Quart", 0.4, true)
    else
        frame:TweenPosition(UDim2.new(0.5, -130, 1.5, 0), "In", "Quart", 0.4, true)
    end
end)

-- Title
local titleLabel = Instance.new("TextLabel", scroll)
titleLabel.Size = UDim2.new(1, -20, 0, 40)
titleLabel.LayoutOrder = 0
titleLabel.Text = "LimerHab"
titleLabel.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.TextStrokeTransparency = 0.4
titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
titleLabel.Font = Enum.Font.FredokaOne

-- Зберігаємо стан кнопок
local buttonStates = {}
local activeEggButtons = {}

-- Function to create buttons
local function createButton(name, order, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.LayoutOrder = order
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Зелений фон
    btn.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
    btn.AutoButtonColor = true
    btn.Name = name
    btn.TextSize = 25
    btn.Font = Enum.Font.FredokaOne
    
    local btnCorner = Instance.new("UICorner", btn)    
    btnCorner.CornerRadius = UDim.new(0, 8)  
    
    btn.MouseButton1Click:Connect(function()  
        local newState = callback()  
        if newState ~= nil then  
            buttonStates[name] = newState  
            if newState then  
                btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Яскраво-зелений при активації
                showNotification("Activated:" .. name)  
            else  
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Звичайний зелений
                showNotification("Disabled:" .. name)  
            end  
        else  
            showNotification("Activated:" .. name)  
        end  
    end)  
    
    return btn
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- === SpeedHack ===
local desiredSpeed = 16
local speedInputBox

createButton("SpeedHack", 1, function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    
    if not buttonStates["SpeedHack"] then  
        -- створюємо поле якщо його нема  
        if not speedInputBox then  
            speedInputBox = Instance.new("TextBox", scroll)  
            speedInputBox.Size = UDim2.new(1, -20, 0, 35)  
            speedInputBox.LayoutOrder = 2  
            speedInputBox.PlaceholderText = "Введи швидкість (напр. 50)"  
            speedInputBox.Text = tostring(desiredSpeed)  
            speedInputBox.ClearTextOnFocus = false  
            speedInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Зелений фон
            speedInputBox.TextColor3 = Color3.new(225, 225, 225) -- Чорний текст
            speedInputBox.Font = Enum.Font.FredokaOne  
            speedInputBox.TextSize = 25
            Instance.new("UICorner", speedInputBox).CornerRadius = UDim.new(0, 8)  
            
            speedInputBox.FocusLost:Connect(function()  
                local n = tonumber(speedInputBox.Text)  
                if n and n > 0 then  
                    desiredSpeed = n  
                    local hum2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")  
                    if hum2 then hum2.WalkSpeed = desiredSpeed end  
                    else  
                        speedInputBox.Text = tostring(desiredSpeed)  
                    end  
                end)  
            end  
            
            hum.WalkSpeed = desiredSpeed  
            return true  
        else  
            hum.WalkSpeed = 16  
            if speedInputBox then  
                speedInputBox:Destroy()  
                speedInputBox = nil  
            end  
            return false  
        end
    end)
    
    -- === Infinite Jump ===
    local infiniteJumpEnabled = false
    createButton("Infinite Jump", 3, function()
        infiniteJumpEnabled = not infiniteJumpEnabled
        return infiniteJumpEnabled
    end)
    
    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState("Jumping")
            end
        end
    end)
    
    -- === Noclip ===
    local noclip = false
    createButton("Noclip", 4, function()
        noclip = not noclip
        return noclip
    end)
    
    RunService.Stepped:Connect(function()
        if noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide == true then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    -- === ESP (білі гравці) ===
    local espEnabled = false
    createButton("ESP Players", 5, function()
        espEnabled = not espEnabled
        if not espEnabled then
            for _, v in pairs(Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("Highlight") then
                    v.Character.Highlight:Destroy()
                end
            end
        end
        return espEnabled
    end)
    
    RunService.RenderStepped:Connect(function()
        if espEnabled then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    if not plr.Character:FindFirstChild("Highlight") then
                        local h = Instance.new("Highlight")
                        h.FillColor = Color3.fromRGB(255,255,255)
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 1
                        h.Parent = plr.Character
                    end
                end
            end
        end
    end)
    
    -- === TP Menu ===
    local tpFrame
    local tpScroll
    local tpLayout
    
    local function refreshPlayers()
        if not tpScroll then return end
        for _, child in pairs(tpScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local btn = Instance.new("TextButton", tpScroll)
                btn.Size = UDim2.new(1, -5, 0, 30)
                btn.Text = plr.Name
                btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
                btn.TextColor3 = Color3.new(0, 225, 0) -- Чорний текст
                btn.Font = Enum.Font.FredokaOne
                btn.TextSize = 25
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
                
                btn.MouseButton1Click:Connect(function()  
                    if LocalPlayer.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then  
                        LocalPlayer.Character:MoveTo(plr.Character.HumanoidRootPart.Position + Vector3.new(0,2,0))  
                        showNotification("ТП до " .. plr.Name)  
                    end  
                end)  
            end  
        end  
        tpScroll.CanvasSize = UDim2.new(0,0,0,tpLayout.AbsoluteContentSize.Y+10)
    end
    
    local function openTPMenu()
        if tpFrame and tpFrame.Parent then tpFrame:Destroy() end
        
        tpFrame = Instance.new("Frame", gui)  
        tpFrame.Name = "TPFrame"  
        tpFrame.Size = UDim2.new(0, 180, 0, 300)  
        tpFrame.Position = UDim2.new(1, -190, 0.5, -150)  
        tpFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Зелений фон
        tpFrame.BorderSizePixel = 0  
        
        Instance.new("UICorner", tpFrame).CornerRadius = UDim.new(0, 12)  
        
        local closeBtn = Instance.new("TextButton", tpFrame)  
        closeBtn.Size = UDim2.new(0, 30, 0, 30)  
        closeBtn.Position = UDim2.new(1, -35, 0, 5)  
        closeBtn.Text = "×"  
        closeBtn.TextColor3 = Color3.new(200, 0, 0) -- Чорний текст
        closeBtn.BackgroundTransparency = 1  
        closeBtn.Font = Enum.Font.FredokaOne  
        closeBtn.TextSize = 40
        closeBtn.MouseButton1Click:Connect(function()  
            tpFrame:Destroy()  
        end)  
        
        tpScroll = Instance.new("ScrollingFrame", tpFrame)  
        tpScroll.Size = UDim2.new(1, -10, 1, -50)  
        tpScroll.Position = UDim2.new(0, 5, 0, 40)  
        tpScroll.CanvasSize = UDim2.new(0,0,0,0)  
        tpScroll.ScrollBarThickness = 6  
        tpScroll.BackgroundTransparency = 1  
        
        tpLayout = Instance.new("UIListLayout", tpScroll)  
        tpLayout.Padding = UDim.new(0,5)  
        
        refreshPlayers()
    end
    
    createButton("TP Menu", 6, function()
        openTPMenu()
    end)
    
    -- Aimbot variables
    local aimbotEnabled = false
    local aimPart = "Head" -- можна міняти на "HumanoidRootPart" чи інше
    
    -- Функція пошуку найближчого гравця
    local function getClosestPlayer()
        local closestPlayer = nil
        local shortestDistance = math.huge
        local localPlayer = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild(aimPart) then
                local pos = camera:WorldToViewportPoint(player.Character[aimPart].Position)
                local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
        return closestPlayer
    end
    
    -- Кнопка в меню
    createButton("Aimbot", 200, function()
        aimbotEnabled = not aimbotEnabled
        return aimbotEnabled
    end)
    
    -- Основна логіка
    game:GetService("RunService").RenderStepped:Connect(function()
        if aimbotEnabled then
            local closest = getClosestPlayer()
            if closest and closest.Character and closest.Character:FindFirstChild(aimPart) then
                workspace.CurrentCamera.CFrame = CFrame.new(
                workspace.CurrentCamera.CFrame.Position,
                closest.Character[aimPart].Position
                )
            end
        end
    end)
    
    Players.PlayerAdded:Connect(refreshPlayers)
    Players.PlayerRemoving:Connect(refreshPlayers)
