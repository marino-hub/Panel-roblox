local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Destruir interfaz previa si existía
if playerGui:FindFirstChild("MobileAdminGui") then
    playerGui.MobileAdminGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileAdminGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Botón Flotante de Apertura (El que solucionó la carga)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 90, 0, 40)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 200)
OpenBtn.Text = "PANEL [ON]"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

-- Marco Principal del Panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 330)
MainFrame.Position = UDim2.new(0.15, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 180, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "PANEL MULTI-JUEGO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- Botón Cerrar (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 30)
CloseBtn.Position = UDim2.new(0, 182, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Pestañas superiores
local function createTab(text, xPos, active)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 66, 0, 26)
    btn.Position = UDim2.new(0, xPos, 0, 35)
    btn.BackgroundColor3 = active and Color3.fromRGB(60, 120, 200) or Color3.fromRGB(45, 45, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 8
    btn.Font = Enum.Font.GothamBold
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local TabGeneral = createTab("GENERAL", 5, true)
local TabHuevo = createTab("HUEVO", 75, false)
local TabMM2 = createTab("MM2", 145, false)

-- Contenedores con ScrollingFrame
local function createContainer(visible)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(0, 210, 0, 225)
    sf.Position = UDim2.new(0, 5, 0, 65)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.CanvasSize = UDim2.new(0, 0, 0, 420)
    sf.ScrollBarThickness = 4
    sf.Visible = visible
    sf.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = sf
    return sf
end

local ScrollGeneral = createContainer(true)
local ScrollHuevo = createContainer(false)
local ScrollMM2 = createContainer(false)

TabGeneral.MouseButton1Click:Connect(function()
    ScrollGeneral.Visible = true; ScrollHuevo.Visible = false; ScrollMM2.Visible = false
    TabGeneral.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    TabHuevo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabMM2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

TabHuevo.MouseButton1Click:Connect(function()
    ScrollGeneral.Visible = false; ScrollHuevo.Visible = true; ScrollMM2.Visible = false
    TabGeneral.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabHuevo.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    TabMM2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

TabMM2.MouseButton1Click:Connect(function()
    ScrollGeneral.Visible = false; ScrollHuevo.Visible = false; ScrollMM2.Visible = true
    TabGeneral.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabHuevo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabMM2.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
end)

local function addButton(parent, name, order, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 195, 0, 32)
    btn.BackgroundColor3 = color or Color3.fromRGB(180, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- ==================== BOTONES SECCIÓN GENERAL ====================
local FlyBtn = addButton(ScrollGeneral, "VUELO: OFF", 1)
local NoclipBtn = addButton(ScrollGeneral, "NOCLIP: OFF", 2)
local LockBtn = addButton(ScrollGeneral, "STRONGLOCK: OFF", 3)
local EspBtn = addButton(ScrollGeneral, "ESP: OFF", 4)
local SpeedBtn = addButton(ScrollGeneral, "VELOCIDAD (80): OFF", 5)
local FovBtn = addButton(ScrollGeneral, "FOV AMPLIADO: OFF", 6)
local JumpBtn = addButton(ScrollGeneral, "SALTO INF: OFF", 7)
local GodBtn = addButton(ScrollGeneral, "GOD MODE: OFF", 8)
local PlayerListBtn = addButton(ScrollGeneral, "LISTA JUGADORES (TP)", 9, Color3.fromRGB(120, 40, 180))

-- ==================== BOTONES SECCIÓN ROBA UN HUEVO ====================
local EggEspBtn = addButton(ScrollHuevo, "ESP HUEVOS: OFF", 1)
local EggSpeedBtn = addButton(ScrollHuevo, "VELOCIDAD (100): OFF", 2)
local AutoSafeBtn = addButton(ScrollHuevo, "AUTO-TP ZONA: OFF", 3)
local TpHuevosBtn = addButton(ScrollHuevo, "TP AL HUEVO CERCANO", 4, Color3.fromRGB(40, 140, 180))
local TpHomeBtn = addButton(ScrollHuevo, "TP A ZONA DE INICIO", 5, Color3.fromRGB(40, 160, 100))

-- ==================== BOTONES SECCIÓN MM2 ====================
local Mm2EspBtn = addButton(ScrollMM2, "ESP ROLES (MM2): OFF", 1)
local TpGunBtn = addButton(ScrollMM2, "AGARRAR PISTOLA TP", 2, Color3.fromRGB(40, 140, 180))

-- Botones Subir y Bajar (Vuelo)
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

-- Ventana Flotante: Lista de Jugadores para Teletransporte
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
                local char = player.Character
                local targetChar = p.Character
                if char and targetChar and char:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
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

-- Variables de Estado
local flying = false
local noclip = false
local stronglock = false
local espActive = false
local highSpeed = false
local wideFov = false
local infJumpActive = false
local godModeActive = false

local eggEspActive = false
local eggHighlights = {}
local eggSpeedActive = false
local autoSafeZoneActive = false

local mm2EspActive = false
local mm2Highlights = {}

local espHighlights = {}
local upState = false
local downState = false
local speed = 35
local initialSpawnPosition = nil

-- Guardar la posición inicial al spawnear
task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    if hrp then
        initialSpawnPosition = hrp.CFrame
    end
end)

player.CharacterAdded:Connect(function(newChar)
    local hrp = newChar:WaitForChild("HumanoidRootPart", 10)
    if hrp then
        initialSpawnPosition = hrp.CFrame
    end
end)

-- Lógica General
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "VUELO: ON" or "VUELO: OFF"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local char = player.Character
    if not flying and char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
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
    SpeedBtn.Text = highSpeed and "VELOCIDAD (80): ON" or "VELOCIDAD (80): OFF"
    SpeedBtn.BackgroundColor3 = highSpeed and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = highSpeed and 80 or 16
    end
end)

FovBtn.MouseButton1Click:Connect(function()
    wideFov = not wideFov
    FovBtn.Text = wideFov and "FOV AMPLIADO: ON" or "FOV AMPLIADO: OFF"
    FovBtn.BackgroundColor3 = wideFov and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    Workspace.CurrentCamera.FieldOfView = wideFov and 110 or 70
end)

JumpBtn.MouseButton1Click:Connect(function()
    infJumpActive = not infJumpActive
    JumpBtn.Text = infJumpActive and "SALTO INF: ON" or "SALTO INF: OFF"
    JumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

UserInputService.JumpRequest:Connect(function()
    local char = player.Character
    if infJumpActive and char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 50, hrp.AssemblyLinearVelocity.Z)
    end
end)

GodBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    GodBtn.Text = godModeActive and "GOD MODE: ON" or "GOD MODE: OFF"
    GodBtn.BackgroundColor3 = godModeActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

-- Lógica Roba un Huevo
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
    EggSpeedBtn.Text = eggSpeedActive and "VELOCIDAD (100): ON" or "VELOCIDAD (100): OFF"
    EggSpeedBtn.BackgroundColor3 = eggSpeedActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = eggSpeedActive and 100 or 16
    end
end)

AutoSafeBtn.MouseButton1Click:Connect(function()
    autoSafeZoneActive = not autoSafeZoneActive
    AutoSafeBtn.Text = autoSafeZoneActive and "AUTO-TP ZONA: ON" or "AUTO-TP ZONA: OFF"
    AutoSafeBtn.BackgroundColor3 = autoSafeZoneActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

TpHomeBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and initialSpawnPosition then
        char.HumanoidRootPart.CFrame = initialSpawnPosition
    end
end)

TpHuevosBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local closestEgg = nil
    local minDist = math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
            local part = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("BasePart") and obj or nil)
            if part then
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closestEgg = part
                end
            end
        end
    end
    if closestEgg then
        hrp.CFrame = closestEgg.CFrame + Vector3.new(0, 3, 0)
    end
end)

