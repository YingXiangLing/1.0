
wait(0.3)
local target = nil
local tool = Instance.new("Tool",game.Players.LocalPlayer.Backpack)
tool.Name = "Part Teleporter"
tool.RequiresHandle = false
tool.CanBeDropped = false
tool.ToolTip = "Teleport unanchored parts"
tool.Activated:Connect(function()
	if game.Players.LocalPlayer:GetMouse().Target ~= nil then
		if target == nil then
			if not game.Players.LocalPlayer:GetMouse().Target.Parent:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer:GetMouse().Target.Anchored == false then
				local sb = Instance.new('SelectionBox',game.Players.LocalPlayer:GetMouse().Target)
				sb.Adornee = game.Players.LocalPlayer:GetMouse().Target
				sb.Name = "TeleportingBox"
				target = game.Players.LocalPlayer:GetMouse().Target
			end
		else
			pcall(function()
				local oldp
				local oldm 
					oldm = game.Players.LocalPlayer:GetMouse().Hit.Position
				oldp = game.Players.LocalPlayer.Character:GetPivot()
				task.wait()
					game:GetService("RunService").Heartbeat:Wait()
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(target.Position+Vector3.new(0,-1,0)))
					firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChild("Head"),target,0)
					firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChild("Head"),target,1)
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):MoveTo(Vector3.new(math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000)))
				
				wait(0.6)
				game.Players.LocalPlayer.Character:PivotTo(oldp)
				target.Position =  oldm
				target:FindFirstChild("TeleportingBox"):Destroy()
				wait(0.1)
				target = nil
			end)
		end
		end
end)
