local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Główny Kontener GUI klucza (1 do 1 jak ze zdjęcia)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoxScriptKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 420)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(0, 180, 255)
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "KOXSCRIPT"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 42
Title.TextColor3 = Color3.fromRGB(0, 220, 255)
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Text = "— KEY SYSTEM —"
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 65)
SubTitle.Font = Enum.Font.SourceSansBold
SubTitle.TextSize = 14
SubTitle.TextColor3 = Color3.fromRGB(255, 0, 150)
SubTitle.BackgroundTransparency = 1
SubTitle.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 460, 0, 50)
TextBox.Position = UDim2.new(0, 45, 0, 140)
TextBox.BackgroundColor3 = Color3.fromRGB(8, 6, 12)
TextBox.Text = ""
TextBox.PlaceholderText = "ENTER YOUR KEY HERE..."
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 16
TextBox.Font = Enum.Font.SourceSans
TextBox.Parent = MainFrame

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(200, 0, 200)
BoxStroke.Thickness = 1.5
BoxStroke.Parent = TextBox

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 215, 0, 50)
GetKeyBtn.Position = UDim2.new(0, 45, 0, 220)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(12, 24, 15)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
GetKeyBtn.TextSize = 18
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Parent = MainFrame

local GetStroke = Instance.new("UIStroke")
GetStroke.Color = Color3.fromRGB(0, 200, 80)
GetStroke.Thickness = 2
GetStroke.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0, 215, 0, 50)
CheckKeyBtn.Position = UDim2.new(0, 290, 0, 220)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
CheckKeyBtn.Text = "CHECK KEY"
CheckKeyBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
CheckKeyBtn.TextSize = 18
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.Parent = MainFrame

local CheckStroke = Instance.new("UIStroke")
CheckStroke.Color = Color3.fromRGB(150, 0, 230)
CheckStroke.Thickness = 2
CheckStroke.Parent = CheckKeyBtn

-- BASE64 DECODER (Odkodowanie klucza z Discorda)
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function decodeBase64(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local r=0
        for i=1,8 do r=r+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(r)
    end))
end

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg")
    TextBox.PlaceholderText = "LINK COPIED! GO TO DISCORD"
end)
-- ========================================================
-- SILNIK MODYFIKACJI GRY (OBSŁUGUJE WSZYSTKIE CZITY)
-- ========================================================
local Features = {
    Aim = false,
    Fly = false,
    NoRecoil = false,
    ESP = false
}

-- Pętla obsługująca Aimbota oraz ESP (Wallhack na graczy)
RunService.RenderStepped:Connect(function()
    -- 1. Obsługa AUTO AIM
    if Features.Aim then
        local ClosestPlayer = nil
        local ShortestDistance = math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local ScreenPos, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local Mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPos.X, ScreenPos.Y)).Magnitude
                    if Mag < ShortestDistance and Mag < 400 then
                        ShortestDistance = Mag
                        ClosestPlayer = v
                    end
                end
            end
        end
        if ClosestPlayer then
            local Cam = workspace.CurrentCamera
            Cam.CFrame = CFrame.lookAt(Cam.CFrame.Position, ClosestPlayer.Character.HumanoidRootPart.Position)
        end
    end

    -- 2. Obsługa ESP / WALLHACK
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local p = v.Character.HumanoidRootPart
            if Features.ESP and not p:FindFirstChild("KoxESP") then
                local Box = Instance.new("BoxHandleAdornment")
                Box.Name = "KoxESP"
                Box.Size = Vector3.new(4, 6, 4)
                Box.AlwaysOnTop = true
                Box.ZIndex = 5
                Box.Color3 = Color3.fromRGB(255, 0, 0)
                Box.Adornee = p
                Box.Transparency = 0.5
                Box.Parent = p
            elseif not Features.ESP and p:FindFirstChild("KoxESP") then
                p.KoxESP:Destroy()
            end
        end
    end
end)

-- Pętla obsługująca Latanie (Fly)
local BodyVelocity = nil
RunService.Heartbeat:Connect(function()
    if Features.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not BodyVelocity or BodyVelocity.Parent ~= hrp then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Parent = hrp
        end
        local moveDir = LocalPlayer.Character.Humanoid.MoveDirection
        local flySpeed = 50
        local velocity = moveDir * flySpeed
        
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, flySpeed, 0)
        elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
            velocity = velocity + Vector3.new(0, -flySpeed, 0)
        end
        BodyVelocity.Velocity = velocity
    else
        if BodyVelocity then
            BodyVelocity:Destroy()
            BodyVelocity = nil
        end
    end
end)

-- Funkcja, która uruchamia wybraną funkcję na podstawie nazwy wpisanej na Discordzie
function ToggleCheatFeature(featureName, state)
    local name = string.lower(featureName)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    if string.find(name, "aim") then
        Features.Aim = state
    elseif string.find(name, "fly") then
        Features.Fly = state
    elseif string.find(name, "esp") or string.find(name, "wallhack") then
        Features.ESP = state
    elseif string.find(name, "speed") then
        hum.WalkSpeed = state and 100 or 16
    elseif string.find(name, "jump") then
        hum.JumpPower = state and 150 or 50
    elseif string.find(name, "recoil") or string.find(name, "rozrzut") then
        Features.NoRecoil = state
        for _, v in pairs(game:GetService("CollectionService"):GetTagged("Weapon")) do
            if v:FindFirstChild("Recoil") then v.Recoil.Value = state and 0 or v.Recoil.Value end
        end
    end
