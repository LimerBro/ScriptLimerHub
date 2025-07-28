local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Унікальне ім'я GUI
local guiName = "LimerHubUIv7"
if player:FindFirstChild("PlayerGui"):FindFirstChild(guiName) then
    player.PlayerGui[guiName]:Destroy()
end

-- Головний GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = guiName
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Кнопка відкриття меню
local openButton = Instance.new("ImageButton")
openButton.Size = UDim2.new(0, 50, 0, 50)
openButton.Position = UDim2.new(0.2, 0, 0.5, 0)
openButton.Image = "rbxassetid://15363984215"
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.Visible = false
openButton.Parent = gui
openButton.Draggable = true
openButton.ZIndex = 5
Instance.new("UICorner", openButton).CornerRadius = UDim.new(1, 0)
local openButtonStroke = Instance.new("UIStroke", openButton)
openButtonStroke.Color = Color3.fromRGB(0, 0, 0)
openButtonStroke.Thickness = 4

-- Основне вікно
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.4, 0, 0.5, 0)
main.Position = UDim2.new(0.5, -250, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
main.Active = true
main.Draggable = true
main.ZIndex = 1
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(0, 0, 0)
mainStroke.Thickness = 4

-- Градієнт фону
local mainGradient = Instance.new("UIGradient", main)
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))
}
mainGradient.Rotation = 45

-- Заголовок
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "LimerHub v7"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Center
title.ZIndex = 1
title.BackgroundTransparency = 1

-- Вкладки під заголовком, горизонтально
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(1, -20, 0, 50)
tabFrame.Position = UDim2.new(0, 10, 0, 50)
tabFrame.BackgroundTransparency = 1
tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabFrame.ZIndex = 1
Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0, 12)
local tabFrameStroke = Instance.new("UIStroke", tabFrame)
tabFrameStroke.Color = Color3.fromRGB(0, 0, 0)
tabFrameStroke.Thickness = 0

-- Градієнт вкладок
local tabGradient = Instance.new("UIGradient", tabFrame)
tabGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))
}
tabGradient.Rotation = 90

-- Додано нову вкладку "Чіти"
local tabs = {
    {name = "Main", icon = "rbxassetid://133172752957923"}, -- заміни на свій ID
    {name = "Profile", icon = "rbxassetid://13585614827"},
    {name = "Players", icon = "rbxassetid://14206975355"},
}
local contentFrames = {}

-- Функція перемикання вкладок
local function switchTab(name)
    for tabName, frame in pairs(contentFrames) do
        frame.Visible = (tabName == name)
    end
end

local tabY = 15
for _, tab in pairs(tabs) do
    local name = tab.name
    local icon = tab.icon

    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(0.3, 0, 0, 40)
    btn.Position = UDim2.new(0.1, tabY, 0, 5)
    btn.Text = "   " .. name -- Додано пробіл для зміщення тексту
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false

    -- Іконка
    local iconImage = Instance.new("ImageLabel", btn)
    iconImage.Size = UDim2.new(0, 24, 0, 24)
    iconImage.Position = UDim2.new(0, 10, 0.5, -12)
    iconImage.Image = icon
    iconImage.BackgroundTransparency = 1

    -- Стиль кнопки
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(0, 0, 0)
    btnStroke.Thickness = 1

    -- Градієнт на кнопку  
    local btnGradient = Instance.new("UIGradient", btn)  
    btnGradient.Color = ColorSequence.new{  
        ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
    }  
    btnGradient.Rotation = 90  

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundTransparency = 0.3 }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
    end)

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Контент для вкладки
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, -120, 1, -120)
    content.Position = UDim2.new(0, 60, 0, 100)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.ZIndex = 1
    contentFrames[name] = content
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 20)
    -- Клік по вкладці
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
        TweenService:Create(btn, TweenInfo.new(0.1), { BackgroundTransparency = 0.5 }):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), { BackgroundTransparency = 0 }):Play()
    end)

    tabY = tabY + 100
end

-- Кнопка закриття
local closeBtn = Instance.new("TextButton", main)
closeBtn.Text = "❌"
closeBtn.Size = UDim2.new(0, 30, 0, 24)
closeBtn.Position = UDim2.new(1, -36, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.ZIndex = 1

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = Color3.fromRGB(255, 255, 255)
closeBtnStroke.Thickness = 1

-- Анімація відкриття
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 0, 0, 0)
main.Visible = true

local openTween = TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0.4, 0, 0.5, 0),
    BackgroundTransparency = 0
})
openTween:Play()

