local oldcharpos;oldcharpos=game:GetService("Players").LocalPlayer.Character:GetPivot()
game:GetService("Players").LocalPlayer.SimulationRadius = 1000
game:GetService("Players").LocalPlayer.Character:BreakJoints()
wait(game:GetService("Players").RespawnTime+0.5)
game:GetService("Players").LocalPlayer.SimulationRadius = 1000
game:GetService("Players").LocalPlayer.Character:PivotTo(oldcharpos)
local function PartFling(target)
	local function NetworkCheck(Part)
		return Part.ReceiveAge == 0
	end
	local function getclosestpart()
		local bestpart
		local biggestmagnitude 
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
				if v.Anchored == false and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent.Parent:FindFirstChildOfClass("Humanoid") and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
					if biggestmagnitude == nil or biggestmagnitude ~= nil and (game.Players.LocalPlayer.Character.Head.Position-v.Position).Magnitude < biggestmagnitude then
						biggestmagnitude = (game.Players.LocalPlayer.Character.Head.Position-v.Position).Magnitude
						bestpart = v
					end
				end
			end
		end
		return bestpart
	end
	local Part = getclosestpart()
	if Part == nil then return end
	Part.Archivable = true
	local PClone = Part:Clone()
	PClone.Parent = workspace
	PClone.Anchored = true
	local oldtr=Part.Transparency
	Part.Transparency = 1
	PClone.CanCollide = false
	PClone.Transparency = 0
	Instance.new("Highlight",PClone).OutlineTransparency = 1
	local oldcf=game:GetService("Players").LocalPlayer.Character:GetPivot()
	repeat
		game:GetService("Players").LocalPlayer.SimulationRadius = 1000
		game:GetService("Players").LocalPlayer.Character:PivotTo(Part.CFrame)
		game:GetService("RunService").RenderStepped:Wait()
	until NetworkCheck(Part) == true
	game:GetService("Players").LocalPlayer.Character:PivotTo(oldcf)
	game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
	Part.Transparency = oldtr
	pcall(game.Destroy,PClone)
	Part.Velocity = Vector3.new(0,5000,0)
	local weld = Instance.new("Weld",Part)
	weld.Part0 = Part
	weld.Part1 = target.Character.HumanoidRootPart
	local conexttion
	local oldpos=Part.Position
	conexttion = game:GetService('RunService').Heartbeat:Connect(function()
		if NetworkCheck(Part) ~= true or weld.Part1.Velocity.Magnitude >= 100 then
			conexttion:Disconnect()
			pcall(function()
				Part.Position = oldpos
				Part.Velocity = Vector3.zero
			end)
		else
			game:GetService("Players").LocalPlayer.SimulationRadius = 1000
			Part.Velocity = Vector3.new(0,500*5,0)
			Part.CFrame = weld.Part1.CFrame
		end
	end)
	pcall(game.Destroy,weld)
end
game:GetService("UserInputService").InputBegan:Connect(function(i,g)
	if g == true then return end
	if i.KeyCode ~= Enum.KeyCode.G then return end
	if game:GetService("Players").LocalPlayer:GetMouse().Target.Parent:FindFirstChildOfClass("Humanoid") then
		PartFling(game:GetService("Players"):GetPlayerFromCharacter(game:GetService("Players").LocalPlayer:GetMouse().Target.Parent))
	elseif game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Parent:FindFirstChildOfClass("Humanoid") then
		PartFling(game:GetService("Players"):GetPlayerFromCharacter(game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Parent))
	end
end)
