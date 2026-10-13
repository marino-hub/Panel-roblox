local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function setupAdminPanel()
    -- Esperar a que el personaje y sus partes clave existan
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
    local humanoid = character:WaitForChild("Humanoid", 10)
    local camera = Workspace.CurrentCamera

    if not humanoidRootPart or not humanoid then return end

    if playerGui:FindFirstChild("MobileAdminGui") then
        playerGui.MobileAdminGui:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileAdminGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    -- Marco Principal del Panel
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 220, 0, 330)
    MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 180, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Text = "PANEL MULTI-JUEGO"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

    -- Botón de Minimizar (-)
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 35, 0, 30)
    MinBtn.Position = UDim2.new(0, 182, 0, 0)
    MinBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.TextSize = 18
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.Parent = MainFrame
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

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
    Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 8)

    -- Barra Superior de Pestañas
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(0, 210, 0, 28)
    TabBar.Position = UDim2.new(0, 5, 0, 34)
    TabBar.BackgroundTransparency = 1
    TabBar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 4)
    TabListLayout.Parent = TabBar

    local function createTabButton(text, order)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 66, 0, 26)
        btn.BackgroundColor3 = order == 1 and Color3.fromRGB(60, 120, 200) or Color3.fromRGB(45, 45, 45)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 9
        btn.Font = Enum.Font.GothamBold
        btn.LayoutOrder = order
        btn.Parent = TabBar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local TabGeneral = createTabButton("GENERAL", 1)
    local TabHuevo = createTabButton("ROBA UN HUEVO", 2)
    local TabMM2 = createTabButton("MM2", 3)

    -- Contenedores con Scroll para las Pestañas
    local function createScrollFrame()
        local sf = Instance.new("ScrollingFrame")
        sf.Size = UDim2.new(0, 210, 0, 225)
        sf.Position = UDim2.new(0, 5, 0, 65)
        sf.BackgroundTransparency = 1
        sf.BorderSizePixel = 0
        sf.CanvasSize = UDim2.new(0, 0, 0, 420)
        sf.ScrollBarThickness = 5
        sf.Visible = false
        sf.Parent = MainFrame
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        layout.Parent = sf
        return sf
    end

    local ScrollGeneral = createScrollFrame()
    local ScrollHuevo = createScrollFrame()
    local ScrollMM2 = createScrollFrame()

    ScrollGeneral.Visible = true

    local function selectTab(activeScroll, activeBtn)
        ScrollGeneral.Visible = (activeScroll == ScrollGeneral)
        ScrollHuevo.Visible = (activeScroll == ScrollHuevo)
        ScrollMM2.Visible = (activeScroll == ScrollMM2)

        TabGeneral.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabHuevo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabMM2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

        activeBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    end

    TabGeneral.MouseButton1Click:Connect(function() selectTab(ScrollGeneral, TabGeneral) end)
    TabHuevo.MouseButton1Click:Connect(function() selectTab(ScrollHuevo, TabHuevo) end)
    TabMM2.MouseButton1Click:Connect(function() selectTab(ScrollMM2, TabMM2) end)

    local function createButton(parent, name, order)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 195, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        btn.Text = name .. ": OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.LayoutOrder = order
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        return btn
    end

    -- ==================== BOTONES GENERAL ====================
    local FlyBtn = createButton(ScrollGeneral, "VUELO", 1)
    local NoclipBtn = createButton(ScrollGeneral, "NOCLIP", 2)
    local LockBtn = createButton(ScrollGeneral, "STRONGLOCK", 3)
    local EspBtn = createButton(ScrollGeneral, "ESP", 4)
    local SpeedBtn = createButton(ScrollGeneral, "VELOCIDAD (80)", 5)
    local FovBtn = createButton(ScrollGeneral, "FOV AMPLIADO", 6)
    local JumpBtn = createButton(ScrollGeneral, "SALTO INFINITO", 7)
    local GodBtn = createButton(ScrollGeneral, "GOD MODE", 8)

    local PlayerListBtn = Instance.new("TextButton")
    PlayerListBtn.Size = UDim2.new(0, 195, 0, 32)
    PlayerListBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 180)
    PlayerListBtn.Text = "LISTA JUGADORES (TP)"
    PlayerListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerListBtn.TextSize = 11
    PlayerListBtn.Font = Enum.Font.GothamBold
    PlayerListBtn.LayoutOrder = 9
    PlayerListBtn.Parent = ScrollGeneral
    Instance.new("UICorner", PlayerListBtn).CornerRadius = UDim.new(0, 8)

    -- ==================== BOTONES ROBA UN HUEVO ====================
    local EggEspBtn = createButton(ScrollHuevo, "ESP HUEVOS", 1)
    local EggSpeedBtn = createButton(ScrollHuevo, "SUPER VELOCIDAD (100)", 2)
    local AutoSafeZoneBtn = createButton(ScrollHuevo, "AUTO-TP ZONA", 3)

    local TpHuevosBtn = Instance.new("TextButton")
    TpHuevosBtn.Size = UDim2.new(0, 195, 0, 32)
    TpHuevosBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 180)
    TpHuevosBtn.Text = "TP AL HUEVO CERCANO"
    TpHuevosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpHuevosBtn.TextSize = 11
    TpHuevosBtn.Font = Enum.Font.GothamBold
    TpHuevosBtn.LayoutOrder = 4
    TpHuevosBtn.Parent = ScrollHuevo
    Instance.new("UICorner", TpHuevosBtn).CornerRadius = UDim.new(0, 8)

    local TpHomeBtn = Instance.new("TextButton")
    TpHomeBtn.Size = UDim2.new(0, 195, 0, 32)
    TpHomeBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 100)
    TpHomeBtn.Text = "TP A ZONA DE INICIO"
    TpHomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpHomeBtn.TextSize = 11
    TpHomeBtn.Font = Enum.Font.GothamBold
    TpHomeBtn.LayoutOrder = 5
    TpHomeBtn.Parent = ScrollHuevo
    Instance.new("UICorner", TpHomeBtn).CornerRadius = UDim.new(0, 8)

    -- ==================== BOTONES MM2 ====================
    local Mm2EspBtn = createButton(ScrollMM2, "ESP ROLES (MM2)", 1)
    
    local TpGunBtn = Instance.new("TextButton")
    TpGunBtn.Size = UDim2.new(0, 195, 0, 32)
    TpGunBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 180)
    TpGunBtn.Text = "AGARRAR PISTOLA TP"
    TpGunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpGunBtn.TextSize = 11
    TpGunBtn.Font = Enum.Font.GothamBold
    TpGunBtn.LayoutOrder = 2
    TpGunBtn.Parent = ScrollMM2
    Instance.new("UICorner", TpGunBtn).CornerRadius = UDim.new(0, 8)

    -- Botones Fijos Abajo (Subir y Bajar para Vuelo)
    local UpBtn = Instance.new("TextButton")
    UpBtn.Size = UDim2.new(0, 98, 0, 28)
    UpBtn.Position = UDim2.new(0, 5, 0, 296)
    UpBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
    UpBtn.Text = "SUBIR"
    UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpBtn.TextSize = 11
    UpBtn.Font = Enum.Font.GothamBold
    UpBtn.Parent = MainFrame
    Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 6)

    local DownBtn = Instance.new("TextButton")
    DownBtn.Size = UDim2.new(0, 98, 0, 28)
    DownBtn.Position = UDim2.new(0, 107, 0, 296)
    DownBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 40)
    DownBtn.Text = "BAJAR"
    DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownBtn.TextSize = 11
    DownBtn.Font = Enum.Font.GothamBold
    DownBtn.Parent = MainFrame
    Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 6)

    -- Ventana Lista de Jugadores
    local ListFrame = Instance.new("Frame")
    ListFrame.Size = UDim2.new(0, 180, 0, 240)
    ListFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
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

    -- Minimizar / Maximizar
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

    -- Lógica Roba un Huevo
    local eggEspActive = false
    local eggHighlights = {}
    local eggSpeedActive = false
    local autoSafeZoneActive = false
    local initialSpawnPosition = humanoidRootPart.CFrame

    EggEspBtn.MouseButton1Click:Connect(function()
        eggEspActive = not eggEspActive
        EggEspBtn.Text = eggEspActive and "ESP HUEVOS: ON" or "ESP HUEVOS: OFF"
        EggEspBtn.BackgroundColor3 = eggEspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)

        if eggEspActive then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
                    if obj:IsA("BasePart") or obj:IsA("Model") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "EggESP"
                        hl.Adornee = obj
                        hl.FillColor = Color3.fromRGB(255, 215, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = obj
                        table.insert(eggHighlights, hl)
                    end
                end
            end
        else
            for _, hl in ipairs(eggHighlights) do
                if hl then hl:Destroy() end
            end
            eggHighlights = {}
        end
    end)

    EggSpeedBtn.MouseButton1Click:Connect(function()
        eggSpeedActive = not eggSpeedActive
        EggSpeedBtn.Text = eggSpeedActive and "VELOCIDAD: 100" or "VELOCIDAD: 16"
        EggSpeedBtn.BackgroundColor3 = eggSpeedActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        humanoid.WalkSpeed = eggSpeedActive and 100 or 16
    end)

    AutoSafeZoneBtn.MouseButton1Click:Connect(function()
        autoSafeZoneActive = not autoSafeZoneActive
        AutoSafeZoneBtn.Text = autoSafeZoneActive and "AUTO-TP ZONA: ON" or "AUTO-TP ZONA: OFF"
        AutoSafeZoneBtn.BackgroundColor3 = autoSafeZoneActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    end)

    TpHomeBtn.MouseButton1Click:Connect(function()
        if humanoidRootPart then
            humanoidRootPart.CFrame = initialSpawnPosition
        end
    end)

    TpHuevosBtn.MouseButton1Click:Connect(function()
        local closestEgg = nil
        local minDist = math.huge
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
                local part = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("BasePart") and obj or nil)
                if part and humanoidRootPart then
                    local dist = (humanoidRootPart.Position - part.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closestEgg = part
                    end
                end
            end
        end
        if closestEgg and humanoidRootPart then
            humanoidRootPart.CFrame = closestEgg.CFrame + Vector3.new(0, 3, 0)
        end
    end)

    -- Detección automática de huevos
    task.spawn(function()
        while character and character.Parent do
            task.wait(0.5)
            if autoSafeZoneActive and humanoidRootPart then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
                        local part = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("BasePart") and obj or nil)
                        if part then
                            local dist = (humanoidRootPart.Position - part.Position).Magnitude
                            if dist < 4 then
                                humanoidRootPart.CFrame = initialSpawnPosition
                                task.wait(1)
                            end
                        end
                    end
                end
            end
        end
    end)

    -- Lógica MM2
    local mm2EspActive = false
    local mm2Highlights = {}

    Mm2EspBtn.MouseButton1Click:Connect(function()
        mm2EspActive = not mm2EspActive
        Mm2EspBtn.Text = mm2EspActive and "ESP ROLES: ON" or "ESP ROLES: OFF"
        Mm2EspBtn.BackgroundColor3 = mm2EspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)

        if mm2EspActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local color = Color3.fromRGB(0, 255, 0)
                    if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                        color = Color3.fromRGB(255, 0, 0)
                    elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                        color = Color3.fromRGB(0, 120, 255)
                    end

                    local hl = Instance.new("Highlight")
                    hl.Name = "MM2ESP"
                    hl.Adornee = p.Character
                    hl.FillColor = color
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                    table.insert(mm2Highlights, hl)
                end
            end
        else
            for _, hl in ipairs(mm2Highlights) do
                if hl then hl:Destroy() end
            end
            mm2Highlights = {}
        end
    end)

    TpGunBtn.MouseButton1Click:Connect(function()
        local gunDrop = Workspace:FindFirstChild("GunDrop", true)
        if gunDrop and humanoidRootPart then
            humanoidRootPart.CFrame = gunDrop.CFrame + Vector3.new(0, 2, 0)
        end
    end)

    -- Estados General
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

player.CharacterAdded:Connect(function()
    task.wait(1)
    setupAdminPanel()
end)

setupAdminPanel()
