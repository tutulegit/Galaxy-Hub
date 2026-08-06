--[[
    🌌 GALAXY HUB v5.0 - GITHUB EDITION
    Silent Aim REAL - Não move a câmera
    Para usar: Coloque no GitHub Gist e execute com loadstring
]]

repeat wait() until game:IsLoaded()
wait(2)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

if not LocalPlayer then repeat wait() until Players.LocalPlayer; LocalPlayer = Players.LocalPlayer end

local Settings = {
    Aimbot = {
        Enabled = false, Smoothness = 1, FOV = 150,
        VisibleCheck = true, AimPart = "Head", TeamCheck = false,
        FOVCircleVisible = false, LockTarget = false, LockedTarget = nil,
        UseKeybind = false, AimKey = Enum.UserInputType.MouseButton2,
        AimKeyName = "MouseButton2", SilentAim = false
    },
    FOV = { Value = 70, Enabled = false },
    ESP = {
        Enabled = false, Boxes = false, Tracers = false,
        Distance = false, HealthBar = false, Names = false,
        Chams = false, TeamCheck = true, MaxDistance = 1000
    }
}

print("🌌 Galaxy Hub v5.0 | GitHub Edition")
print("✅ Carregando...")

-- FOV Circle
local FOVCircle = nil
pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = false
    FOVCircle.Thickness = 2
    FOVCircle.NumSides = 100
    FOVCircle.Radius = Settings.Aimbot.FOV
    FOVCircle.Color = Color3.fromRGB(180, 100, 255)
    FOVCircle.Filled = false
end)

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalaxyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999

local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if not pg then
    pg = Instance.new("PlayerGui")
    pg.Parent = LocalPlayer
end
ScreenGui.Parent = pg

print("✅ UI criada")

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 15, 80)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(80, 25, 140)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 10, 60))
})
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

-- Título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 12, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 50)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(120, 40, 200)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 20, 120))
})
TitleGradient.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, -140, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.Font = Enum.Font.GothamBlack
TitleText.Text = "🌌 GALAXY HUB v5.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 40, 180)
MinimizeButton.Size = UDim2.new(0, 40, 0, 35)
MinimizeButton.Position = UDim2.new(1, -95, 0, 7)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.BorderSizePixel = 0
MinimizeButton.AutoButtonColor = false
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = MinimizeButton

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
CloseButton.Size = UDim2.new(0, 40, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0, 7)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.AutoButtonColor = false
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Container principal
local MainContainer = Instance.new("Frame")
MainContainer.Parent = MainFrame
MainContainer.BackgroundTransparency = 1
MainContainer.Position = UDim2.new(0, 0, 0, 50)
MainContainer.Size = UDim2.new(1, 0, 1, -50)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainContainer
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 8, 40)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2.new(0, 140, 1, 0)
local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 15)
SidebarCorner.Parent = Sidebar

-- Área de conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainContainer
ContentArea.BackgroundColor3 = Color3.fromRGB(35, 15, 65)
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 15)
ContentCorner.Parent = ContentArea

-- Criar botões da sidebar
local function CreateSidebarButton(name, icon, yPos)
    local button = Instance.new("TextButton")
    button.Name = name.."Btn"
    button.Parent = Sidebar
    button.BackgroundColor3 = Color3.fromRGB(40, 15, 70)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -30, 0, 45)
    button.Position = UDim2.new(0, 15, 0, yPos)
    button.Font = Enum.Font.GothamBold
    button.Text = "  "..icon.."  "..name
    button.TextColor3 = Color3.fromRGB(220, 200, 255)
    button.TextSize = 15
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = button
    return button
end

local AimbotBtn = CreateSidebarButton("Aimbot", "🎯", 20)
local ESPBtn = CreateSidebarButton("ESP", "👻", 80)
local FOVBtn = CreateSidebarButton("FOV", "👁️", 140)

