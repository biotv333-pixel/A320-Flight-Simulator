-- Server-authoritative multiplayer prototype. Not a certified A320 simulation.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local remote = Instance.new("RemoteEvent")
remote.Name = "FlightCommand"
remote.Parent = RS
local world = Instance.new("Folder")
world.Name = "KJFKPrototype"
world.Parent = workspace
local function part(name,size,cf,color,parent)
 local p=Instance.new("Part")
 p.Name=name p.Size=size p.CFrame=cf p.Anchored=true p.Color=color p.Parent=parent or world
 return p
end
part("Ground",Vector3.new(5000,2,5000),CFrame.new(0,-2,0),Color3.fromRGB(63,100,65))
local runways={
 {"04L_22R",Vector3.new(-400,0,0),-32},
 {"04R_22L",Vector3.new(400,0,0),-32},
 {"13L_31R",Vector3.new(0,0,-550),45},
 {"13R_31L",Vector3.new(0,0,550),45},
}
for _,r in ipairs(runways) do
 local cf=CFrame.new(r[2])*CFrame.Angles(0,math.rad(r[3]),0)
 part("Runway_"..r[1],Vector3.new(80,0.4,1900),cf,Color3.fromRGB(39,42,45))
 for i=-8,8 do part("Centerline",Vector3.new(2,0.5,35),cf*CFrame.new(0,0.3,i*100),Color3.fromRGB(240,240,230)) end
end
for i=1,5 do
 part("Terminal_"..i,Vector3.new(140,40,75),CFrame.new(-600+i*200,20,1000),Color3.fromRGB(170,180,190))
end
local aircraft=Instance.new("Model")
aircraft.Name="A320_Prototype"
aircraft.Parent=workspace
local fuselage=part("Fuselage",Vector3.new(12,12,90),CFrame.new(0,30,0),Color3.fromRGB(235,238,245),aircraft)
part("Wings",Vector3.new(110,2,18),CFrame.new(0,30,5),Color3.fromRGB(205,210,218),aircraft)
part("Tailplane",Vector3.new(42,2,12),CFrame.new(0,33,38),Color3.fromRGB(205,210,218),aircraft)
part("VerticalTail",Vector3.new(3,24,13),CFrame.new(0,43,39),Color3.fromRGB(25,75,160),aircraft)
local seat=Instance.new("Seat")
seat.Name="PilotSeat" seat.Size=Vector3.new(5,2,5) seat.Anchored=true seat.CFrame=CFrame.new(0,34,-26)
seat.Parent=aircraft
aircraft.PrimaryPart=fuselage
local pose=aircraft:GetPivot()
local spawn=Instance.new("SpawnLocation")
spawn.Name="PilotSpawn" spawn.Size=Vector3.new(12,1,12)
spawn.Anchored=true spawn.Neutral=true spawn.CFrame=CFrame.new(0,1,-45)
spawn.Parent=workspace
local speed,throttle,pitch,roll=0,0,0,0
local pilot=nil
local lastInput={}
remote.OnServerEvent:Connect(function(player,cmd,value)
 if player~=pilot then return end
 local now=os.clock()
 if now-(lastInput[player] or 0)<0.025 then return end
 lastInput[player]=now
 if typeof(value)~="number" or value~=value then return end
 value=math.clamp(value,-1,1)
 if cmd=="throttle" then throttle=math.clamp(throttle+value*0.04,0,1)
 elseif cmd=="pitch" then pitch=value
 elseif cmd=="roll" then roll=value end
end)
seat:GetPropertyChangedSignal("Occupant"):Connect(function()
 local humanoid=seat.Occupant
 pilot=humanoid and Players:GetPlayerFromCharacter(humanoid.Parent) or nil
 if not pilot then pitch=0 roll=0 throttle=0 end
end)
RunService.Heartbeat:Connect(function(dt)
 dt=math.min(dt,0.05)
 speed=math.max(0,speed+(throttle*55-speed*0.04)*dt)
 local airborne=speed>38 or pose.Position.Y>32
 local lift=airborne and (speed*0.035-1.3) or 0
 local dy=math.clamp(lift-0.7,-1,2)*dt*12
 local rotation=CFrame.Angles(pitch*dt*0.28,0,-roll*dt*0.45)
 local nextPose=pose*rotation*CFrame.new(0,dy,-speed*dt)
 if nextPose.Position.Y<8 then
  nextPose=CFrame.new(nextPose.Position.X,8,nextPose.Position.Z)*nextPose.Rotation
  speed=speed*0.98
 end
 pose=nextPose
 aircraft:PivotTo(pose)
end)
