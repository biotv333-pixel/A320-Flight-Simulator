-- Prototype only: server-owned simplified flight dynamics, not certified A320 physics.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("FlightConfig"))

local remote = Instance.new("RemoteEvent")
remote.Name = "FlightInput"
remote.Parent = ReplicatedStorage

local airport = Instance.new("Folder")
airport.Name = "KJFK_Prototype"
airport.Parent = workspace
local runway = Instance.new("Part")
runway.Name = "PrototypeRunway"
runway.Size = Vector3.new(180, 2, 3000)
runway.Position = Vector3.new(0, -1, 0)
runway.Anchored = true
runway.Color = Color3.fromRGB(48, 48, 52)
runway.Material = Enum.Material.Asphalt
runway.Parent = airport

local plane = Instance.new("Model")
plane.Name = "A320_Prototype"
plane.Parent = workspace
local root = Instance.new("Part")
root.Name = "Fuselage"
root.Size = Vector3.new(12, 12, 100)
root.CFrame = CFrame.new(0, 14, -950)
root.Color = Color3.fromRGB(230, 233, 238)
root.Anchored = true
root.CanCollide = false
root.Parent = plane
plane.PrimaryPart = root

local function addPart(name, size, offset)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.Color = root.Color
    p.Anchored = true
    p.CanCollide = false
    p.CFrame = root.CFrame * CFrame.new(offset)
    p.Parent = plane
end
addPart("Wings", Vector3.new(110, 2, 18), Vector3.new(0, 0, 4))
addPart("Tailplane", Vector3.new(40, 2, 10), Vector3.new(0, 2, 41))
addPart("VerticalTail", Vector3.new(3, 18, 13), Vector3.new(0, 12, 42))

local seat = Instance.new("VehicleSeat")
seat.Name = "PilotSeat"
seat.Size = Vector3.new(4, 1, 4)
seat.CFrame = root.CFrame * CFrame.new(0, 7, -30)
seat.Anchored = true
seat.Parent = plane

local input = {throttle = 0, pitch = 0, roll = 0}
local speed = 0
local pitch = 0
local roll = 0
local position = root.Position

remote.OnServerEvent:Connect(function(player, payload)
    if typeof(payload) ~= "table" then return end
    local humanoid = seat.Occupant
    if not humanoid or Players:GetPlayerFromCharacter(humanoid.Parent) ~= player then return end
    if typeof(payload.throttle) ~= "number" or typeof(payload.pitch) ~= "number" or typeof(payload.roll) ~= "number" then return end
    if payload.throttle ~= payload.throttle or payload.pitch ~= payload.pitch or payload.roll ~= payload.roll then return end
    input.throttle = math.clamp(payload.throttle, 0, 1)
    input.pitch = math.clamp(payload.pitch, -1, 1)
    input.roll = math.clamp(payload.roll, -1, 1)
end)

RunService.Heartbeat:Connect(function(dt)
    dt = math.min(dt, 0.05)
    speed = math.clamp(speed + (input.throttle * Config.Acceleration - 9 - speed * 0.045) * dt, 0, Config.MaxSpeed)
    pitch = math.clamp(pitch + input.pitch * Config.PitchRate * dt, math.rad(-20), math.rad(25))
    roll = math.clamp(roll + input.roll * Config.RollRate * dt, math.rad(-60), math.rad(60))
    local attitude = CFrame.Angles(0, 0, 0) * CFrame.Angles(pitch, 0, -roll)
    local forward = attitude.LookVector
    local lift = math.max(0, speed - Config.LiftStartSpeed) * 0.09 + math.sin(pitch) * speed * 0.4
    local climb = lift - 7
    if position.Y <= 14 and climb < 0 then climb = 0 end
    position += (forward * speed + Vector3.new(0, climb, 0)) * dt
    position = Vector3.new(position.X, math.max(14, position.Y), position.Z)
    plane:PivotTo(CFrame.new(position) * attitude)
    plane:SetAttribute("Speed", math.floor(speed))
    plane:SetAttribute("Altitude", math.floor(position.Y))
    plane:SetAttribute("Throttle", math.floor(input.throttle * 100))
end)
