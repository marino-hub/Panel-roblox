local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

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

-- Botón Flotante de Apertura (Estabilidad Móvil)
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

-- Indicador flotante de FPS y Ping
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(0, 110, 0, 24)
StatsLabel.Position = UDim2.new(0.02, 0, 0.35, 0)
StatsLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
StatsLabel.TextSize = 10
StatsLabel.Font = Enum.Font.Code
StatsLabel.Text = "FPS: 60 | PING: 0ms"
StatsLabel.Parent = ScreenGui
Instance.new("UICorner", StatsLabel).CornerRadius = UDim.new(0, 6)

-- Marco Principal del Panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 330)
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
Title.Size = UDim2.new(0, 190, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "PANEL MULTI-JUEGO SUPREMO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 11
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- Botón Cerrar (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 30)
CloseBtn.Position = UDim2.new(0, 192, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Pestañas con Scroll Horizontal
local TabBarScroll = Instance.new("ScrollingFrame")
TabBarScroll.Size = UDim2.new(0, 220, 0, 28)
TabBarScroll.Position = UDim2.new(0, 5, 0, 34)
TabBarScroll.BackgroundTransparency = 1
TabBarScroll.BorderSizePixel = 0
TabBarScroll.CanvasSize = UDim2.new(0, 450, 0, 0)
TabBarScroll.ScrollBarThickness = 2
TabBarScroll.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.Parent = TabBarScroll

local function createTabButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 52, 0, 24)
    btn.BackgroundColor3 = order == 1 and Color3.fromRGB(60, 120, 200) or Color3.fromRGB(45, 45, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 7.5
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.Parent = TabBarScroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local TabGen = createTabButton("GEN", 1)
local TabHuevo = createTabButton("HUEVO", 2)
local TabMM2 = createTabButton("MM2", 3)
local TabRace = createTabButton("RACE", 4)
local TabBlox = createTabButton("BLOX", 5)
local TabPets = createTabButton("PETS", 6)
local TabBall = createTabButton("BALL", 7)
local TabExtra = createTabButton("EXTRA", 8)

-- Contenedores
local function createContainer(visible)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(0, 220, 0, 225)
    sf.Position = UDim2.new(0, 5, 0, 65)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.CanvasSize = UDim2.new(0, 0, 0, 550)
    sf.ScrollBarThickness = 4
    sf.Visible = visible
    sf.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = sf
    return sf
end

local ScrollGen = createContainer(true)
local ScrollHuevo = createContainer(false)
local ScrollMM2 = createContainer(false)
local ScrollRace = createContainer(false)
local ScrollBlox = createContainer(false)
local ScrollPets = createContainer(false)
local ScrollBall = createContainer(false)
local ScrollExtra = createContainer(false)

local allTabs = {
    {TabGen, ScrollGen}, {TabHuevo, ScrollHuevo}, {TabMM2, ScrollMM2},
    {TabRace, ScrollRace}, {TabBlox, ScrollBlox}, {TabPets, ScrollPets},
    {TabBall, ScrollBall}, {TabExtra, ScrollExtra}
}

local function switchTab(selectedScroll, selectedBtn)
    for _, item in ipairs(allTabs) do
        item[2].Visible = (item[2] == selectedScroll)
        item[1].BackgroundColor3 = (item[1] == selectedBtn) and Color3.fromRGB(60, 120, 200) or Color3.fromRGB(45, 45, 45)
    end
end

for _, item in ipairs(allTabs) do
    item[1].MouseButton1Click:Connect(function() switchTab(item[2], item[1]) end)
end

local function addButton(parent, name, order, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 205, 0, 32)
    btn.BackgroundColor3 = color or Color3.fromRGB(180, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- ==================== BOTONES SECCIÓN GENERAL ====================
local FlyBtn = addButton(ScrollGen, "VUELO: OFF", 1)
local NoclipBtn = addButton(ScrollGen, "NOCLIP: OFF", 2)
local LockBtn = addButton(ScrollGen, "STRONGLOCK: OFF", 3)
local EspBtn = addButton(ScrollGen, "ESP: OFF", 4)
local SpeedBtn = addButton(ScrollGen, "VELOCIDAD (80): OFF", 5)
local SuperJumpBtn = addButton(ScrollGen, "SUPER SALTO: OFF", 6)
local FullbrightBtn = addButton(ScrollGen, "VISION NOCTURNA: OFF", 7)
local FovBtn = addButton(ScrollGen, "FOV AMPLIADO: OFF", 8)
local JumpBtn = addButton(ScrollGen, "SALTO INF: OFF", 9)
local GodBtn = addButton(ScrollGen, "GOD MODE: OFF", 10)
local PlayerListBtn = addButton(ScrollGen, "LISTA JUGADORES (TP)", 11, Color3.fromRGB(120, 40, 180))

-- ==================== BOTONES SECCIÓN ROBA UN HUEVO ====================
local EggEspBtn = addButton(ScrollHuevo, "ESP HUEVOS: OFF", 1)
local EggSpeedBtn = addButton(ScrollHuevo, "VELOCIDAD (100): OFF", 2)
local AutoSafeBtn = addButton(ScrollHuevo, "AUTO-TP ZONA: OFF", 3)
local TpHuevosBtn = addButton(ScrollHuevo, "TP AL HUEVO CERCANO", 4, Color3.fromRGB(40, 140, 180))
local TpHomeBtn = addButton(ScrollHuevo, "TP A ZONA DE INICIO", 5, Color3.fromRGB(40, 160, 100))

-- ==================== BOTONES SECCIÓN MM2 ====================
local Mm2EspBtn = addButton(ScrollMM2, "ESP ROLES (MM2): OFF", 1)
local TpGunBtn = addButton(ScrollMM2, "AGARRAR PISTOLA TP", 2, Color3.fromRGB(40, 140, 180))

-- ==================== BOTONES SECCIÓN CARRERAS ====================
local CarSpeedBtn = addButton(ScrollRace, "VELOCIDAD AUTO: OFF", 1)
local CarNoClipBtn = addButton(ScrollRace, "AUTO ANTICHOQUE: OFF", 2)
local FixCarBtn = addButton(ScrollRace, "ENDEREZAR / REPARAR AUTO", 3, Color3.fromRGB(40, 140, 180))

-- ==================== BOTONES SECCIÓN BLOX FRUITS ====================
local BloxChestBtn = addButton(ScrollBlox, "AUTO-FARM COFRES: OFF", 1)
local BloxFruitEspBtn = addButton(ScrollBlox, "ESP FRUTAS: OFF", 2)
local BloxTpFruitBtn = addButton(ScrollBlox, "TP A FRUTA MÁS CERCANA", 3, Color3.fromRGB(40, 140, 180))

-- ==================== BOTONES SECCIÓN PET SIMULATOR ====================
local PetCoinsBtn = addButton(ScrollPets, "AUTO-COLLECT MONEDAS: OFF", 1)
local PetHatchBtn = addButton(ScrollPets, "AUTO-HATCH HUEVOS: OFF", 2)

-- ==================== BOTONES SECCIÓN BLADE BALL ====================
local BallParryBtn = addButton(ScrollBall, "AUTO-PARRY / BLOCK: OFF", 1)
local BallEspBtn = addButton(ScrollBall, "BALL TRACKER ESP: OFF", 2)

-- ==================== BOTONES SECCIÓN EXTRAS ====================
local InvisBtn = addButton(ScrollExtra, "INVISIBILIDAD: OFF", 1)
local GhostBtn = addButton(ScrollExtra, "MODO FANTASMA: OFF", 2)
local AutoClickBtn = addButton(ScrollExtra, "AUTO-CLICKER: OFF", 3)
local AntiAfkBtn = addButton(ScrollExtra, "ANTI-AFK: ON", 4, Color3.fromRGB(40, 180, 90))
local TpHubBtn = addButton(ScrollExtra, "TP AL CENTRO / LOBBY", 5, Color3.fromRGB(40, 140, 180))

-- Botones Subir / Bajar Vuelo
local UpBtn = Instance.new("TextButton")
UpBtn.Size = UDim2.new(0, 102, 0, 28)
UpBtn.Position = UDim2.new(0, 5, 0, 296)
UpBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
UpBtn.Text = "SUBIR"
UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpBtn.TextSize = 11
UpBtn.Font = Enum.Font.GothamBold
UpBtn.Parent = MainFrame
Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 6)

local DownBtn = Instance.new("TextButton")
DownBtn.Size = UDim2.new(0, 102, 0, 28)
DownBtn.Position = UDim2.new(0, 113, 0, 296)
DownBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 40)
DownBtn.Text = "BAJAR"
DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DownBtn.TextSize = 11
DownBtn.Font = Enum.Font.GothamBold
DownBtn.Parent = MainFrame
Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 6)

