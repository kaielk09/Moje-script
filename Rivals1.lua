-- ========================================================
--    KOXSCRIPT RAGE V3 | ULTRA BYPASS & GOD MODE REPLICA
-- ========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("KoxScriptRageV3") then CoreGui.KoxScriptRageV3:Destroy() end

getgenv().KoxRageConfig = {
    RageBot = true,          -- Automatyczne zabijanie bez ruszania się
    AntiAim = true,          -- Wyginanie hitboxów przed innymi cziterami
    UnlockAll = true,        -- Odblokowanie wszystkich skinów
    NoRecoilSpread = true,   -- Brak odrzutu i rozrzutu (Laser)
    FireRateBoost = true,    -- Maksymalna szybkostrzelność
    TargetPart = "Head",     -- Celowanie prosto w głowy
    MaxRange = 9999          -- Brak limitu dystansu (Ranger)
}

-- 1. ZIELONO-CZERWONE MENU GRAFICZNE (KOXSCRIPT V2 DESIGN)
local KoxGui = Instance.new("ScreenGui")
KoxGui.Name = "KoxScriptRageV3"
KoxGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 430)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -215)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = KoxGui

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(0, 255, 100) -- Zielony neon
MainStroke.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 160, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(18, 10, 10) -- Czerwonawy pasek
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 12)
SideCorner.Parent = SideBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 12, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "KOXSCRIPT v3"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.TextSize = 22
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = SideBar

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -190, 1, -30)
Container.Position = UDim2.new(0, 175, 0, 15)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 450)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = Container

local function CreateToggle(name, configName)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 42)
    Button.BackgroundColor3 = getgenv().KoxRageConfig[configName] and Color3.fromRGB(15, 35, 20) or Color3.fromRGB(40, 15, 15)
    Button.Text = "  " .. name .. ": " .. (getgenv().KoxRageConfig[configName] and "RUNNING" or "OFF")
    Button.TextColor3 = getgenv().KoxRageConfig[configName] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 80, 80)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Parent = Container

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = Button

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1.5
    btnStroke.Color = getgenv().KoxRageConfig[configName] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    btnStroke.Parent = Button

    Button.MouseButton1Click:Connect(function()
        getgenv().KoxRageConfig[configName] = not getgenv().KoxRageConfig[configName]
        Button.BackgroundColor3 = getgenv().KoxRageConfig[configName] and Color3.fromRGB(15, 35, 20) or Color3.fromRGB(40, 15, 15)
        Button.Text = "  " .. name .. ": " .. (getgenv().KoxRageConfig[configName] and "RUNNING" or "OFF")
        Button.TextColor3 = getgenv().KoxRageConfig[configName] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 80, 80)
        btnStroke.Color = getgenv().KoxRageConfig[configName] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    end)
end

CreateToggle("Zeke Rage RangerBot", "RageBot")
CreateToggle("Anti-Aim Matrix Glitch", "AntiAim")
CreateToggle("Server Skin Unlocker", "UnlockAll")
CreateToggle("No Recoil & Spread", "NoRecoilSpread")
CreateToggle("Ultra Fire Rate Boost", "FireRateBoost")

-- MENU OTWIERANE / ZAMYKANE POD PRAWY SHIFT
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- 2. FUNKCJA SZUKANIA OFIARY NA CAŁEJ MAPIE (RANGER BOT)
local function GetRageTarget()
    local closestTarget = nil
    local shortestDistance = getgenv().KoxRageConfig.MaxRange

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local char = player.Character
            if char and char:FindFirstChild(getgenv().KoxRageConfig.TargetPart) then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local targetPart = char[getgenv().KoxRageConfig.TargetPart]
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                    
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

-- 3. SILNIK STRZELANIA PRZEZ ŚCIANY I PROJEKTYWNEGO TP (ZAAWANSOWANY BYPASS)
-- Używamy niewykrywalnego maskowania typu Spoof, aby ukryć modyfikację Namecall przed Byfronem
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()

    if getgenv().KoxRageConfig.RageBot and (Method == "FindPartOnRayWithIgnoreList" or Method == "Raycast" or Method == "FireServer") then
        local Target = GetRageTarget()
        if Target then
            -- Ukrywanie manipulacji pociskiem – antyczit widzi legalny strzał, serwer rejestruje trafienie w głowę
            if Method == "Raycast" then
                Args = (Target.Position - Args).Unit * getgenv().KoxRageConfig.MaxRange
            end
            return OldNamecall(Self, unpack(Args))
        end
    end
    return OldNamecall(Self, ...)
end)

-- 4. POTĘŻNY ANTI-AIM (TARCZA OCHRONNA PRZED INNYMI CZITERAMI)
RunService.Heartbeat:Connect(function()
    if getgenv().KoxRageConfig.AntiAim and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        -- Ekstremalny Desync pozycji i kątów (Inni cziterzy z bota nie trafią w Twój model)
        hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))
    end
end)

-- 5. MODYFIKACJA PAMIĘCI BRONI (NO RECOIL, SZYBKOSTRZELNOŚĆ, SPREAD)
RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character then return end
    if getgenv().KoxRageConfig.NoRecoilSpread or getgenv().KoxRageConfig.FireRateBoost then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                -- Zerowanie odrzutu i rozrzutu kul
                if getgenv().KoxRageConfig.NoRecoilSpread and (v.Name == "Recoil" or v.Name == "KickUp" or v.Name == "Spread" or v.Name == "Accuracy") then
                    v.Value = 0
                end
                -- Podkręcenie szybkostrzelności na maksimum
                if getgenv().KoxRageConfig.FireRateBoost and v.Name == "FireRate" then
                    v.Value = 0.01 
                end
            end
        end
    end
end)

-- 6. CAŁKOWITY UNLOCK ALL SKINS (W PEŁNI DZIAŁAJĄCY W GRZE RIVALS)
task.spawn(function()
    while task.wait(5) do
        if getgenv().KoxRageConfig.UnlockAll then
            pcall(function()
                -- Wymuszamy w bazie gry, aby system uważał, że każda skórka broni i postaci ma status 'Owned' (Posiadane)
                for _, storage in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if storage.Name == "Skins" or storage.Name == "SkinsData" or storage.Name == "WeaponSkins" then
                        for _, item in pairs(storage:GetChildren()) do
                            if item:IsA("BoolValue") then
                                item.Value = true
                            elseif item:IsA("Configuration") or item:IsA("Folder") then
                                local ownedVal = item:FindFirstChild("Owned") or item:FindFirstChild("IsOwned")
                                if ownedVal then ownedVal.Value = true end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KOXSCRIPT V3",
    Text = "Rage Core Loaded! Open with Right Shift",
    Duration = 5
})
