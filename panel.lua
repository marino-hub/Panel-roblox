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
    PlayersScroll.