-- Lista de Jugadores
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
    for _, child in ipairs(PlayersScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
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
CloseListBtn.MouseButton1Click:Connect(function() ListFrame.Visible = false end)

-- Variables de Estado
local flying, noclip, stronglock, espActive, highSpeed, superJumpActive, fullbrightActive, wideFov, infJumpActive, godModeActive = false, false, false, false, false, false, false, false, false, false
local eggEspActive, eggSpeedActive, autoSafeZoneActive = false, false, false
local mm2EspActive = false
local carSpeedActive, carNoClipActive = false, false
local bloxChestActive, bloxFruitEspActive = false, false
local petCoinsActive, petHatchActive = false, false
local ballParryActive, ballEspActive = false, false
local invisActive, ghostActive, autoClickActive, antiAfkActive = false, false, false, true

local eggHighlights, mm2Highlights, espHighlights, fruitHighlights = {}, {}, {}, {}
local upState, downState = false, false
local speed = 35
local initialSpawnPosition = nil

local function safeTeleport(targetCFrame)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        for i = 1, 5 do
            hrp.CFrame = targetCFrame
            task.wait()
        end
    end
end

-- Posición Inicial
task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    if hrp then initialSpawnPosition = hrp.CFrame end
end)

player.CharacterAdded:Connect(function(newChar)
    local hrp = newChar:WaitForChild("HumanoidRootPart", 10)
    if hrp then initialSpawnPosition = hrp.CFrame end
end)

