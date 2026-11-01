local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    print("[A320] Player joined:", player.Name)
end)