-- Detector automático al tocar/agarrar huevos
task.spawn(function()
    while true do
        task.wait(0.5)
        local char = player.Character
        if autoSafeZoneActive and char and char:FindFirstChild("HumanoidRootPart") and initialSpawnPosition then
            local hrp = char.HumanoidRootPart
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
                    local part = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("BasePart") and obj or nil)
                    if part then
                        local dist = (hrp.Position - part.Position).Magnitude
                        if dist < 4 then
                            hrp.CFrame = initialSpawnPosition
                            task.wait(1)
                        end
                    end
                end
            end
        end
    end
end)

-- Lógica MM2
Mm2EspBtn.MouseButton1Click:Connect(function()
    mm2EspActive = not mm2EspActive
    Mm2EspBtn.Text = mm2EspActive and "ESP ROLES (MM2): ON" or "ESP ROLES (MM2): OFF"
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
    local char = player.Character
    local gunDrop = Workspace:FindFirstChild("GunDrop", true)
    if gunDrop and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = gunDrop.CFrame + Vector3.new(0, 2, 0)
    end
end)

UpBtn.MouseButton1Down:Connect(function() upState = true end)
UpBtn.MouseButton1Up:Connect(function() upState = false end)
DownBtn.MouseButton1Down:Connect(function() downState = true end)
DownBtn.MouseButton1Up:Connect(function() downState = false end)

local function getClosestEnemy()
    local closestTarget = nil
    local shortestDistance = math.huge
    local camera = Workspace.CurrentCamera

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChildOfClass("Humanoid") and otherPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
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

-- Bucle de Renderizado Principal
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end

    if flying then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local moveDir = humanoid.MoveDirection
        local verticalVel = 0
        if upState then verticalVel = speed end
        if downState then verticalVel = -speed end

        local horizontalVel = moveDir * speed
        hrp.AssemblyLinearVelocity = Vector3.new(horizontalVel.X, verticalVel, horizontalVel.Z)
        
        if moveDir.Magnitude > 0 then
            local camera = Workspace.CurrentCamera
            local lookVec = camera.CFrame.LookVector
            local flatLook = Vector3.new(lookVec.X, 0, lookVec.Z)
            if flatLook.Magnitude > 0 then
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flatLook.Unit)
            end
        end
    end

    if noclip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    if stronglock then
        local target = getClosestEnemy()
        if target then
            Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, target.Position)
        end
    end

    if godModeActive then
        humanoid.Health = humanoid.MaxHealth
    end
end)