-- Conexiones de Botones General
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "VUELO: ON" or "VUELO: OFF"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
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
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "AdminESP"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                table.insert(espHighlights, hl)
            end
        end
    else
        for _, hl in ipairs(espHighlights) do if hl then hl:Destroy() end end
        espHighlights = {}
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    highSpeed = not highSpeed
    SpeedBtn.Text = highSpeed and "VELOCIDAD (80): ON" or "VELOCIDAD (80): OFF"
    SpeedBtn.BackgroundColor3 = highSpeed and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = highSpeed and 80 or 16 end
end)

SuperJumpBtn.MouseButton1Click:Connect(function()
    superJumpActive = not superJumpActive
    SuperJumpBtn.Text = superJumpActive and "SUPER SALTO: ON" or "SUPER SALTO: OFF"
    SuperJumpBtn.BackgroundColor3 = superJumpActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = superJumpActive and 150 or 50 end
end)

FullbrightBtn.MouseButton1Click:Connect(function()
    fullbrightActive = not fullbrightActive
    FullbrightBtn.Text = fullbrightActive and "VISION NOCTURNA: ON" or "VISION NOCTURNA: OFF"
    FullbrightBtn.BackgroundColor3 = fullbrightActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
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
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if infJumpActive and hrp then
        hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 50, hrp.AssemblyLinearVelocity.Z)
    end
end)

GodBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    GodBtn.Text = godModeActive and "GOD MODE: ON" or "GOD MODE: OFF"
    GodBtn.BackgroundColor3 = godModeActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

-- Conexiones Roba un Huevo
EggEspBtn.MouseButton1Click:Connect(function()
    eggEspActive = not eggEspActive
    EggEspBtn.Text = eggEspActive and "ESP HUEVOS: ON" or "ESP HUEVOS: OFF"
    EggEspBtn.BackgroundColor3 = eggEspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    if eggEspActive then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
                local hl = Instance.new("Highlight", obj)
                hl.FillColor = Color3.fromRGB(255, 215, 0)
                table.insert(eggHighlights, hl)
            end
        end
    else
        for _, hl in ipairs(eggHighlights) do if hl then hl:Destroy() end end
        eggHighlights = {}
    end
end)

EggSpeedBtn.MouseButton1Click:Connect(function()
    eggSpeedActive = not eggSpeedActive
    EggSpeedBtn.Text = eggSpeedActive and "VELOCIDAD (100): ON" or "VELOCIDAD (100): OFF"
    EggSpeedBtn.BackgroundColor3 = eggSpeedActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = eggSpeedActive and 100 or 16 end
end)