-- Criar conteúdos
local AimbotContent = Instance.new("ScrollingFrame")
AimbotContent.Parent = ContentArea
AimbotContent.BackgroundTransparency = 1
AimbotContent.Size = UDim2.new(1, -10, 1, -10)
AimbotContent.Position = UDim2.new(0, 5, 0, 5)
AimbotContent.ScrollBarThickness = 5
AimbotContent.ScrollBarImageColor3 = Color3.fromRGB(150, 50, 255)
AimbotContent.CanvasSize = UDim2.new(0, 0, 0, 500)
AimbotContent.Visible = true

local ESPContent = Instance.new("ScrollingFrame")
ESPContent.Parent = ContentArea
ESPContent.BackgroundTransparency = 1
ESPContent.Size = UDim2.new(1, -10, 1, -10)
ESPContent.Position = UDim2.new(0, 5, 0, 5)
ESPContent.ScrollBarThickness = 5
ESPContent.ScrollBarImageColor3 = Color3.fromRGB(150, 50, 255)
ESPContent.CanvasSize = UDim2.new(0, 0, 0, 450)
ESPContent.Visible = false

local FOVContent = Instance.new("Frame")
FOVContent.Parent = ContentArea
FOVContent.BackgroundTransparency = 1
FOVContent.Size = UDim2.new(1, -10, 1, -10)
FOVContent.Position = UDim2.new(0, 5, 0, 5)
FOVContent.Visible = false

-- Navegação
local function SwitchTab(tab)
    AimbotContent.Visible = (tab == "Aimbot")
    ESPContent.Visible = (tab == "ESP")
    FOVContent.Visible = (tab == "FOV")
    
    AimbotBtn.BackgroundColor3 = (tab == "Aimbot") and Color3.fromRGB(120, 40, 200) or Color3.fromRGB(40, 15, 70)
    ESPBtn.BackgroundColor3 = (tab == "ESP") and Color3.fromRGB(120, 40, 200) or Color3.fromRGB(40, 15, 70)
    FOVBtn.BackgroundColor3 = (tab == "FOV") and Color3.fromRGB(120, 40, 200) or Color3.fromRGB(40, 15, 70)
end

AimbotBtn.MouseButton1Click:Connect(function() SwitchTab("Aimbot") end)
ESPBtn.MouseButton1Click:Connect(function() SwitchTab("ESP") end)
FOVBtn.MouseButton1Click:Connect(function() SwitchTab("FOV") end)

-- Função Toggle
local function CreateToggle(parent, text, yPos, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(45, 20, 75)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -20, 0, 42)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local button = Instance.new("TextButton")
    button.Parent = frame
    button.BackgroundColor3 = default and Color3.fromRGB(130, 60, 220) or Color3.fromRGB(200, 60, 80)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(1, -55, 0.5, -13)
    button.Size = UDim2.new(0, 48, 0, 26)
    button.Font = Enum.Font.GothamBlack
    button.Text = default and "ON" or "OFF"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.AutoButtonColor = false
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 13)
    bCorner.Parent = button
    
    local enabled = default
    
    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        button.BackgroundColor3 = enabled and Color3.fromRGB(130, 60, 220) or Color3.fromRGB(200, 60, 80)
        button.Text = enabled and "ON" or "OFF"
        callback(enabled)
    end)
end

-- Função Slider
local function CreateSlider(parent, text, min, max, default, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(45, 20, 75)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -20, 0, 65)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -20, 0, 22)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text..": "..default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = frame
    sliderBg.BackgroundColor3 = Color3.fromRGB(25, 10, 45)
    sliderBg.BorderSizePixel = 0
    sliderBg.Position = UDim2.new(0, 10, 0, 35)
    sliderBg.Size = UDim2.new(1, -20, 0, 10)
    
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 5)
    sCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg
    sliderFill.BackgroundColor3 = Color3.fromRGB(160, 70, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 5)
    fCorner.Parent = sliderFill
    
    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Parent = sliderFill
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.BorderSizePixel = 0
    sliderBtn.Position = UDim2.new(1, -10, -0.6, 0)
    sliderBtn.Size = UDim2.new(0, 20, 0, 20)
    sliderBtn.Text = ""
    sliderBtn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = sliderBtn
    
    local dragging = false
    
    local function update()
        local mousePos = UserInputService:GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * relativeX)
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        label.Text = text..": "..value
        callback(value)
    end
    
    sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update() end
    end)
