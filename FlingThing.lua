
wait(0.3)

		game.Players.LocalPlayer.MaximumSimulationRadius = 1000
		game.Players.LocalPlayer.SimulationRadius = 1000
local SetOldPosition 
SetOldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
		game.Players.LocalPlayer.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime+2)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(SetOldPosition))
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
				local e = Instance.new("Message",workspace)
				game.Debris:AddItem(e,2)
				e.Text = "Remember! you need to have the networkclient ownership of the part you are trying to teleport, try to touch it a few times or stand on it if it dosent work."
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

local targete = nil
local toole = Instance.new("Tool",game.Players.LocalPlayer.Backpack)
toole.Name = "Part Deleter"
toole.RequiresHandle = false
toole.CanBeDropped = false
toole.ToolTip = "Delete unanchored parts"
toole.Activated:Connect(function()
	if game.Players.LocalPlayer:GetMouse().Target ~= nil then
		if targete == nil then
			if not game.Players.LocalPlayer:GetMouse().Target.Parent:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer:GetMouse().Target.Anchored == false then
				local e = Instance.new("Message",workspace)
				game.Debris:AddItem(e,2)
				e.Text = "Remember! you need to have the networkclient ownership of the part you are trying to delete, try to touch it a few times or stand on it if it dosent work."
				local sb = Instance.new('SelectionBox',game.Players.LocalPlayer:GetMouse().Target)
				sb.Adornee = game.Players.LocalPlayer:GetMouse().Target
				sb.Name = "TeleportingBox"
				targete = game.Players.LocalPlayer:GetMouse().Target
				pcall(function()
					local oldp
					local oldm 
					oldm = game.Players.LocalPlayer:GetMouse().Hit.Position
					oldp = game.Players.LocalPlayer.Character:GetPivot()
					task.wait()
					game:GetService("RunService").Heartbeat:Wait()
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(targete.Position+Vector3.new(0,-1,0)))
					wait(0.6)
					game.Players.LocalPlayer.Character:PivotTo(oldp)
					targete.Position =  Vector3.new(0,-70,0)
					targete:FindFirstChild("TeleportingBox"):Destroy()
					wait(0.1)
					targete = nil
				end)
			end
			end
		end
		end)