AutoSafeBtn.MouseButton1Click:Connect(function()
    autoSafeZoneActive = not autoSafeZoneActive
    AutoSafeBtn.Text = autoSafeZoneActive and "AUTO-TP ZONA: ON" or "AUTO-TP ZONA: OFF"
    AutoSafeBtn.BackgroundColor3 = autoSafeZoneActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

TpHomeBtn.MouseButton1Click:Connect(function() if initialSpawnPosition then safeTeleport(initialSpawnPosition) end end)

TpHuevosBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local closestEgg, minDist = nil, math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("egg") or obj.Name:lower():find("huevo") then
            local part = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("BasePart") and obj or nil)
            if part then
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < minDist then minDist = dist; closestEgg = part end
            end
        end
    end
    if closestEgg then safeTeleport(closestEgg.CFrame + Vector3.new(0, 3, 0)) end
end)

-- Conexiones MM2
Mm2EspBtn.MouseButton1Click:Connect(function()
    mm2EspActive = not mm2EspActive
    Mm2EspBtn.Text = mm2EspActive and "ESP ROLES (MM2): ON" or "ESP ROLES (MM2): OFF"
    Mm2EspBtn.BackgroundColor3 = mm2EspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

TpGunBtn.MouseButton1Click:Connect(function()
    local gunDrop = Workspace:FindFirstChild("GunDrop", true)
    if gunDrop then safeTeleport(gunDrop.CFrame + Vector3.new(0, 2, 0)) end
end)

-- Conexiones Carreras
CarSpeedBtn.MouseButton1Click:Connect(function()
    carSpeedActive = not carSpeedActive
    CarSpeedBtn.Text = carSpeedActive and "VELOCIDAD AUTO: ON" or "VELOCIDAD AUTO: OFF"
    CarSpeedBtn.BackgroundColor3 = carSpeedActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

CarNoClipBtn.MouseButton1Click:Connect(function()
    carNoClipActive = not carNoClipActive
    CarNoClipBtn.Text = carNoClipActive and "AUTO ANTICHOQUE: ON" or "AUTO ANTICHOQUE: OFF"
    CarNoClipBtn.BackgroundColor3 = carNoClipActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

FixCarBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0); hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0) end
end)

-- Conexiones Blox Fruits
BloxChestBtn.MouseButton1Click:Connect(function()
    bloxChestActive = not bloxChestActive
    BloxChestBtn.Text = bloxChestActive and "AUTO-FARM COFRES: ON" or "AUTO-FARM COFRES: OFF"
    BloxChestBtn.BackgroundColor3 = bloxChestActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if bloxChestActive then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("chest") and (obj:IsA("BasePart") or obj:IsA("Model")) then
                    local part = obj:IsA("Model") and obj.PrimaryPart or obj
                    if part then safeTeleport(part.CFrame + Vector3.new(0, 2, 0)); task.wait(0.8) end
                end
            end
        end
    end
end)

BloxFruitEspBtn.MouseButton1Click:Connect(function()
    bloxFruitEspActive = not bloxFruitEspActive
    BloxFruitEspBtn.Text = bloxFruitEspActive and "ESP FRUTAS: ON" or "ESP FRUTAS: OFF"
    BloxFruitEspBtn.BackgroundColor3 = bloxFruitEspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

BloxTpFruitBtn.MouseButton1Click:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("fruit") and obj:IsA("BasePart") then
            safeTeleport(obj.CFrame + Vector3.new(0, 3, 0))
            break
        end
    end
end)