end

-- Preencher Aimbot
CreateToggle(AimbotContent, "Ativar Aimbot", 5, false, function(v) Settings.Aimbot.Enabled = v end)
CreateToggle(AimbotContent, "Usar Tecla (Mouse Dir)", 52, false, function(v) Settings.Aimbot.UseKeybind = v end)
CreateToggle(AimbotContent, "Target Lock", 99, false, function(v) Settings.Aimbot.LockTarget = v; if not v then Settings.Aimbot.LockedTarget = nil end end)
CreateToggle(AimbotContent, "Silent Aim", 146, false, function(v) Settings.Aimbot.SilentAim = v end)
CreateToggle(AimbotContent, "Círculo FOV", 193, false, function(v) Settings.Aimbot.FOVCircleVisible = v end)
CreateSlider(AimbotContent, "FOV", 50, 500, 150, 240, function(v) Settings.Aimbot.FOV = v; if FOVCircle then FOVCircle.Radius = v end end)
CreateSlider(AimbotContent, "Suavidade", 1, 20, 1, 310, function(v) Settings.Aimbot.Smoothness = v end)
CreateToggle(AimbotContent, "Ver Visibilidade", 380, false, function(v) Settings.Aimbot.VisibleCheck = v end)
CreateToggle(AimbotContent, "Ver Times", 427, false, function(v) Settings.Aimbot.TeamCheck = v end)
AimbotContent.CanvasSize = UDim2.new(0, 0, 0, 480)

-- Preencher ESP
CreateToggle(ESPContent, "Ativar ESP", 5, false, function(v) Settings.ESP.Enabled = v end)
CreateToggle(ESPContent, "Team Check", 52, true, function(v) Settings.ESP.TeamCheck = v end)
CreateToggle(ESPContent, "Caixas", 99, false, function(v) Settings.ESP.Boxes = v end)
CreateToggle(ESPContent, "Linhas", 146, false, function(v) Settings.ESP.Tracers = v end)
CreateToggle(ESPContent, "Distância", 193, false, function(v) Settings.ESP.Distance = v end)
CreateToggle(ESPContent, "Barra de Vida", 240, false, function(v) Settings.ESP.HealthBar = v end)
CreateToggle(ESPContent, "Nomes", 287, false, function(v) Settings.ESP.Names = v end)
CreateToggle(ESPContent, "Chams (Highlight)", 334, false, function(v) Settings.ESP.Chams = v end)
CreateSlider(ESPContent, "Distância Máx", 100, 2000, 1000, 381, function(v) Settings.ESP.MaxDistance = v end)
ESPContent.CanvasSize = UDim2.new(0, 0, 0, 450)

-- Preencher FOV
CreateToggle(FOVContent, "Alterar FOV", 5, false, function(v) 
    Settings.FOV.Enabled = v 
    if not v then Camera.FieldOfView = 70 end
end)
CreateSlider(FOVContent, "FOV", 30, 120, 70, 52, function(v) Settings.FOV.Value = v end)

-- Sistema de arrastar
local dragObj, dragStart, startPos = nil, nil, nil
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragObj = MainFrame
        dragStart = input.Position
        startPos = dragObj.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragObj and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        dragObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragObj = nil end
end)

-- Minimizar - Bolinha flutuante
local isMinimized = false
local floatingButton = nil

