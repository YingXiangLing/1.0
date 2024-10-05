wait(0.3)

game.Players.LocalPlayer.MaximumSimulationRadius = 1000
game.Players.LocalPlayer.SimulationRadius = 15
local SetOldPosition 
SetOldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
game.Players.LocalPlayer.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime+2)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(SetOldPosition))
wait(2)
-- this server is dead 👺💀💀
	local function NetworkCheck(Part)
		return Part.ReceiveAge == 0
	end
local alreadyhere = {}
local starstar = false
repeat
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Part") or v :IsA("BasePart") then
			pcall(function()
				if v.Anchored == false and not table.find(alreadyhere,v) and not game.Players:GetPlayerFromCharacter(v.Parent) and not  game.Players:GetPlayerFromCharacter(v.Parent.Parent) then
					table.insert(alreadyhere,v)
					local eeeee = Instance.new("BodyPosition",v)
					eeeee.P = math.huge
					eeeee.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					v.CanCollide = false
					task.spawn(function()
						repeat
							pcall(function()
								eeeee.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,5,0).Position
								if NetworkCheck(v) == true then
								v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,5,0)
								end
								v.CanCollide = false
								v.AssemblyAngularVelocity = Vector3.new(0,0,0)
								v.AssemblyLinearVelocity = Vector3.new(0,0,0)
							end)
							task.wait()
						until v == nil
					end)
				end

			end)
		end
	end
	task.wait()
until game.Players.LocalPlayer == nil
