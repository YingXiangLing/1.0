wait(0.3)

game.Players.LocalPlayer.MaximumSimulationRadius = 1000
game.Players.LocalPlayer.SimulationRadius = 1000
local SetOldPosition 
SetOldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
game.Players.LocalPlayer.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime+2)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(SetOldPosition))
wait(2)
-- this server is dead 👺💀💀

for _, v in ipairs(workspace:GetDescendants()) do
	if v:IsA("Part") or v :IsA("BasePart") then
		if v.Anchored == false then
			game.Players.LocalPlayer.Character:PivotTo(v.CFrame)
			task.wait(.11)
			eeeee = Instance.new("BodyPosition",v)
			eeeee.P = 99999999999999999999999999
			eeeee.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			task.spawn(function()
			repeat
			eeeee.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				task.wait()
		until v == nil
				end)
		end
	end
end