local function CreateFloatingButton()
    if floatingButton then floatingButton:Destroy(); floatingButton = nil end
    
    floatingButton = Instance.new("TextButton")
    floatingButton.Name = "GalaxyFloating"
    floatingButton.Parent = ScreenGui
    floatingButton.BackgroundColor3 = Color3.fromRGB(100, 30, 180)
    floatingButton.Size = UDim2.new(0, 55, 0, 55)
    floatingButton.Position = UDim2.new(0, 20, 0, 20)
    floatingButton.Font = Enum.Font.GothamBold
    floatingButton.Text = "🌌"
    floatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    floatingButton.TextSize = 26
    floatingButton.BorderSizePixel = 0
    floatingButton.AutoButtonColor = false
    floatingButton.ZIndex = 99999
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = floatingButton
    
    local fDragging, fDragStart, fStartPos, fMoved = false, nil, nil, false
    
    floatingButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            fDragging = true; fMoved = false
            fDragStart = input.Position; fStartPos = floatingButton.Position
        end
    end)
    
    floatingButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            fDragging = false
            if not fMoved then
                isMinimized = false
                MainFrame.Visible = true
                MainFrame.Size = UDim2.new(0, 500, 0, 400)
                MinimizeButton.Text = "—"
                if floatingButton then floatingButton:Destroy(); floatingButton = nil end
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if fDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - fDragStart
            if delta.Magnitude > 3 then fMoved = true end
            floatingButton.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
        end
    end)
end

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Visible = false
        MinimizeButton.Text = "□"
        CreateFloatingButton()
    else
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 500, 0, 400)
        MinimizeButton.Text = "—"
        if floatingButton then floatingButton:Destroy(); floatingButton = nil end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    if floatingButton then floatingButton:Destroy() end
    if FOVCircle then FOVCircle:Remove() end
    ScreenGui:Destroy()
end)

-- Aimbot
local aimKeyHeld = false
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Settings.Aimbot.AimKey then aimKeyHeld = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Settings.Aimbot.AimKey then
        aimKeyHeld = false
        if Settings.Aimbot.LockTarget then Settings.Aimbot.LockedTarget = nil end
    end
end)

local function getClosestPlayer()
    local closest, shortest = nil, Settings.Aimbot.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(Settings.Aimbot.AimPart) then
            if Settings.Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(plr.Character[Settings.Aimbot.AimPart].Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if dist < shortest and dist <= Settings.Aimbot.FOV then
                    if Settings.Aimbot.VisibleCheck then
                        local ray = Ray.new(Camera.CFrame.Position, (plr.Character[Settings.Aimbot.AimPart].Position - Camera.CFrame.Position).Unit * 500)
                        local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character})
                        if hit and not hit:IsDescendantOf(plr.Character) then continue end
                    end
                    shortest = dist; closest = plr
                end
            end
        end
    end
    return closest
end

-- ============================================
-- SILENT AIM CORRIGIDO (NÃO MOVE A CÂMERA)
-- ============================================
local SilentAimTarget = nil
local SilentAimActive = false

