local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")
local Players=game:GetService("Players")
local remote=RS:WaitForChild("FlightCommand")
local player=Players.LocalPlayer
local gui=Instance.new("ScreenGui")
gui.Name="FlightHUD" gui.ResetOnSpawn=false gui.Parent=player:WaitForChild("PlayerGui")
local label=Instance.new("TextLabel")
label.Size=UDim2.fromOffset(370,90) label.Position=UDim2.new(0,12,1,-105)
label.BackgroundTransparency=0.25 label.BackgroundColor3=Color3.fromRGB(14,23,35)
label.TextColor3=Color3.new(1,1,1) label.TextScaled=true
label.Text="A320 PROTOTYPE | Sit in PilotSeat\nSHIFT/CTRL thrust | W/S pitch | A/D roll"
label.Parent=gui
local keyMap={
 [Enum.KeyCode.W]={"pitch",-1},[Enum.KeyCode.S]={"pitch",1},
 [Enum.KeyCode.A]={"roll",-1},[Enum.KeyCode.D]={"roll",1},
 [Enum.KeyCode.LeftShift]={"throttle",1},[Enum.KeyCode.LeftControl]={"throttle",-1}
}
local function send(input,ending)
 local command=keyMap[input.KeyCode]
 if command then remote:FireServer(command[1],ending and 0 or command[2]) end
end
UIS.InputBegan:Connect(function(input,processed) if not processed then send(input,false) end end)
UIS.InputEnded:Connect(function(input) send(input,true) end)
