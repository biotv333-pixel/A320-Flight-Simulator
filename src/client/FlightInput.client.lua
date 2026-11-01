local UIS = game:GetService("UserInputService")
local config = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("FlightConfig"))
local thrust, pitch, roll = 0, 0, 0
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    local key = input.KeyCode
    if key == Enum.KeyCode.LeftShift then thrust = math.min(config.MaxThrust, thrust + config.ThrustStep)
    elseif key == Enum.KeyCode.LeftControl then thrust = math.max(0, thrust - config.ThrustStep)
    elseif key == Enum.KeyCode.W then pitch = -1
    elseif key == Enum.KeyCode.S then pitch = 1
    elseif key == Enum.KeyCode.A then roll = -1
    elseif key == Enum.KeyCode.D then roll = 1 end
    print("Flight input", thrust, pitch, roll)
end)
UIS.InputEnded:Connect(function(input)
    local key = input.KeyCode
    if key == Enum.KeyCode.W or key == Enum.KeyCode.S then pitch = 0 end
    if key == Enum.KeyCode.A or key == Enum.KeyCode.D then roll = 0 end
end)
