-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PlayerTradeESP"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Toggle System (Positioned top right for mobile)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(1, -70, 0, 20) -- Top right position
toggleButton.AnchorPoint = Vector2.new(1, 0) -- Anchor to right side
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
toggleButton.Text = "☰"
toggleButton.Font = Enum.Font.SciFi
toggleButton.TextSize = 24
toggleButton.ZIndex = 10

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0.2, 0)
toggleCorner.Parent = toggleButton

-- Sound Effects
local openSound = Instance.new("Sound")
openSound.SoundId = "rbxassetid://9045567253"
openSound.Volume = 0.5
openSound.Parent = gui

local closeSound = Instance.new("Sound")
closeSound.SoundId = "rbxassetid://9045566887"
closeSound.Volume = 0.5
closeSound.Parent = gui

-- Main Frame (Positioned near toggle button)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.35, 0, 0.5, 0)
mainFrame.Position = UDim2.new(1, -20, 0, 20) -- Top right position
mainFrame.AnchorPoint = Vector2.new(1, 0) -- Anchor to right side
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Make the frame movable

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.05, 0)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.15, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TRADE FREEZE"
title.Font = Enum.Font.SciFi
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextSize = 24
title.Parent = mainFrame

-- Player Search Box
local searchBox = Instance.new("TextBox")
searchBox.Name = "PlayerSearchBox"
searchBox.Size = UDim2.new(0.8, 0, 0.1, 0)
searchBox.Position = UDim2.new(0.1, 0, 0.2, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "Please enter a username"
searchBox.Text = ""
searchBox.Font = Enum.Font.SciFi
searchBox.TextSize = 16
searchBox.ClearTextOnFocus = false

local searchBoxCorner = Instance.new("UICorner")
searchBoxCorner.CornerRadius = UDim.new(0.2, 0)
searchBoxCorner.Parent = searchBox

-- Search Button
local searchButton = Instance.new("TextButton")
searchButton.Name = "SearchButton"
searchButton.Size = UDim2.new(0.3, 0, 0.1, 0)
searchButton.Position = UDim2.new(0.35, 0, 0.32, 0)
searchButton.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
searchButton.Text = "SEARCH"
searchButton.Font = Enum.Font.SciFi
searchButton.TextColor3 = Color3.fromRGB(200, 255, 255)
searchButton.TextSize = 16

local searchButtonCorner = Instance.new("UICorner")
searchButtonCorner.CornerRadius = UDim.new(0.2, 0)
searchButtonCorner.Parent = searchButton

-- Player Display Area (smaller and inline)
local playerDisplay = Instance.new("Frame")
playerDisplay.Name = "PlayerDisplay"
playerDisplay.Size = UDim2.new(0.8, 0, 0.15, 0)
playerDisplay.Position = UDim2.new(0.1, 0, 0.45, 0)
playerDisplay.BackgroundTransparency = 1
playerDisplay.Visible = false

-- Small Avatar
local playerAvatar = Instance.new("ImageLabel")
playerAvatar.Name = "PlayerAvatar"
playerAvatar.Size = UDim2.new(0.15, 0, 1, 0)
playerAvatar.Position = UDim2.new(0, 0, 0, 0)
playerAvatar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
playerAvatar.BorderSizePixel = 0
playerAvatar.ScaleType = Enum.ScaleType.Fit

local playerAvatarCorner = Instance.new("UICorner")
playerAvatarCorner.CornerRadius = UDim.new(0.1, 0)
playerAvatarCorner.Parent = playerAvatar

-- Player Name (inline with avatar)
local playerName = Instance.new("TextLabel")
playerName.Name = "PlayerName"
playerName.Size = UDim2.new(0.8, 0, 0.5, 0)
playerName.Position = UDim2.new(0.2, 0, 0, 0)
playerName.BackgroundTransparency = 1
playerName.Text = "Target: "
playerName.Font = Enum.Font.SciFi
playerName.TextColor3 = Color3.fromRGB(200, 200, 255)
playerName.TextSize = 16
playerName.TextXAlignment = Enum.TextXAlignment.Left

-- Trade Control Buttons (always visible)
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Size = UDim2.new(0.8, 0, 0.2, 0)
buttonFrame.Position = UDim2.new(0.1, 0, 0.65, 0)
buttonFrame.BackgroundTransparency = 1

-- Freeze Trade Button
local freezeButton = Instance.new("TextButton")
freezeButton.Name = "FreezeButton"
freezeButton.Size = UDim2.new(0.45, 0, 1, 0)
freezeButton.Position = UDim2.new(0, 0, 0, 0)
freezeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
freezeButton.Text = "FREEZE"
freezeButton.Font = Enum.Font.SciFi
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.TextSize = 16

local freezeCorner = Instance.new("UICorner")
freezeCorner.CornerRadius = UDim.new(0.2, 0)
freezeCorner.Parent = freezeButton

-- Force Accept Button
local acceptButton = freezeButton:Clone()
acceptButton.Name = "AcceptButton"
acceptButton.Position = UDim2.new(0.55, 0, 0, 0)
acceptButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
acceptButton.Text = "FORCE ACCEPT"

local acceptCorner = Instance.new("UICorner")
acceptCorner.CornerRadius = UDim.new(0.2, 0)
acceptCorner.Parent = acceptButton

-- Status Message
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
statusLabel.Position = UDim2.new(0.1, 0, 0.85, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.Font = Enum.Font.SciFi
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.TextSize = 14
statusLabel.Parent = mainFrame

-- Parent elements
searchBox.Parent = mainFrame
searchButton.Parent = mainFrame
playerDisplay.Parent = mainFrame
playerAvatar.Parent = playerDisplay
playerName.Parent = playerDisplay
buttonFrame.Parent = mainFrame
freezeButton.Parent = buttonFrame
acceptButton.Parent = buttonFrame

-- Function to get player thumbnail
local function getPlayerThumbnail(userId)
    local success, result = pcall(function()
        return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    end)
    return success and result or "rbxassetid://0"
end

-- Trade control functions (placeholder implementations)
local function freezeTrade()
    statusLabel.Text = "Trade frozen!"
    task.delay(2, function() statusLabel.Text = "" end)
    -- Add actual freeze trade functionality here
end

local function forceAccept()
    statusLabel.Text = "Trade force accepted!"
    task.delay(2, function() statusLabel.Text = "" end)
    -- Add actual force accept functionality here
end

-- Search functionality
searchButton.MouseButton1Click:Connect(function()
    local username = searchBox.Text
    if username == "" then
        statusLabel.Text = "Please enter a username"
        task.delay(2, function() statusLabel.Text = "" end)
        playerDisplay.Visible = false
        return
    end

    local player = Players:FindFirstChild(username)
    if not player then
        statusLabel.Text = "Player not found in game"
        task.delay(2, function() statusLabel.Text = "" end)
        playerDisplay.Visible = false
        return
    end

    -- Update player display
    playerName.Text = "Target: "..player.Name
    playerAvatar.Image = getPlayerThumbnail(player.UserId)
    playerDisplay.Visible = true
    statusLabel.Text = "Player found: "..player.Name
    task.delay(2, function() statusLabel.Text = "" end)
end)

-- Button functionality
freezeButton.MouseButton1Click:Connect(freezeTrade)
acceptButton.MouseButton1Click:Connect(forceAccept)

-- Toggle Functionality
local guiVisible = false -- Start with GUI closed
mainFrame.Visible = false

toggleButton.MouseButton1Click:Connect(function()
    if guiVisible then
        local tweenOut = TweenService:Create(mainFrame, TweenInfo.new(0.5), {Position = UDim2.new(1.5, 0, 0, 20)})
        tweenOut:Play()
        closeSound:Play()
        toggleButton.Text = "≡"
    else
        mainFrame.Visible = true
        local tweenIn = TweenService:Create(mainFrame, TweenInfo.new(0.5), {Position = UDim2.new(1, -20, 0, 20)})
        tweenIn:Play()
        openSound:Play()
        toggleButton.Text = "☰"
    end
    guiVisible = not guiVisible
end)

-- Final parenting
toggleButton.Parent = gui
mainFrame.Parent = gui

-- Mobile optimization
if UserInputService.TouchEnabled then
    -- Make elements slightly larger for touch screens
    toggleButton.Size = UDim2.new(0, 60, 0, 60)
    searchBox.TextSize = 18
    searchButton.TextSize = 18
    freezeButton.TextSize = 18
    acceptButton.TextSize = 18
end
