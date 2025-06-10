-- FULI HUB - Codex Safe Version
-- Funciona sin getconnections, getgc, ni Highlight

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- GUI simple
local gui = Instance.new("ScreenGui")
gui.Name = "FuliHubCodexSafe"
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0, 10, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 4)

local function addBtn(name, func)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name
    btn.MouseButton1Click:Connect(func)
end

-- Funciones seguras

addBtn("FullBright", function()
    Lighting.FogEnd = 1000000
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
end)

addBtn("WalkSpeed 100", function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.WalkSpeed = 100
        end
    end
end)

addBtn("Insta Kill Rake", function()
    for _, m in pairs(Workspace:GetDescendants()) do
        if m:IsA("Model") and m.Name:lower():find("rake") then
            local h = m:FindFirstChildOfClass("Humanoid")
            if h then h.Health = 0 end
        end
    end
end)

addBtn("Kill All NPCs", function()
    for _, m in pairs(Workspace:GetDescendants()) do
        if m:IsA("Model") and not Players:FindFirstChild(m.Name) then
            local h = m:FindFirstChildOfClass("Humanoid")
            if h then h.Health = 0 end
        end
    end
end)

addBtn("Stun Stick Aura", function()
    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, m in pairs(Workspace:GetDescendants()) do
            if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") then
                local targetHRP = m:FindFirstChild("HumanoidRootPart")
                if targetHRP and (targetHRP.Position - hrp.Position).Magnitude < 10 then
                    m:FindFirstChildOfClass("Humanoid").Health = 0
                end
            end
        end
    end)
end)

addBtn("Infinite Stamina", function()
    local char = LocalPlayer.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("NumberValue") and v.Name:lower():find("stamina") then
            v.Value = 999
        end
    end
end)