-- Conexiones Pet Simulator
PetCoinsBtn.MouseButton1Click:Connect(function()
    petCoinsActive = not petCoinsActive
    PetCoinsBtn.Text = petCoinsActive and "AUTO-COLLECT MONEDAS: ON" or "AUTO-COLLECT MONEDAS: OFF"
    PetCoinsBtn.BackgroundColor3 = petCoinsActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

PetHatchBtn.MouseButton1Click:Connect(function()
    petHatchActive = not petHatchActive
    PetHatchBtn.Text = petHatchActive and "AUTO-HATCH HUEVOS: ON" or "AUTO-HATCH HUEVOS: OFF"
    PetHatchBtn.BackgroundColor3 = petHatchActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

-- Conexiones Blade Ball
BallParryBtn.MouseButton1Click:Connect(function()
    ballParryActive = not ballParryActive
    BallParryBtn.Text = ballParryActive and "AUTO-PARRY: ON" or "AUTO-PARRY: OFF"
    BallParryBtn.BackgroundColor3 = ballParryActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

BallEspBtn.MouseButton1Click:Connect(function()
    ballEspActive = not ballEspActive
    BallEspBtn.Text = ballEspActive and "BALL TRACKER ESP: ON" or "BALL TRACKER ESP: OFF"
    BallEspBtn.BackgroundColor3 = ballEspActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

-- Conexiones Extras
InvisBtn.MouseButton1Click:Connect(function()
    invisActive = not invisActive
    InvisBtn.Text = invisActive and "INVISIBILIDAD: ON" or "INVISIBILIDAD: OFF"
    InvisBtn.BackgroundColor3 = invisActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = invisActive and 1 or 0 end
        end
    end
end)

GhostBtn.MouseButton1Click:Connect(function()
    ghostActive = not ghostActive
    GhostBtn.Text = ghostActive and "MODO FANTASMA: ON" or "MODO FANTASMA: OFF"
    GhostBtn.BackgroundColor3 = ghostActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.Transparency = ghostActive and 0.6 or 0 end
        end
    end
end)

AutoClickBtn.MouseButton1Click:Connect(function()
    autoClickActive = not autoClickActive
    AutoClickBtn.Text = autoClickActive and "AUTO-CLICKER: ON" or "AUTO-CLICKER: OFF"
    AutoClickBtn.BackgroundColor3 = autoClickActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if autoClickActive then pcall(function() mouse1click() end) end
    end
end)

AntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkActive = not antiAfkActive
    AntiAfkBtn.Text = antiAfkActive and "ANTI-AFK: ON" or "ANTI-AFK: OFF"
    AntiAfkBtn.BackgroundColor3 = antiAfkActive and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
end)

task.spawn(function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        if antiAfkActive then
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end
    end)
end)

TpHubBtn.MouseButton1Click:Connect(function() safeTeleport(CFrame.new(0, 10, 0)) end)

UpBtn.MouseButton1Down:Connect(function() upState = true end)
UpBtn.MouseButton1Up:Connect(function() upState = false end)
DownBtn.MouseButton1Down:Connect(function() downState = true end)
DownBtn.MouseButton1Up:Connect(function() downState = false end)

-- Bucle de Renderizado Principal
local frameCount, lastTick = 0, tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTick = tick()
    if currentTick - lastTick >= 1 then
        local fps = math.floor(frameCount / (currentTick - lastTick))
        local ping = math.floor(player:GetNetworkPing() * 1000)
        StatsLabel.Text = "FPS: " .. fps .. " | PING: " .. ping .. "ms"
        frameCount, lastTick = 0, currentTick
    end

    if fullbrightActive then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
    end

    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end

    -- Lógica Vehicular
    local seat = humanoid.SeatPart
    if seat and seat:IsA("VehicleSeat") then
        if carSpeedActive then seat.MaxSpeed = 500; seat.Torque = 10000 end
        if carNoClipActive then
            local vehicleModel = seat.Parent
            if vehicleModel and vehicleModel:IsA("Model") then
                for _, p in ipairs(vehicleModel:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end
    end

    -- Lógica Vuelo
    if flying then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local moveDir = humanoid.MoveDirection
        local verticalVel = 0
        if upState then verticalVel = speed end
        if downState then verticalVel = -speed end
        local horizontalVel = moveDir * speed
        hrp.AssemblyLinearVelocity = Vector3.new(horizontalVel.X, verticalVel, horizontalVel.Z)
        
        if moveDir.Magnitude > 0 then
            local lookVec = Workspace.CurrentCamera.CFrame.LookVector
            local flatLook = Vector3.new(lookVec.X, 0, lookVec.Z)
            if flatLook.Magnitude > 0 then
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flatLook.Unit)
            end
        end
    end

    -- Noclip
    if noclip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- God Mode
    if godModeActive then humanoid.Health = humanoid.MaxHealth end
end)