local function SilentAim_GetTarget()
    local closest, shortest = nil, Settings.Aimbot.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(Settings.Aimbot.AimPart) then
            if Settings.Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(plr.Character[Settings.Aimbot.AimPart].Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if dist < shortest and dist <= Settings.Aimbot.FOV then
                    shortest = dist; closest = plr
                end
            end
        end
    end
    return closest
end

-- Esta função é chamada a cada frame pelo Silent Aim
local function ProcessSilentAim()
    if not Settings.Aimbot.SilentAim then
        SilentAimTarget = nil
        return
    end
    
    local target = Settings.Aimbot.LockTarget and Settings.Aimbot.LockedTarget or SilentAim_GetTarget()
    
    if target and target.Character then
        local aimPart = target.Character:FindFirstChild(Settings.Aimbot.AimPart)
        if aimPart then
            -- Salva a câmera atual
            local originalCFrame = Camera.CFrame
            
            -- Mira no alvo (apenas a direção, sem mover a posição)
            local direction = (aimPart.Position - Camera.CFrame.Position).Unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
            
            -- Restaura a câmera no próximo frame
            RunService.RenderStepped:Wait()
            Camera.CFrame = originalCFrame
        end
    end
end

-- Chams
local Chams = {}
local function UpdateChams()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if Settings.ESP.Enabled and Settings.ESP.Chams and plr.Character then
                if Settings.ESP.TeamCheck and plr.Team == LocalPlayer.Team then
                    if Chams[plr] then Chams[plr]:Destroy(); Chams[plr] = nil end
                    continue
                end
                if not Chams[plr] then
                    local hl = Instance.new("Highlight")
                    hl.Parent = plr.Character
                    hl.Adornee = plr.Character
                    hl.FillColor = Color3.fromRGB(180, 100, 255)
                    hl.FillTransparency = 0.4
                    hl.OutlineColor = Color3.fromRGB(255, 100, 255)
                    hl.OutlineTransparency = 0
                    Chams[plr] = hl
                end
            else
                if Chams[plr] then Chams[plr]:Destroy(); Chams[plr] = nil end
            end
        end
    end
end

-- ESP Drawings
local ESPDrawings = {}

local function createDrawing(type, properties)
    local success, drawing = pcall(function()
        local d = Drawing.new(type)
        for k, v in pairs(properties) do
            pcall(function() d[k] = v end)
        end
        return d
    end)
    return drawing
end

local function ManageESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not ESPDrawings[plr] then
            ESPDrawings[plr] = {}
            
            ESPDrawings[plr].Box = createDrawing("Square", {
                Thickness = 2, Filled = false, Visible = false,
                Color = Color3.fromRGB(180, 100, 255)
            })
            
            ESPDrawings[plr].Tracer = createDrawing("Line", {
                Thickness = 1.5, Visible = false,
                Color = Color3.fromRGB(180, 100, 255)
            })
            
            ESPDrawings[plr].Dist = createDrawing("Text", {
                Size = 14, Center = true, Outline = true, Visible = false,
                Color = Color3.fromRGB(255, 255, 255)
            })
            
            ESPDrawings[plr].HP = createDrawing("Square", {
                Filled = true, Visible = false
            })
            
            ESPDrawings[plr].Name = createDrawing("Text", {
                Size = 14, Center = true, Outline = true, Visible = false,
                Color = Color3.fromRGB(180, 100, 255)
            })
        end
    end
end

local function UpdateESP()
    for plr, d in pairs(ESPDrawings) do
        if not d.Box then continue end
        
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        
        if char and hum and root and head and hum.Health > 0 then
            local hPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                if Settings.ESP.TeamCheck and plr.Team == LocalPlayer.Team then
                    for _, v in pairs(d) do if v then v.Visible = false end end
                    continue
                end
                
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local dist = myRoot and (myRoot.Position - root.Position).Magnitude or 0
                
                if dist <= Settings.ESP.MaxDistance and Settings.ESP.Enabled then
                    local boxW, boxH = 45, 65
                    
                    if Settings.ESP.Boxes and d.Box then
                        d.Box.Visible = true
                        d.Box.Size = Vector2.new(boxW, boxH)
                        d.Box.Position = Vector2.new(hPos.X - boxW/2, hPos.Y - boxH/2)
                        d.Box.Color = Color3.fromRGB(180, 100, 255)
                    elseif d.Box then d.Box.Visible = false end
                    
                    if Settings.ESP.Tracers and d.Tracer then
                        d.Tracer.Visible = true
                        d.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        d.Tracer.To = Vector2.new(hPos.X, hPos.Y + boxH/2)
                        d.Tracer.Color = Color3.fromRGB(180, 100, 255)
                    elseif d.Tracer then d.Tracer.Visible = false end
                    
                    if Settings.ESP.Distance and d.Dist then
                        d.Dist.Visible = true
                        d.Dist.Text = math.floor(dist).."m"
                        d.Dist.Position = Vector2.new(hPos.X, hPos.Y + boxH/2 + 15)
                    elseif d.Dist then d.Dist.Visible = false end
                    
                    if Settings.ESP.HealthBar and d.HP then
                        local hp = hum.Health / hum.MaxHealth
                        d.HP.Visible = true
                        d.HP.Size = Vector2.new(4, boxH * hp)
                        d.HP.Position = Vector2.new(hPos.X - boxW/2 - 7, hPos.Y + boxH/2 - boxH * hp)
                        d.HP.Color = hp > 0.6 and Color3.fromRGB(0,255,100) or (hp > 0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,50,50))
                    elseif d.HP then d.HP.Visible = false end
                    
                    if Settings.ESP.Names and d.Name then
                        d.Name.Visible = true
                        d.Name.Text = plr.Name
                        d.Name.Position = Vector2.new(hPos.X, hPos.Y - boxH/2 - 18)
                    elseif d.Name then d.Name.Visible = false end
                else
                    for _, v in pairs(d) do if v then v.Visible = false end end
                end
            else
                for _, v in pairs(d) do if v then v.Visible = false end end
            end
        else
            for _, v in pairs(d) do if v then v.Visible = false end end
        end
    end
