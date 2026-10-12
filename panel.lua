local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function setupAdminPanel(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    -- Limpiar interfaz anterior si ya existía
    if player.PlayerGui:FindFirstChild("MobileAdminGui") then
        player.PlayerGui.MobileAdminGui:Destroy()
    end

    -- Crear interfaz gráfica flotante (Panel Admin)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileAdminGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 200, 0, 220)
    MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Text = "PANEL ADMIN MÓVIL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    -- Función auxiliar para crear botones del panel
    local function createButton(name, posY, defaultText)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 180, 0, 35)
        btn.Position = UDim2.new(0, 10, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        btn.Text = name .. ": OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.Parent = MainFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        return btn
    end

    local FlyBtn = createButton("VUELO", 40)
    local NoclipBtn = createButton("NOCLIP", 80)
    local EspBtn = createButton("ESP", 120)
    local SpeedBtn = createButton("VELOCIDAD (50)", 160)

    -- Variables de estado
    local flying = false
    local noclip = false
    local espActive = false
    local highSpeed = false
    
    local speed = 35
    local upState = false -- Nota: puedes mantener botones de subir/bajar si gustas, o volar con la cámara. Aquí añadiremos un par de botones extra abajo si lo deseas, o usaremos la cámara.

    -- Botones de Subir/Bajar flotantes pequeños adicionales para el vuelo
    local UpBtn = Instance.new("TextButton")
    UpBtn.Size = UDim2.new(0, 85, 0, 25)
    UpBtn.Position = UDim2.new(0, 10, 0, 200)
    UpBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
    UpBtn.Text = "SUBIR"
    UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpBtn.TextSize = 11
    UpBtn.Font = Enum.Font.GothamBold
    UpBtn.Parent = MainFrame
    Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 6)

    local DownBtn = Instance.new("TextButton")
    DownBtn.Size = UDim2.new(0, 85, 0, 25)
    DownBtn.Position = UDim2.new(0, 105, 0, 200)
    DownBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 40)
    DownBtn.Text = "BAJAR"
    DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownBtn.TextSize = 11
    DownBtn.Font = Enum.Font.GothamBold
    DownBtn.Parent = MainFrame
    Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 6)

    -- Agrandar un poco el marco principal para que quepan bien los botones de subir/bajar
    MainFrame.Size = UDim2.new(0, 200, 0, 235)

    -- Control de Estados mediante Botones
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

    -- ESP (Destacar jugadores con un Highlight local)
    local espHighlights = {}
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
        SpeedBtn.Text = highSpeed and "VELOCIDAD: 80" or "VELOCIDAD: 50"
        SpeedBtn.BackgroundColor3 = highSpeed and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        humanoid.WalkSpeed = highSpeed and 80 or 16
    end)

    UpBtn.MouseButton1Down:Connect(function() upState = true end)
    UpBtn.MouseButton1Up:Connect(function() upState = false end)
    DownBtn.MouseButton1Down:Connect(function() downState = true end)
    DownBtn.MouseButton1Up:Connect(function() downState = false end)

    -- Bucle Principal del Servidor/Cliente
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not character.Parent or not humanoidRootPart or not humanoidRootPart.Parent or humanoid.Health <= 0 then
            if ScreenGui then ScreenGui:Destroy() end
            if connection then connection:Disconnect() end
            return
        end

        -- Lógica de Vuelo
        if flying then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            local camera = workspace.CurrentCamera
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

        -- Lógica de Noclip (Atravesar paredes)
        if noclip then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Autorrecarga al reiniciar o reaparecer
player.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    setupAdminPanel(newCharacter)
end)

if player.Character then
    setupAdminPanel(player.Character)
end