end
-- ========================================================
-- GENERATOR DYNAMICZNEGO GUI Z KLUCZA DISCORDA
-- ========================================================
function BuildCustomCheatGUI(config)
    MainFrame:Destroy()

    local CheatGui = Instance.new("Frame")
    CheatGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    CheatGui.Active = true
    CheatGui.Draggable = true
    CheatGui.Parent = ScreenGui

    -- 1. Ustawianie wielkości GUI
    if config.sz == "caly ekran" then
        CheatGui.Size = UDim2.new(1, 0, 1, 0)
        CheatGui.Position = UDim2.new(0, 0, 0, 0)
    elseif config.sz == "duze" then
        CheatGui.Size = UDim2.new(0, 800, 0, 550)
        CheatGui.Position = UDim2.new(0.5, -400, 0.5, -275)
    else
        CheatGui.Size = UDim2.new(0, 600, 0, 400)
        CheatGui.Position = UDim2.new(0.5, -300, 0.5, -200)
    end

    -- 2. Wygląd i neony
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 3
    Stroke.Parent = CheatGui

    if string.find(string.lower(config.st), "zielone") or string.find(string.lower(config.st), "pixel") then
        Stroke.Color = Color3.fromRGB(0, 255, 100)
    else
        Stroke.Color = Color3.fromRGB(255, 0, 150)
    end

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 40)
    Label.Text = "KOXSCRIPT CUSTOM MENU"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 18
    Label.Parent = CheatGui

    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 160, 1, -40)
    SideBar.Position = UDim2.new(0, 0, 0, 40)
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    SideBar.Parent = CheatGui

    local CategoryLayout = Instance.new("UIListLayout")
    CategoryLayout.Padding = UDim.new(0, 5)
    CategoryLayout.Parent = SideBar

    local MainContent = Instance.new("Frame")
    MainContent.Size = UDim2.new(1, -160, 1, -40)
    MainContent.Position = UDim2.new(0, 160, 0, 40)
    MainContent.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    MainContent.Parent = CheatGui

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 8)
    ContentLayout.Parent = MainContent

    -- 3. Generowanie Kategorii i Funkcji
    local categories = string.split(config.fn, "|")
    
    for i, catData in ipairs(categories) do
        if i > 4 then break end
        
        local parts = string.split(catData, "-")
        local catName = parts or "Kategoria"
        local functionsList = parts or ""

        local CatBtn = Instance.new("TextButton")
        CatBtn.Size = UDim2.new(1, 0, 0, 35)
        CatBtn.Text = catName:upper()
        CatBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        CatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        CatBtn.Font = Enum.Font.SourceSansBold
        CatBtn.TextSize = 14
        CatBtn.Parent = SideBar

        local funcItems = string.split(functionsList, ",")
        
        CatBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(MainContent:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end

            for j, funcName in ipairs(funcItems) do
                if j > 5 then break end
                
                local FuncFrame = Instance.new("Frame")
                FuncFrame.Size = UDim2.new(1, -20, 0, 40)
                FuncFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
                FuncFrame.Parent = MainContent

                local FuncLabel = Instance.new("TextLabel")
                FuncLabel.Size = UDim2.new(0.7, 0, 1, 0)
                FuncLabel.Text = "  " .. funcName
                FuncLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                FuncLabel.TextXAlignment = Enum.TextXAlignment.Left
                FuncLabel.BackgroundTransparency = 1
                FuncLabel.Font = Enum.Font.SourceSans
                FuncLabel.TextSize = 16
                FuncLabel.Parent = FuncFrame

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(0, 60, 0, 26)
                ToggleBtn.Position = UDim2.new(0.9, -50, 0.5, -13)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                ToggleBtn.Text = "OFF"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.Font = Enum.Font.SourceSansBold
                ToggleBtn.TextSize = 14
                ToggleBtn.Parent = FuncFrame

                local toggled = false
                ToggleBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                        ToggleBtn.Text = "ON"
                        ToggleCheatFeature(funcName, true)
                    else
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                        ToggleBtn.Text = "OFF"
                        ToggleCheatFeature(funcName, false)
                    end
                end)
            end
        end)
    end
end

-- Walidacja Klucza po kliknięciu CHECK KEY
CheckKeyBtn.MouseButton1Click:Connect(function()
    local inputKey = TextBox.Text
    local success, result = pcall(function()
        local decodedJson = decodeBase64(inputKey)
        return game:GetService("HttpService"):JSONDecode(decodedJson)
    end)

    if success and result and result.sz and result.st and result.fn then
        BuildCustomCheatGUI(result)
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "INVALID KEY! TRY AGAIN..."
        TextBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
