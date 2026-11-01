local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("FlightInput")
local plane = workspace:WaitForChild("A320_Prototype")
local seat = plane:WaitForChild("PilotSeat")
local throttle = 0
local held = {}
local gui = Instance.new("ScreenGui")
gui.Name = "FlightHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
local label = Instance.new("TextLabel")
label.Size = UDim2.fromOffset(330, 110)
label.Position = UDim2.fromOffset(16, 16)
label.BackgroundTransparency = 0.25
label.BackgroundColor3 = Color3.fromRGB(15, 24, 35)
label.TextColor3 = Color3.new(1, 1, 1)
label.TextSize = 18
label.Font = Enum.Font.Code
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = gui
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    held[input.KeyCode] = true
end)
UserInputService.InputEnded:Connect(function(input)
    held[input.KeyCode] = nil
end)
local accumulator = 0
RunService.RenderStepped:Connect(function(dt)
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    local flying = humanoid and humanoid.SeatPart == seat
    label.Visible = flying == true
    if not flying then return end
    if held[Enum.KeyCode.LeftShift] or held[Enum.KeyCode.RightShift] then throttle = math.min(1, throttle + dt * 0.25) end
    if held[Enum.KeyCode.LeftControl] or held[Enum.KeyCode.RightControl] then throttle = math.max(0, throttle - dt * 0.25) end
    local pitch = (held[Enum.KeyCode.W] and 1 or 0) - (held[Enum.KeyCode.S] and 1 or 0)
    local roll = (held[Enum.KeyCode.D] and 1 or 0) - (held[Enum.KeyCode.A] and 1 or 0)
    accumulator += dt
    if accumulator >= 0.05 then
        accumulator = 0
        remote:FireServer({throttle = throttle, pitch = pitch, roll = roll})
    end
    label.Text = string.format("A320 PROTOTYPE / KJFK\nTHR %3d%%  SPD %3d studs/s\nALT %5d studs\nSHIFT/CTRL thrust | W/S pitch | A/D roll", plane:GetAttribute("Throttle") or 0, plane:GetAttribute("Speed") or 0, plane:GetAttribute("Altitude") or 0)
end)