-- Закриття
closeBtn.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    closeTween:Play()
    closeTween.Completed:Connect(function()
        main.Visible = false
        openButton.Visible = true
    end)
end)

-- Показати кнопку відкриття після закриття
openButton.MouseButton1Click:Connect(function()
    main.Visible = true
    openButton.Visible = false
    openTween:Play()
end)

-- Додаємо функції до вкладки Main
local mainFrame = contentFrames["Main"]
if mainFrame then
    -- Спочатку створюємо ScrollingFrame для можливості гортання
    local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800) -- Дозволяємо гортання
    
    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Функція для створення кнопок (Speed/Jump тепер у стилі чітів)
    local function createCheatButton(text, yPos, callback)
        local btn = Instance.new("TextButton", scrollFrame)
        btn.Size = UDim2.new(0.9, 0, 0, 50)
        btn.Position = UDim2.new(0.05, 0, 0, yPos)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.AutoButtonColor = false
        btn.ZIndex = 2
        
        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Thickness = 0
        
        local btnGradient = Instance.new("UIGradient", btn)  
        btnGradient.Color = ColorSequence.new{  
            ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
            ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
        }
        btnGradient.Rotation = 90
        
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
        
        btn.MouseButton1Click:Connect(function()
            callback()
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
            wait(0.1)
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
        end)
        
        return btn
    end

-- 🔧 Speed Button with TextBox (fixed version)
local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0.9, 0, 0, 50)
speedButton.Position = UDim2.new(0.05, 0, 0, 60)
speedButton.Text = "⚡ Speed: 16"
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
speedButton.Font = Enum.Font.GothamBold
speedButton.TextSize = 18
speedButton.AutoButtonColor = false
speedButton.ZIndex = 2
speedButton.Parent = scrollFrame

-- Apply same styling as other buttons
local btnStroke = Instance.new("UIStroke", speedButton)
btnStroke.Color = Color3.fromRGB(255, 255, 255)
btnStroke.Thickness = 0

local btnGradient = Instance.new("UIGradient", speedButton)  
btnGradient.Color = ColorSequence.new{  
    ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
}
btnGradient.Rotation = 90

Instance.new("UICorner", speedButton).CornerRadius = UDim.new(0, 12)

