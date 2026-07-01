-- ULTRA-DOKŁADNA KONFIGURACJA WIZUALNA (1 DO 1)
local BACKEND_URL = "n6.tosthost.pl:5010" 
local DISCORD_INVITE = "https://discord.gg/WnKJJmEPq" 

local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("KoxScriptKeySystem") then
    CoreGui.KoxScriptKeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoxScriptKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- GŁÓWNY PANEL (Ciemne tło Cyberpunk)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 620, 0, 480)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 14)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

-- SPECJALNY GRADIENT RAMKI (Cyan do Magenta - 1 do 1 z obrazka)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 0, 140))
})
MainGradient.Parent = MainStroke

-- TRÓJKĄT LOGO NA GÓRZE (Imitacja świecącego V)
local TopVLogo = Instance.new("TextLabel")
TopVLogo.Size = UDim2.new(0, 60, 0, 30)
TopVLogo.Position = UDim2.new(0.5, -30, 0, 15)
TopVLogo.BackgroundTransparency = 1
TopVLogo.Text = "▽"
TopVLogo.TextColor3 = Color3.fromRGB(150, 0, 255)
TopVLogo.TextSize = 34
TopVLogo.Font = Enum.Font.FredokaOne
TopVLogo.Parent = MainFrame

local TopVGradient = Instance.new("UIGradient")
TopVGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))
})
TopVGradient.Parent = TopVLogo

-- LOGO: KOXSCRIPT
local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 50)
LogoText.Position = UDim2.new(0, 0, 0, 55)
LogoText.BackgroundTransparency = 1
LogoText.Text = "KOXSCRIPT"
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.TextSize = 52
LogoText.Font = Enum.Font.FredokaOne
LogoText.Parent = MainFrame

local LogoGradient = Instance.new("UIGradient")
LogoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 240, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 150))
})
LogoGradient.Parent = LogoText

-- PODTYTUŁ: KEY SYSTEM (Z ozdobnymi liniami po bokach)
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 110)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "——  K E Y   S Y S T E M  ——"
SubTitle.TextColor3 = Color3.fromRGB(200, 0, 120)
SubTitle.TextSize = 13
SubTitle.Font = Enum.Font.SourceSansBold
SubTitle.Parent = MainFrame

-- STATUS / PROMPT: ENTER YOUR KEY
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 160)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "◢  ENTER YOUR KEY  ◣"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Parent = MainFrame

-- RAMKA POLA TEKSTOWEGO
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0, 530, 0, 70)
InputFrame.Position = UDim2.new(0.5, -265, 0, 195)
InputFrame.BackgroundColor3 = Color3.fromRGB(14, 9, 20)
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 14)
InputCorner.Parent = InputFrame

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 2
InputStroke.Color = Color3.fromRGB(255, 255, 255)
InputStroke.Parent = InputFrame

local InputFrameGradient = Instance.new("UIGradient")
InputFrameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 0, 120))
})
InputFrameGradient.Parent = InputStroke

-- Ikonka Kluczyka w polu tekstowym
local KeyIcon = Instance.new("TextLabel")
KeyIcon.Size = UDim2.new(0, 40, 1, 0)
KeyIcon.Position = UDim2.new(0, 20, 0, 0)
KeyIcon.BackgroundTransparency = 1
KeyIcon.Text = "🔑"
KeyIcon.TextSize = 24
KeyIcon.TextXAlignment = Enum.TextXAlignment.Left
KeyIcon.Parent = InputFrame

-- TextBox
local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(1, -90, 1, 0)
KeyTextBox.Position = UDim2.new(0, 65, 0, 0)
KeyTextBox.BackgroundTransparency = 1
KeyTextBox.PlaceholderText = "ENTER YOUR KEY HERE..."
KeyTextBox.Text = ""
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 95)
KeyTextBox.TextSize = 16
KeyTextBox.Font = Enum.Font.SourceSans
KeyTextBox.TextXAlignment = Enum.TextXAlignment.Left
KeyTextBox.Parent = InputFrame