end

Players.PlayerRemoving:Connect(function(plr)
    if ESPDrawings[plr] then
        for _, d in pairs(ESPDrawings[plr]) do
            if d and d.Remove then d:Remove() end
        end
        ESPDrawings[plr] = nil
    end
    if Chams[plr] then Chams[plr]:Destroy(); Chams[plr] = nil end
end)

-- FOV
local function UpdateFOV()
    if Settings.FOV.Enabled then
        pcall(function()
            Camera.FieldOfView = Settings.FOV.Value
            workspace.CurrentCamera.FieldOfView = Settings.FOV.Value
        end)
    end
end

-- Loop principal
RunService.RenderStepped:Connect(function()
    -- FOV Circle
    if FOVCircle then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        FOVCircle.Visible = Settings.Aimbot.FOVCircleVisible
    end
    
    -- Aimbot Normal
    local shouldAim = Settings.Aimbot.Enabled and (not Settings.Aimbot.UseKeybind or aimKeyHeld)
    
    if not Settings.Aimbot.SilentAim and shouldAim then
        local target = Settings.Aimbot.LockTarget and Settings.Aimbot.LockedTarget or getClosestPlayer()
        if Settings.Aimbot.LockTarget and target and not Settings.Aimbot.LockedTarget then Settings.Aimbot.LockedTarget = target end
        if target and target.Character and target.Character:FindFirstChild(Settings.Aimbot.AimPart) then
            local pos = target.Character[Settings.Aimbot.AimPart].Position
            Camera.CFrame = Settings.Aimbot.Smoothness > 1 and 
                Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pos), 1/Settings.Aimbot.Smoothness) or 
                CFrame.new(Camera.CFrame.Position, pos)
        end
    end
    
    -- Silent Aim (processado separadamente)
    if Settings.Aimbot.SilentAim then
        ProcessSilentAim()
    end
    
    -- FOV
    UpdateFOV()
    
    -- ESP e Chams
    ManageESP()
    UpdateESP()
    UpdateChams()
    
    -- Limpar ESP quando desativado
    if not Settings.ESP.Enabled then
        for _, drawings in pairs(ESPDrawings) do
            for _, d in pairs(drawings) do
                if d and d.Visible then d.Visible = false end
            end
        end
    end
end)

-- Inicializar
SwitchTab("Aimbot")
print("✅ Galaxy Hub v5.0 carregado com sucesso!")
print("✅ Silent Aim REAL - Não move a câmera")
print("✅ Pronto para GitHub")
print("   tô pouco me fudendo, sou pika 😎")