-- Add hover effects
speedButton.MouseEnter:Connect(function()
    TweenService:Create(speedButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

speedButton.MouseLeave:Connect(function()
    TweenService:Create(speedButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)

-- Click handler
speedButton.MouseButton1Click:Connect(function()
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.BackgroundTransparency = 1
    textBox.Text = tostring(speedButton.Text:match("%d+") or "16")
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.GothamBold
    textBox.TextSize = 18
    textBox.TextXAlignment = Enum.TextXAlignment.Center
    textBox.Parent = speedButton
    
    textBox.FocusLost:Connect(function()
        local speed = tonumber(textBox.Text)
        if speed then
            speed = math.clamp(speed, 16, 100)
            speedButton.Text = "⚡ Speed: " .. speed
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
        textBox:Destroy()
    end)
    
    textBox:CaptureFocus()
end)

-- 🔧 Jump Button with TextBox (fixed version)
local jumpButton = Instance.new("TextButton")
jumpButton.Name = "JumpButton"
jumpButton.Size = UDim2.new(0.9, 0, 0, 50)
jumpButton.Position = UDim2.new(0.05, 0, 0, 120)
jumpButton.Text = "🦘 Jump: 50"
jumpButton.TextColor3 = Color3.new(1, 1, 1)
jumpButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
jumpButton.Font = Enum.Font.GothamBold
jumpButton.TextSize = 18
jumpButton.AutoButtonColor = false
jumpButton.ZIndex = 2
jumpButton.Parent = scrollFrame

-- Apply same styling
local jumpBtnStroke = Instance.new("UIStroke", jumpButton)
jumpBtnStroke.Color = Color3.fromRGB(255, 255, 255)
jumpBtnStroke.Thickness = 0

local jumpBtnGradient = Instance.new("UIGradient", jumpButton)  
jumpBtnGradient.Color = ColorSequence.new{  
    ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
}
jumpBtnGradient.Rotation = 90

Instance.new("UICorner", jumpButton).CornerRadius = UDim.new(0, 12)

-- Add hover effects
jumpButton.MouseEnter:Connect(function()
    TweenService:Create(jumpButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

jumpButton.MouseLeave:Connect(function()
    TweenService:Create(jumpButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)

-- Click handler
jumpButton.MouseButton1Click:Connect(function()
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.BackgroundTransparency = 1
    textBox.Text = tostring(jumpButton.Text:match("%d+") or "50")
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.GothamBold
    textBox.TextSize = 18
    textBox.TextXAlignment = Enum.TextXAlignment.Center
    textBox.Parent = jumpButton
    
    textBox.FocusLost:Connect(function()
        local jump = tonumber(textBox.Text)
        if jump then
            jump = math.clamp(jump, 50, 200)
            jumpButton.Text = "🦘 Jump: " .. jump
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = jump
            end
        end
        textBox:Destroy()
    end)
    
    textBox:CaptureFocus()
end)


-- FPS Boost
    createCheatButton("🖥️ FPS Boost", 120, function()
        local light = game:GetService("Lighting")
        light.GlobalShadows = false
        light.FogEnd = 1e6
        settings().Rendering.QualityLevel = 1
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "FPS Boost",
            Text = "Activated!",
            Duration = 3
        })
    end)

-- Додаємо ESP функціонал до вкладки Main

local mainFrame = contentFrames["Main"]
if mainFrame then
    -- Спочатку створюємо кнопку для ESP
    local espEnabled = false
    local espObjects = {}
    local espColors = {
        team = Color3.fromRGB(0, 255, 0),   -- Зелений для своєї команди
        enemy = Color3.fromRGB(255, 0, 0),   -- Червоний для ворогів
        neutral = Color3.fromRGB(255, 255, 0) -- Жовтий для нейтральних
    }

    local espButton = Instance.new("TextButton")
    espButton.Name = "ESPButton"
    espButton.Size = UDim2.new(0.9, 0, 0, 50)
    espButton.Position = UDim2.new(0.05, 0, 0, 180) -- Позиція після інших кнопок
    espButton.Text = "👁️ ESP (Вкл/Вимк)"
    espButton.TextColor3 = Color3.new(1, 1, 1)
    espButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    espButton.Font = Enum.Font.GothamBold
    espButton.TextSize = 18
    espButton.AutoButtonColor = false
    espButton.ZIndex = 2
    espButton.Parent = scrollFrame

    -- Стилізація кнопки
    local btnStroke = Instance.new("UIStroke", espButton)
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 0

    local btnGradient = Instance.new("UIGradient", espButton)  
    btnGradient.Color = ColorSequence.new{  
        ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
    }
    btnGradient.Rotation = 90

    Instance.new("UICorner", espButton).CornerRadius = UDim.new(0, 12)

    -- Функція для створення ESP елементів
    local function createESP(character)
        if not character then return end
        
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 3)
        local head = character:WaitForChild("Head", 3)
        if not humanoidRootPart or not head then return end
        
        local playerObj = game:GetService("Players"):GetPlayerFromCharacter(character)
        if not playerObj or playerObj == player then return end
        
        -- Визначаємо колір в залежності від команди
        local espColor
        if game:GetService("Players").LocalPlayer.Team then
            if playerObj.Team == game:GetService("Players").LocalPlayer.Team then
                espColor = espColors.team
            else
                espColor = espColors.enemy
            end
        else
            espColor = espColors.neutral
        end
        
        -- Створюємо Highlight для підсвічування
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.Adornee = character
        highlight.FillColor = espColor
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = espColor
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        
        -- Додаємо ім'я гравця
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Name"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 1000
        
        local nameLabel = Instance.new("TextLabel", billboard)
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.Text = playerObj.Name
        nameLabel.TextColor3 = espColor
        nameLabel.BackgroundTransparency = 1
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        
        billboard.Parent = character
        
        -- Додаємо відстань
        local distanceBillboard = Instance.new("BillboardGui")
        distanceBillboard.Name = "ESP_Distance"
        distanceBillboard.Adornee = head
        distanceBillboard.Size = UDim2.new(0, 200, 0, 30)
        distanceBillboard.StudsOffset = Vector3.new(0, 1.5, 0)
        distanceBillboard.AlwaysOnTop = true
        distanceBillboard.MaxDistance = 1000
        
        local distanceLabel = Instance.new("TextLabel", distanceBillboard)
        distanceLabel.Size = UDim2.new(1, 0, 1, 0)
        distanceLabel.TextColor3 = espColor
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.TextSize = 12
        distanceLabel.TextStrokeTransparency = 0
        distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        
        distanceBillboard.Parent = character
        
        -- Зберігаємо об'єкти для подальшого видалення
        espObjects[playerObj] = {
            highlight = highlight,
            billboard = billboard,
            distanceBillboard = distanceBillboard,
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                if character and character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    distanceLabel.Text = string.format("[%.1f studs]", distance)
                end
            end)
        }
    end

    -- Функція для видалення ESP
    local function removeESP(playerObj)
        if espObjects[playerObj] then
            espObjects[playerObj].highlight:Destroy()
            espObjects[playerObj].billboard:Destroy()
            espObjects[playerObj].distanceBillboard:Destroy()
            espObjects[playerObj].connection:Disconnect()
            espObjects[playerObj] = nil
        end
    end

    -- Функція для оновлення ESP
    local function updateESP()
        for _, playerObj in ipairs(game:GetService("Players"):GetPlayers()) do
            if playerObj ~= player then
                if espEnabled then
                    if playerObj.Character then
                        createESP(playerObj.Character)
                    end
                    playerObj.CharacterAdded:Connect(function(character)
                        createESP(character)
                    end)
                else
                    removeESP(playerObj)
                end
            end
        end
    end

    -- Обробник кліку для кнопки ESP
    espButton.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        if espEnabled then
            espButton.Text = "👁️ ESP (Увімкнено)"
            updateESP()
        else
            espButton.Text = "👁️ ESP (Вимкнено)"
            -- Видаляємо всі ESP об'єкти
            for playerObj, _ in pairs(espObjects) do
                removeESP(playerObj)
            end
        end
        TweenService:Create(espButton, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
        wait(0.1)
        TweenService:Create(espButton, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end)

    -- Автоматичне оновлення при зміні гравців
    game:GetService("Players").PlayerAdded:Connect(function()
        if espEnabled then updateESP() end
    end)

    game:GetService("Players").PlayerRemoving:Connect(function(playerObj)
        removeESP(playerObj)
    end)
end

    -- Anti-AFK
    createCheatButton("⏳ Anti-AFK", 180, function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-AFK",
            Text = "Enabled",
            Duration = 3
        })
    end)

    -- Player Join Notify
    createCheatButton("👥 Player Join Notify", 240, function()
        local Players = game:GetService("Players")
        Players.PlayerAdded:Connect(function(player)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Player Joined",
                Text = player.Name .. " joined the game",
                Duration = 5
            })
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Join Notifications",
            Text = "Enabled",
            Duration = 3
        })
    end)

    -- Infinite Jump
    createCheatButton("∞ Infinite Jump", 300, function()
        local infiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Infinite Jump",
            Text = "Press SPACE to toggle",
            Duration = 3
        })
    end)

    -- 3 пусті кнопки для кастомних скриптів
    createCheatButton("🤖Bot Run", 360, function()
        -- 🧹 Видаляємо старий GUI
if game:GetService("CoreGui"):FindFirstChild("RunnerGui") then
    game:GetService("CoreGui").RunnerGui:Destroy()
end

-- 📁 Ім'я файлу
local saveFile = "runner_coords.txt"

-- 🔄 Завантаження з файлу (якщо є)
local savedA, savedB
if isfile and isfile(saveFile) then
    local content = readfile(saveFile)
    savedA, savedB = content:match("(.+)\n(.+)")
end

-- 🎨 GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RunnerGui"
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 280)
frame.Position = UDim2.new(0.5, -160, 0.5, -140)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Кнопка згортання/розгортання
local toggleMinimize = Instance.new("TextButton")
toggleMinimize.Text = "─"
toggleMinimize.Size = UDim2.new(0, 25, 0, 25)
toggleMinimize.Position = UDim2.new(1, -30, 0, 5)
toggleMinimize.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
toggleMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleMinimize.Font = Enum.Font.SourceSansBold
toggleMinimize.ZIndex = 2
toggleMinimize.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "🏃‍♂️ AutoRunner v2.1"
title.Size = UDim2.new(1, -30, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Основні елементи (можуть бути приховані)
local mainContent = Instance.new("Frame")
mainContent.Size = UDim2.new(1, 0, 1, -35)
mainContent.Position = UDim2.new(0, 0, 0, 35)
mainContent.BackgroundTransparency = 1
mainContent.Visible = true
mainContent.Parent = frame

-- Точка A
local inputA = Instance.new("TextBox")
inputA.PlaceholderText = "Точка A (X,Y,Z)"
inputA.Position = UDim2.new(0.05, 0, 0, 5)
inputA.Size = UDim2.new(0.7, 0, 0, 30)
inputA.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
inputA.TextColor3 = Color3.fromRGB(255, 255, 255)
inputA.Text = savedA or ""
inputA.Parent = mainContent

-- Кнопка копіювання A
local copyA = Instance.new("TextButton")
copyA.Text = "📋"
copyA.Position = UDim2.new(0.77, 0, 0, 5)
copyA.Size = UDim2.new(0.18, 0, 0, 30)
copyA.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
copyA.TextColor3 = Color3.fromRGB(255, 255, 255)
copyA.Font = Enum.Font.SourceSansBold
copyA.Parent = mainContent

-- Точка B
local inputB = Instance.new("TextBox")
inputB.PlaceholderText = "Точка B (X,Y,Z)"
inputB.Position = UDim2.new(0.05, 0, 0, 45)
inputB.Size = UDim2.new(0.7, 0, 0, 30)
inputB.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
inputB.TextColor3 = Color3.fromRGB(255, 255, 255)
inputB.Text = savedB or ""
inputB.Parent = mainContent

-- Кнопка копіювання B
local copyB = Instance.new("TextButton")
copyB.Text = "📋"
copyB.Position = UDim2.new(0.77, 0, 0, 45)
copyB.Size = UDim2.new(0.18, 0, 0, 30)
copyB.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
copyB.TextColor3 = Color3.fromRGB(255, 255, 255)
copyB.Font = Enum.Font.SourceSansBold
copyB.Parent = mainContent

-- Кнопка старт/стоп
local toggleButton = Instance.new("TextButton")
toggleButton.Text = "▶️ Старт"
toggleButton.Position = UDim2.new(0.05, 0, 0, 85)
toggleButton.Size = UDim2.new(0.9, 0, 0, 35)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Parent = mainContent

-- Статус
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "Статус: Очікування..."
statusLabel.Position = UDim2.new(0.05, 0, 0, 130)
statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainContent

-- Поточні координати
local coordsDisplay = Instance.new("TextLabel")
coordsDisplay.Text = "Координати: —"
coordsDisplay.Position = UDim2.new(0.05, 0, 0, 155)
coordsDisplay.Size = UDim2.new(0.7, 0, 0, 30)
coordsDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
coordsDisplay.TextColor3 = Color3.fromRGB(0, 255, 0)
coordsDisplay.Font = Enum.Font.Code
coordsDisplay.TextXAlignment = Enum.TextXAlignment.Left
coordsDisplay.Parent = mainContent

-- Кнопка копіювання поточних координат
local copyCurrent = Instance.new("TextButton")
copyCurrent.Text = "📋"
copyCurrent.Position = UDim2.new(0.77, 0, 0, 155)
copyCurrent.Size = UDim2.new(0.18, 0, 0, 30)
copyCurrent.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
copyCurrent.TextColor3 = Color3.fromRGB(255, 255, 255)
copyCurrent.Font = Enum.Font.SourceSansBold
copyCurrent.Parent = mainContent

-- 🔄 Змінні
local running = false
local pointA, pointB = nil, nil
local minimized = false

-- 🔠 Функція парсингу координат
local function parseCoords(text)
    if not text then return nil end
    text = text:gsub("%s+", "")
    local x, y, z = text:match("([%-%d%.]+)[, ]+([%-%d%.]+)[, ]+([%-%d%.]+)")
    if x and y and z then
        return Vector3.new(tonumber(x), tonumber(y), tonumber(z))
    end
    return nil
end

-- 📋 Функція копіювання в буфер обміну
local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        return true
    end
    return false
end

-- 🏃‍♂️ Функція руху
local function moveTo(position)
    local character = game.Players.LocalPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return false end
    
    humanoid:MoveTo(position)
    
    local startTime = os.time()
    while running and (rootPart.Position - position).Magnitude > 3 do
        if os.time() - startTime > 10 then
            return false
        end
        task.wait(0.1)
    end
    
    return true
end

-- 🔄 Основний цикл бігу
local runThread
local function startRunning()
    if runThread then task.cancel(runThread) end
    
    runThread = task.spawn(function()
        while running do
            statusLabel.Text = "Статус: Біг до A..."
            if not moveTo(pointA) then
                statusLabel.Text = "Помилка: Не досягнуто A!"
                running = false
                break
            end
            
            if not running then break end
            task.wait(0.5)
            
            statusLabel.Text = "Статус: Біг до B..."
            if not moveTo(pointB) then
                statusLabel.Text = "Помилка: Не досягнуто B!"
                running = false
                break
            end
            
            if not running then break end
            task.wait(0.5)
        end
        
        toggleButton.Text = "▶️ Старт"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
        statusLabel.Text = "Статус: Зупинено"
    end)
end

-- 🔄 Функція згортання/розгортання
local function toggleMinimizeFunc()
    minimized = not minimized
    if minimized then
        frame.Size = UDim2.new(0, 320, 0, 35)
        toggleMinimize.Text = "＋"
        mainContent.Visible = false
    else
        frame.Size = UDim2.new(0, 320, 0, 280)
        toggleMinimize.Text = "─"
        mainContent.Visible = true
    end
end

-- 🖱️ Обробники кнопок
toggleButton.MouseButton1Click:Connect(function()
    if not running then
        pointA = parseCoords(inputA.Text)
        pointB = parseCoords(inputB.Text)
        
        if pointA and pointB then
            if writefile then
                writefile(saveFile, inputA.Text .. "\n" .. inputB.Text)
            end
            
            running = true
            toggleButton.Text = "⏹️ Стоп"
            toggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            statusLabel.Text = "Статус: Запущено"
            
            startRunning()
        else
            statusLabel.Text = "Помилка: Невірні координати!"
            task.wait(2)
            statusLabel.Text = "Статус: Очікування..."
        end
    else
        running = false
    end
end)

-- Копіювання координат A
copyA.MouseButton1Click:Connect(function()
    if copyToClipboard(inputA.Text) then
        copyA.Text = "✅"
        task.wait(1)
        copyA.Text = "📋"
    else
        copyA.Text = "❌"
        task.wait(1)
        copyA.Text = "📋"
    end
end)

-- Копіювання координат B
copyB.MouseButton1Click:Connect(function()
    if copyToClipboard(inputB.Text) then
        copyB.Text = "✅"
        task.wait(1)
        copyB.Text = "📋"
    else
        copyB.Text = "❌"
        task.wait(1)
        copyB.Text = "📋"
    end
end)

-- Копіювання поточних координат
copyCurrent.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position
        local coords = string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
        if copyToClipboard(coords) then
            copyCurrent.Text = "✅"
            task.wait(1)
            copyCurrent.Text = "📋"
        else
            copyCurrent.Text = "❌"
            task.wait(1)
            copyCurrent.Text = "📋"
        end
    end
end)

