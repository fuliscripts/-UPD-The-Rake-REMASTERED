
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
