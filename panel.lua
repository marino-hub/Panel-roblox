local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local function setupAdminPanel(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local camera = Workspace.CurrentCamera

    if player.PlayerGui:FindFirstChild("MobileAdminGui") then
        player.PlayerGui.MobileAdminGui:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileAdminGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Marco Principal del Panel
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 210, 0, 320)
    MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 170, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Text = "PANEL RIVALS MÓVIL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    -- Botón de Minimizar (-)
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 35, 0, 30)
    MinBtn.Position = UDim2.new(0, 172, 0, 0)
    MinBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.TextSize = 18
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.Parent = MainFrame

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 8)
    MinCorner.Parent = MinBtn

    -- Mini Ventana flotante (Maximizar)
    local MiniFrame = Instance.new("TextButton")
    MiniFrame.Size = UDim2.new(0, 110, 0, 35)
    MiniFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
    MiniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniFrame.Text = "[ + ] PANEL"
    MiniFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiniFrame.TextSize = 12
    MiniFrame.Font = Enum.Font.GothamBold
    MiniFrame.Visible = false
    MiniFrame.Active = true
    MiniFrame.Draggable = true
    MiniFrame.Parent = ScreenGui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 8)
    MiniCorner.Parent = MiniFrame

    -- ScrollingFrame para deslizar arriba y abajo
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(0, 195, 0, 225)
    ScrollingFrame.Position = UDim2.new(0, 5, 0, 35)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 380) -- Altura expandida para que quepan todos los botones con scroll
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = ScrollingFrame

    local function createButton(name, order)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 178, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        btn.Text = name .. ": OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.LayoutOrder = order
        btn.Parent = ScrollingFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        return btn
    end

    -- Botones del panel organizados
    local FlyBtn = createButton("VUELO", 1)
    local NoclipBtn = createButton("NOCLIP", 2)
    local LockBtn = createButton("STRONGLOCK", 3)
    local EspBtn = createButton("ESP", 4)
    local SpeedBtn = createButton("VELOCIDAD (80)", 5)
    local FovBtn = createButton("FOV AMPLIADO", 6)
    local JumpBtn = createButton("SALTO INFINITO", 7)
    local GodBtn = createButton("GOD MODE", 8)

    -- Botones de Accion Directa (TP a Base y Lista de Jugadores)
    local TpBtn = Instance.new("TextButton")
    TpBtn.Size = UDim2.new(0, 178, 0, 32)
    TpBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 180)
    TpBtn.Text = "TP A BASE"
    TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpBtn.TextSize = 12
    TpBtn.Font = Enum.Font.GothamBold
    TpBtn.LayoutOrder = 9
    TpBtn.Parent = ScrollingFrame
    Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 8)

    local PlayerListBtn = Instance.new("TextButton")
    PlayerListBtn.Size = UDim2.new(0, 178, 0, 32)
    PlayerListBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 180)
    PlayerListBtn.Text = "LISTA JUGADORES (TP)"
    PlayerListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerListBtn.TextSize = 11
    PlayerListBtn.Font = Enum.Font.GothamBold
    PlayerListBtn.LayoutOrder = 10
    PlayerListBtn.Parent = ScrollingFrame
    Instance.new("UICorner", PlayerListBtn).CornerRadius = UDim.new(0, 8)

    -- Botones Fijos Abajo (Subir y Bajar para el vuelo)
    local UpBtn = Instance.new("TextButton")
    UpBtn.Size = UDim2.new(0, 92, 0, 28)
    UpBtn.Position = UDim2.new(0, 5, 0, 268)
    UpBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
    UpBtn.Text = "SUBIR"
    UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpBtn.TextSize = 11
    UpBtn.Font = Enum.Font.GothamBold
    UpBtn.Parent = MainFrame
    Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 6)

    local DownBtn = Instance.new("TextButton")
    DownBtn.Size = UDim2.new(0, 92, 0, 28)
    DownBtn.Position = UDim2.new(0, 103, 0, 268)
    DownBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 40)
    DownBtn.Text = "BAJAR"
    DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownBtn.TextSize = 11
    DownBtn.Font = Enum.Font.GothamBold
    DownBtn.Parent = MainFrame
    Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 6)

    -- Ventana Desplegable para la Lista de Jugadores Interactiva
    local ListFrame = Instance.new("Frame")
    ListFrame.Size = UDim2.new(0, 180, 0, 240)
    ListFrame.Position = UDim2.new(0.28, 0, 0.25, 0)
    ListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ListFrame.Visible = false
    ListFrame.Active = true
    ListFrame.Draggable = true
    ListFrame.Parent = ScreenGui
    Instance.new("UICorner", ListFrame).CornerRadius = UDim.new(0, 10)

    local ListTitle = Instance.new("TextLabel")
    ListTitle.Size = UDim2.new(0, 145, 0, 30)
    ListTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    ListTitle.Text = "TELETRANSPORTE"
    ListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ListTitle.TextSize = 11
    ListTitle.Font = Enum.Font.GothamBold
    ListTitle.Parent = ListFrame
    Instance.new("UICorner", ListTitle).CornerRadius = UDim.new(0, 10)

    local CloseListBtn = Instance.new("TextButton")
    CloseListBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseListBtn.Position = UDim2.new(0, 150, 0, 0)
    CloseListBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    CloseListBtn.Text = "X"
    CloseListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseListBtn.TextSize = 14
    CloseListBtn.Font = Enum.Font.GothamBold
    CloseListBtn.Parent = ListFrame
    Instance.new("UICorner", CloseListBtn).CornerRadius = UDim.new(0, 8)

    local PlayersScroll = Instance.new("ScrollingFrame")
    PlayersScroll.Size = UDim2.new(0, 170, 0, 195)
    PlayersScroll.Position = UDim2.new(0, 5, 0, 35)
    PlayersScroll.BackgroundTransparency = 1
    PlayersScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    PlayersScroll.ScrollBarThickness = 4
    PlayersScroll.Parent = ListFrame

    local PlayersLayout = Instance.new("UIListLayout")
    PlayersLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PlayersLayout.Padding = UDim.new(0, 4)
    PlayersLayout.Parent = PlayersScroll

    local function refreshPlayerList()
        for _, child in ipairs(PlayersScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then
                count = count + 1
                local pBtn = Instance.new("TextButton")
                pBtn.Size = UDim2.new(0, 160, 0, 28)
                pBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                pBtn.Text = p.Name
                pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                pBtn.TextSize = 11
                pBtn.Font = Enum.Font.Gotham
                pBtn.LayoutOrder = count
                pBtn.Parent = PlayersScroll
                Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)

                pBtn.MouseButton1Click:Connect(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        humanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end)
            end
        end
        PlayersScroll.CanvasSize = UDim2.new(0, 0, 0, count * 32)
    end

    PlayerListBtn.MouseButton1Click:Connect(function()
        refreshPlayerList()
        ListFrame.Visible = not ListFrame.Visible
    end)

    CloseListBtn.MouseButton1Click:Connect(function()
        ListFrame.Visible = false
    end)

    -- Lógica Minimizar / Maximizar
    MinBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        ListFrame.Visible = false
        MiniFrame.Position = MainFrame.Position
        MiniFrame.Visible = true
    end)

    MiniFrame.MouseButton1Click:Connect(function()
        MiniFrame.Visible = false
        MainFrame.Visible = true
    end)

    -- Estados de las funciones
    local flying = false
    local noclip = false
    local stronglock = false
    local espActive = false
    local highSpeed = false
    local wideFov = false
    local infJumpActive = false
    local godModeActive = false
    
    local speed = 35
    local upState = false
    local downState = false
    local espHighlights = {}

    -- Conexiones de Botones Principales
    FlyBtn.MouseButton1Click:Connect(function()
        flying = not flying
        FlyBtn.Text = flying and "VUELO: ON" or "VUELO: OFF"
        FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        if not flying and humanoidRootPart and humanoid then
            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)

    NoclipBtn.MouseButton1Click:Connect(function()
        noclip = not noclip
        NoclipBtn.Text = noclip and "NOCLIP: ON" or "NOCLIP: OFF"
        NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    end)

    LockBtn.MouseButton1Click:Connect(function()
        stronglock = not stronglock
        LockBtn.Text = stronglock and "STRONGLOCK: ON" or "STRONGLOCK: OFF"
        LockBtn.BackgroundColor3 = stronglock and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    end)

    EspBtn.MouseButton1Click:Connect(function()
        espActive = not espActive
        EspBtn.Text = espActive and "ESP: ON" or "ESP: OFF"
        EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)

        if espActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hl = Instance.new("Highlight")
                    hl.Name = "AdminESP"
                    hl.Adornee = p.Character
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                    table.insert(espHighlights, hl)
                end
            end
        else
            for _, hl in ipairs(espHighlights) do
                if hl then hl:Destroy() end
            end
            espHighlights = {}
        end
    end)

    SpeedBtn.MouseButton1Click:Connect(function()
        highSpeed = not highSpeed
        SpeedBtn.Text = highSpeed and "VELOCIDAD: 80" or "VELOCIDAD: 16"
        SpeedBtn.BackgroundColor3 = highSpeed and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        humanoid.WalkSpeed = highSpeed and 80 or 16
    end)

    FovBtn.MouseButton1Click:Connect(function()
        wideFov = not wideFov
        FovBtn.Text = wideFov and "FOV: 110" or "FOV: 70"
        FovBtn.BackgroundColor3 = wideFov and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        camera.FieldOfView = wideFov and 110 or 70
    end)

    JumpBtn.MouseButton1Click:Connect(function()
        infJumpActive = not infJumpActive
        JumpBtn.Text = infJumpActive and "SALTO INF: ON" or "SALTO INF: OFF"
        JumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    end)

    -- Soporte para mantener presionado el botón de salto del dispositivo
    UserInputService.JumpRequest:Connect(function()
        if infJumpActive and humanoidRootPart then
            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(humanoidRootPart.AssemblyLinearVelocity.X, 50, humanoidRootPart.AssemblyLinearVelocity.Z)
        end
    end)

    GodBtn.MouseButton1Click:Connect(function()
        godModeActive = not godModeActive
        GodBtn.Text = godModeActive and "GOD MODE: ON" or "GOD MODE: OFF"
        GodBtn.BackgroundColor3 = godModeActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    end)

    TpBtn.MouseButton1Click:Connect(function()
        humanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end)

    UpBtn.MouseButton1Down:Connect(function() upState = true end)
    UpBtn.MouseButton1Up:Connect(function() upState = false end)
    DownBtn.MouseButton1Down:Connect(function() downState = true end)
    DownBtn.MouseButton1Up:Connect(function() downState = false end)

    local function getClosestEnemy()
        local closestTarget = nil
        local shortestDistance = math.huge

        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Humanoid") and otherPlayer.Character.Humanoid.Health > 0 then
                local targetPart = otherPlayer.Character:FindFirstChild("Head")
                if targetPart then
                    local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local mousePos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestTarget = targetPart
                        end
                    end
                end
            end
        end
        return closestTarget
    end

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not character.Parent or not humanoidRootPart or not humanoidRootPart.Parent or humanoid.Health <= 0 then
            if ScreenGui then ScreenGui:Destroy() end
            if connection then connection:Disconnect() end
            return
        end

        if flying then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            local moveDir = humanoid.MoveDirection
            local verticalVel = 0
            if upState then verticalVel = speed end
            if downState then verticalVel = -speed end

            local horizontalVel = moveDir * speed
            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(horizontalVel.X, verticalVel, horizontalVel.Z)
            
            if moveDir.Magnitude > 0 then
                local lookVec = camera.CFrame.LookVector
                local flatLook = Vector3.new(lookVec.X, 0, lookVec.Z)
                if flatLook.Magnitude > 0 then
                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + flatLook.Unit)
                end
            end
        end

        if noclip then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        if stronglock then
            local target = getClosestEnemy()
            if target then
                camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
            end
        end

        if godModeActive then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

player.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    setupAdminPanel(newCharacter)
end)

if player.Character then
    setupAdminPanel(player.Character)
end