-- Кнопка згортання
toggleMinimize.MouseButton1Click:Connect(toggleMinimizeFunc)

-- Гаряча клавіша для відкриття/закриття (Alt+R)
local userInputService = game:GetService("UserInputService")
userInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.R and input:IsModifierKeyDown(Enum.ModifierKey.Alt) then
        toggleMinimizeFunc()
    end
end)

-- 🔄 Оновлення координат гравця
task.spawn(function()
    while true do
        task.wait(0.2)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local pos = character.HumanoidRootPart.Position
            coordsDisplay.Text = string.format("X: %.1f, Y: %.1f, Z: %.1f", pos.X, pos.Y, pos.Z)
        end
    end
end)
    end)

    createCheatButton("✈️Fly", 420, function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)

    createCheatButton("🖱️Auto Click", 480, function()
        loadstring(game:HttpGet("https://pastebin.com/raw/nx1bmCSd"))()
    end)
end

-- Додаємо функції до вкладки Profile
local profileFrame = contentFrames["Profile"]
if profileFrame then
    -- Спочатку створюємо ScrollingFrame
    local scrollFrame = Instance.new("ScrollingFrame", profileFrame)
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
    
    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Стиль для текстових міток
    local function createInfoLabel(text, value)
        local frame = Instance.new("Frame", scrollFrame)
        frame.Size = UDim2.new(0.9, 0, 0, 40)
        frame.Position = UDim2.new(0.05, 0, 0, 0)
        frame.BackgroundTransparency = 1
        
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.4, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.Text = text
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        
        local valueLabel = Instance.new("TextLabel", frame)
        valueLabel.Size = UDim2.new(0.6, 0, 1, 0)
        valueLabel.Position = UDim2.new(0.4, 0, 0, 0)
        valueLabel.Text = value
        valueLabel.TextColor3 = Color3.new(1, 1, 1)
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 18
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.BackgroundTransparency = 1
        
        return valueLabel
    end
    
    -- Інформація про гравця
    local nicknameLabel = createInfoLabel("👤 Нікнейм", player.Name)
    local userIdLabel = createInfoLabel("🆔 UserId", tostring(player.UserId))
    
    -- Час гри
    local playTimeLabel = createInfoLabel("⏱️ Грає", "0 хв 0 сек")
    local joinTime = os.time()
    
    -- Системний час
    local systemTimeLabel = createInfoLabel("🕒 Час на пристрої", os.date("%H:%M:%S"))
    
    -- FPS
    local fpsLabel = createInfoLabel("📈 FPS", "0 FPS")
    
    -- Пінг
    local pingLabel = createInfoLabel("🌐 Пінг", "0 ms")
    
    -- Функція для оновлення FPS
    local function updateFPS()
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        fpsLabel.Text = tostring(fps) .. " FPS"
        
        -- Зміна кольору в залежності від FPS
        if fps >= 60 then
            fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- 🟢
        elseif fps >= 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- 🟡
        else
            fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- 🔴
        end
    end
    
    -- Функція для оновлення пінгу
    local function updatePing()
        local stats = game:GetService("Stats")
        local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        pingLabel.Text = tostring(ping) .. " ms"
    end
    
    -- Функція для оновлення часу гри
    local function updatePlayTime()
        local currentTime = os.time()
        local seconds = currentTime - joinTime
        local minutes = math.floor(seconds / 60)
        seconds = seconds % 60
        playTimeLabel.Text = string.format("%d хв %d сек", minutes, seconds)
    end
    
    -- Функція для оновлення всіх показників
    local function updateAllStats()
        updateFPS()
        updatePing()
        updatePlayTime()
        systemTimeLabel.Text = os.date("%H:%M:%S")
    end
    
    -- Кнопка оновлення
    local refreshBtn = Instance.new("TextButton", scrollFrame)
    refreshBtn.Size = UDim2.new(0.9, 0, 0, 50)
    refreshBtn.Position = UDim2.new(0.05, 0, 0, 300)
    refreshBtn.Text = "🔄 Оновити показники"
    refreshBtn.TextColor3 = Color3.new(1, 1, 1)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.TextSize = 18
    refreshBtn.AutoButtonColor = false
    
    -- Стилізація кнопки
    local btnStroke = Instance.new("UIStroke", refreshBtn)
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 0
    
    local btnGradient = Instance.new("UIGradient", refreshBtn)  
    btnGradient.Color = ColorSequence.new{  
        ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
    }
    btnGradient.Rotation = 90
    
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 12)
    
    -- Обробник кліку для кнопки оновлення
    refreshBtn.MouseButton1Click:Connect(function()
        updateAllStats()
        TweenService:Create(refreshBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
        wait(0.1)
        TweenService:Create(refreshBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end)
    
    -- Автоматичне оновлення показників кожну секунду
    spawn(function()
        while true do
            updateAllStats()
            wait(1)
        end
    end)
    
    -- Початкове оновлення
    updateAllStats()
end

-- Додаємо функції до вкладки Players
local playersFrame = contentFrames["Players"]
if playersFrame then
    -- Спочатку створюємо ScrollingFrame
    local scrollFrame = Instance.new("ScrollingFrame", playersFrame)
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Функція для оновлення списку гравців
    local function updatePlayerList()
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= player then
                local playerBtn = Instance.new("TextButton", scrollFrame)
                playerBtn.Size = UDim2.new(0.9, 0, 0, 50)
                playerBtn.Position = UDim2.new(0.05, 0, 0, 0)
                playerBtn.Text = "🧍‍♂️ " .. plr.Name
                playerBtn.TextColor3 = Color3.new(1, 1, 1)
                playerBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                playerBtn.Font = Enum.Font.GothamBold
                playerBtn.TextSize = 18
                playerBtn.AutoButtonColor = false
                playerBtn.ZIndex = 2
                
                -- Стилізація кнопки
                local btnStroke = Instance.new("UIStroke", playerBtn)
                btnStroke.Color = Color3.fromRGB(255, 255, 255)
                btnStroke.Thickness = 0
                
                local btnGradient = Instance.new("UIGradient", playerBtn)  
                btnGradient.Color = ColorSequence.new{  
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 44, 245)),  
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 80, 230))  
                }
                btnGradient.Rotation = 90
                
                Instance.new("UICorner", playerBtn).CornerRadius = UDim.new(0, 12)
                
                -- Обробник кліку для кнопки гравця
                playerBtn.MouseButton1Click:Connect(function()
                    -- Створюємо меню дій
                    local actionFrame = Instance.new("Frame", playerBtn)
                    actionFrame.Size = UDim2.new(1, 0, 0, 200)
                    actionFrame.Position = UDim2.new(0, 0, 1, 5)
                    actionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    actionFrame.ZIndex = 3
                    
                    Instance.new("UICorner", actionFrame).CornerRadius = UDim.new(0, 12)
                    
                    local actionLayout = Instance.new("UIListLayout", actionFrame)
                    actionLayout.Padding = UDim.new(0, 5)
                    
                    -- Функція для створення кнопок дій
                    local function createActionButton(text, callback)
                        local btn = Instance.new("TextButton", actionFrame)
                        btn.Size = UDim2.new(0.9, 0, 0, 30)
                        btn.Position = UDim2.new(0.05, 0, 0, 0)
                        btn.Text = text
                        btn.TextColor3 = Color3.new(1, 1, 1)
                        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        btn.Font = Enum.Font.Gotham
                        btn.TextSize = 16
                        btn.AutoButtonColor = false
                        btn.ZIndex = 4
                        
                        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
                        
                        btn.MouseButton1Click:Connect(function()
                            callback(plr)
                            actionFrame:Destroy()
                        end)
                        
                        return btn
                    end
                    
                    -- 1. Fake Ban
                    createActionButton("🟥 Fake Ban", function(target)
                        local fakeBanGui = Instance.new("ScreenGui", target.PlayerGui)
                        fakeBanGui.Name = "FakeBanGui"
                        
                        local frame = Instance.new("Frame", fakeBanGui)
                        frame.Size = UDim2.new(0.5, 0, 0.3, 0)
                        frame.Position = UDim2.new(0.25, 0, 0.35, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        
                        local title = Instance.new("TextLabel", frame)
                        title.Text = "BAN NOTIFICATION"
                        title.Size = UDim2.new(1, 0, 0.2, 0)
                        title.TextColor3 = Color3.fromRGB(255, 0, 0)
                        title.Font = Enum.Font.GothamBold
                        title.TextSize = 24
                        
                        local message = Instance.new("TextLabel", frame)
                        message.Text = "You have been banned for exploiting (Error: 267)"
                        message.Size = UDim2.new(1, 0, 0.4, 0)
                        message.Position = UDim2.new(0, 0, 0.3, 0)
                        message.TextColor3 = Color3.fromRGB(255, 255, 255)
                        message.Font = Enum.Font.Gotham
                        message.TextSize = 18
                        
                        -- Автоматичне видалення через 10 секунд
                        game:GetService("Debris"):AddItem(fakeBanGui, 10)
                    end)
                    
                    -- 2. Play Sound
                    createActionButton("🔊 Play Sound", function(target)
                        -- Тут можна додати вибір звуку
                        local soundId = "rbxassetid://9111548331" -- Приклад: Rickroll
                        local sound = Instance.new("Sound", target.Character or target.CharacterAdded:Wait())
                        sound.SoundId = soundId
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 10)
                    end)
                    
                    -- 3. Copy ID
                    createActionButton("📋 Copy ID", function(target)
                        if setclipboard then
                            setclipboard(tostring(target.UserId))
                            game:GetService("StarterGui"):SetCore("SendNotification", {
                                Title = "Copied",
                                Text = "UserID copied to clipboard",
                                Duration = 3
                            })
                        end
                    end)
                    
                    -- 4. Spectate
                    createActionButton("👀 Spectate", function(target)
                        if not workspace.CurrentCamera then return end
                        
                        if workspace.CurrentCamera.CameraSubject == target.Character then
                            -- Повернутися до себе
                            workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                        else
                            -- Спектати гравця
                            if target.Character then
                                workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChildOfClass("Humanoid")
                            else
                                target.CharacterAdded:Connect(function(char)
                                    workspace.CurrentCamera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
                                end)
                            end
                        end
                    end)
                    
                    -- 5. Aimbot
                    createActionButton("🎯 Aimbot", function(target)
                        local aiming = false
                        local aimbotConnection
                        
                        aimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
                            if aiming and target.Character and player.Character then
                                local head = target.Character:FindFirstChild("Head")
                                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                
                                if head and humanoid then
                                    workspace.CurrentCamera.CFrame = CFrame.new(
                                        workspace.CurrentCamera.CFrame.Position,
                                        head.Position
                                    )
                                end
                            end
                        end)
                        
                        aiming = not aiming
                        
                        if not aiming then
                            aimbotConnection:Disconnect()
                        end
                    end)
                    
                    -- 6. Chat Spam
                    createActionButton("💬 Chat Spam", function(target)
                        local messages = {"ez", "lol", "noob", "gg", "get good"}
                        local spamCount = 0
                        
                        local spamLoop = game:GetService("RunService").Heartbeat:Connect(function()
                            if spamCount < 10 then -- Ліміт повідомлень
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    messages[math.random(1, #messages)],
                                    "All"
                                )
                                spamCount = spamCount + 1
                                wait(0.5)
                            else
                                spamLoop:Disconnect()
                            end
                        end)
                    end)
                end)
            end
        end
    end
    
    -- Оновлення списку при зміні гравців
    game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
    game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)
    
    -- Початкове оновлення
    updatePlayerList()
end