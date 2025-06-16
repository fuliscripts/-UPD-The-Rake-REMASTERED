
-- The Rake: Remastered - Parte 1: Inicialización

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Rake = nil
local Speed = 50
local DomeEnabled = false
local AuraEnabled = false
local ESPEnabled = false

-- Parte 2: GUI Setup

local ScreenGui = Instance.new("ScreenGui", CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Active = true
Frame.Draggable = true

local function CreateButton(name, pos, callback)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0, 180, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, pos)
    Button.Text = name
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.MouseButton1Click:Connect(callback)
end

-- Parte 3: Aura y Cúpula

local function StartAura()
    AuraEnabled = true
    while AuraEnabled do
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Rake" and v:FindFirstChild("Humanoid") then
                local distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude
                if distance < 15 then
                    v.Humanoid:TakeDamage(10)
                end
            end
        end
        wait(0.1)
    end
end

local function StopAura()
    AuraEnabled = false
end

local function CreateDome()
    DomeEnabled = true
    local Dome = Instance.new("Part", Workspace)
    Dome.Shape = Enum.PartType.Ball
    Dome.Size = Vector3.new(20, 20, 20)
    Dome.Transparency = 0.5
    Dome.Anchored = true
    Dome.CanCollide = true
    Dome.Color = Color3.fromRGB(0, 150, 255)
    Dome.Material = Enum.Material.ForceField

    spawn(function()
        while DomeEnabled and Dome.Parent do
            Dome.Position = LocalPlayer.Character.PrimaryPart.Position
            wait()
        end
        Dome:Destroy()
    end)
end

local function RemoveDome()
    DomeEnabled = false
end

-- Parte 4: Stamina, Speed y ESP

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Stamina") then


        LocalPlayer.Character.Stamina.Value = 100
    end
    Lighting.Brightness = 3
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Speed
    end
end)

local function StartESP()
    ESPEnabled = true
    while ESPEnabled do
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and not v.Character:FindFirstChild("ESP") then
                local Billboard = Instance.new("BillboardGui", v.Character)
                Billboard.Name = "ESP"
                Billboard.Size = UDim2.new(0, 100, 0, 40)
                Billboard.Adornee = v.Character.PrimaryPart
                Billboard.AlwaysOnTop = true

                local Label = Instance.new("TextLabel", Billboard)
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.TextColor3 = Color3.new(1, 0, 0)
                Label.BackgroundTransparency = 1
                Label.TextScaled = true
                spawn(function()
                    while ESPEnabled and Billboard.Parent do
                        Label.Text = v.Name .. " | " .. math.floor((v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude) .. "m"
                        wait(0.1)
                    end
                    Billboard:Destroy()
                end)
            end
        end
        wait(0.5)
    end
end

local function StopESP()
    ESPEnabled = false
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("ESP") then
            v.Character.ESP:Destroy()
        end
    end
end

-- Parte 5: Kill Rake, Teleports y Botones

local function KillRake()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Rake" and v:FindFirstChild("Humanoid") then
            v.Humanoid:TakeDamage(9999)
        end
    end
end

local function TeleportTo(position)
    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(position))
end

CreateButton("Aura ON", 10, StartAura)
CreateButton("Aura OFF", 50, StopAura)
CreateButton("Cúpula ON", 90, CreateDome)
CreateButton("Cúpula OFF", 130, RemoveDome)
CreateButton("ESP ON", 170, StartESP)
CreateButton("ESP OFF", 210, StopESP)
CreateButton("Kill Rake", 250, KillRake)
CreateButton("TP Torre", 290, function() TeleportTo(Vector3.new(-250, 10, 200)) end)

print("Script cargado correctamente.")