-- PRZYCISK: GET KEY (Neon Green z dekoracjami w rogach)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 250, 0, 60)
GetKeyBtn.Position = UDim2.new(0, 45, 0, 295)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(10, 35, 20)
GetKeyBtn.Text = "🔑   GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(50, 255, 140)
GetKeyBtn.TextSize = 18
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 12)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Thickness = 2
GetKeyStroke.Color = Color3.fromRGB(0, 230, 110)
GetKeyStroke.Parent = GetKeyBtn

-- Dekoracyjne ukośne kreski w rogu przycisku Get Key
local DecalLine1 = Instance.new("TextLabel")
DecalLine1.Size = UDim2.new(0, 20, 0, 15)
DecalLine1.Position = UDim2.new(1, -25, 1, -18)
DecalLine1.BackgroundTransparency = 1
DecalLine1.Text = "///"
DecalLine1.TextColor3 = Color3.fromRGB(0, 200, 90)
DecalLine1.TextSize = 12
DecalLine1.Font = Enum.Font.SourceSansBold
DecalLine1.Parent = GetKeyBtn

-- PRZYCISK: CHECK KEY (Neon Purple z dekoracjami w rogach)
local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0, 250, 0, 60)
CheckKeyBtn.Position = UDim2.new(0, 325, 0, 295)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 40)
CheckKeyBtn.Text = "🛡️   CHECK KEY"
CheckKeyBtn.TextColor3 = Color3.fromRGB(240, 50, 255)
CheckKeyBtn.TextSize = 18
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.Parent = MainFrame

local CheckKeyCorner = Instance.new("UICorner")
CheckKeyCorner.CornerRadius = UDim.new(0, 12)
CheckKeyCorner.Parent = CheckKeyBtn

local CheckKeyStroke = Instance.new("UIStroke")
CheckKeyStroke.Thickness = 2
CheckKeyStroke.Color = Color3.fromRGB(200, 0, 200)
CheckKeyStroke.Parent = CheckKeyBtn

local DecalLine2 = Instance.new("TextLabel")
DecalLine2.Size = UDim2.new(0, 20, 0, 15)
DecalLine2.Position = UDim2.new(1, -25, 1, -18)
DecalLine2.BackgroundTransparency = 1
DecalLine2.Text = "///"
DecalLine2.TextColor3 = Color3.fromRGB(160, 0, 160)
DecalLine2.TextSize = 12
DecalLine2.Font = Enum.Font.SourceSansBold
DecalLine2.Parent = CheckKeyBtn

-- DOLNA BELKA (FOOTER - SECURE, FAST, RELIABLE)
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -50)
Footer.BackgroundTransparency = 1
Footer.Text = "🔒 SECURE      ⚡ FAST      🛡️ RELIABLE"
Footer.TextColor3 = Color3.fromRGB(120, 110, 140)
Footer.TextSize = 12
Footer.Font = Enum.Font.SourceSansBold
Footer.Parent = MainFrame


-- LOGIKA SYSTEMU WERYFIKACJI

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
        StatusLabel.Text = "DISCORD LINK COPIED TO CLIPBOARD!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 240, 255)
    else
        StatusLabel.Text = "CANNOT COPY. JOIN: " .. DISCORD_INVITE
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
    end
end)

CheckKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyTextBox.Text
    if userKey == "" then
        StatusLabel.Text = "PLEASE ENTER A KEY FIRST!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        return
    end

    StatusLabel.Text = "LOADING... PLEASE WAIT"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)

    local success, response = pcall(function()
        return game:HttpGet(BACKEND_URL .. HttpService:UrlEncode(userKey))
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        
        if data.status == "valid" then
            StatusLabel.Text = "SUCCESS! LOADING SCRIPT..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            task.wait(1.5)
            ScreenGui:Destroy()
            
            -- Odpalenie skryptu docelowego po pomyślnej weryfikacji
            loadstring(game:HttpGet("https://githubusercontent.com"))()
            
        elseif data.status == "expired" then
            StatusLabel.Text = "KEY EXPIRED! GET A NEW ONE"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        else
            StatusLabel.Text = "INVALID KEY! TRY AGAIN"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    else
        StatusLabel.Text = "ERROR CONNECTING TO HOST SERVER!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
