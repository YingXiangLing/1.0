-- HYPERFLING, probably one of the most overpowered types of flinging.

if game:IsLoaded() == false then
	game.Loaded:Wait()
end
task.wait(.1)
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local CanUse = true
local function Fling(TargetName)
	if Players:FindFirstChild(TargetName) then
		local oldpos;oldpos=plr.Character:FindFirstChild("HumanoidRootPart").CFrame
		local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
		HRP:FindFirstChildOfClass("Motor6D").Enabled = false
		local Target = Players:FindFirstChild(TargetName).Character
		workspace.CurrentCamera.CameraSubject = Target:FindFirstChild("Head")
		HRP.CFrame = Target:GetPivot()
		plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
		local otick;otick=tick()
		repeat
			HRP.Position = Target.HumanoidRootPart.Position+(Target:FindFirstChildOfClass("Humanoid").MoveDirection*11)
			HRP.Velocity = Vector3.new(99999,99999,99999)
			HRP.AssemblyAngularVelocity= Vector3.new(99999,99999,99999)
			task.wait()
		until Target:FindFirstChild("HumanoidRootPart").Velocity.Magnitude >= 99 or tick()-otick >= 3
		task.wait(.1)
		workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
		plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyAngularVelocity= Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity= Vector3.new(0,0,0)
		task.wait(.1)
		plr.Character:FindFirstChild("Head").Anchored = false
		plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyAngularVelocity= Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity= Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("Motor6D").Enabled = true
		CanUse = false
		otick=tick()
		plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyAngularVelocity= Vector3.new(0,0,0)
		plr.Character:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity= Vector3.new(0,0,0)
		plr.Character:PivotTo(oldpos)
		CanUse = true
		plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
	end
end
task.wait(.1)
workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
local FWFWelcome = Instance.new("Message",workspace)
FWFWelcome.Text = "HYPERFling Loaded, press x when you are ready, or you can press z for to fling anyone in a 20 stud radius. \n if none of those are for you, press c to fling the person you put your mouse on.";game:GetService("Debris"):AddItem(FWFWelcome,3)
game:GetService("UserInputService").InputBegan:Connect(function(R)
	if CanUse == true then
		if R.KeyCode == Enum.KeyCode.Z then
			local otick;otick=tick()
			local oldpos;oldpos=plr.Character:FindFirstChild("HumanoidRootPart").CFrame
			workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
			local FWFWelcome = Instance.new("Message",workspace)
			local Success = false
			FWFWelcome.Text = "Attempting to fling everyone in a 20 stud radius...";game:GetService("Debris"):AddItem(FWFWelcome,2)
			pcall(function()
				for _, v in ipairs(Players:GetPlayers()) do
					if v ~= plr then
						if workspace:FindFirstChild(v.Name) and  (oldpos.Position-v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 20  then
							Fling(v.Name)
							Success = true
							wait(0.2)
						end
					end
				end
			end)
		end
		if R.KeyCode == Enum.KeyCode.C then
			if plr:GetMouse().Target ~= nil then
				if  plr:GetMouse().Target.Parent:FindFirstChildOfClass("Humanoid") or  plr:GetMouse().Target.Parent.Parent:FindFirstChildOfClass("Humanoid") then
					local Target =  plr:GetMouse().Target.Parent
					if  plr:GetMouse().Target.Parent.Parent:FindFirstChildOfClass("Humanoid") then
						Target =  plr:GetMouse().Target.Parent.Parent
					end
					pcall(function()
						Fling(Target.Name)
					end)
				end
			end
		end
		if R.KeyCode == Enum.KeyCode.X then
			local otick;otick=tick()
			local oldpos;oldpos=plr.Character:FindFirstChild("HumanoidRootPart").CFrame
			workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
			local FWFWelcome = Instance.new("Message",workspace)
			FWFWelcome.Text = "Attempting to fling everyone...";game:GetService("Debris"):AddItem(FWFWelcome,2)
			pcall(function()
				for _, v in ipairs(Players:GetPlayers()) do
					if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart").Velocity.Magnitude <= 99 or  v ~= plr and v.Character and v.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Running then
						Fling(v.Name)
						wait(0.2)
					end
				end
			end)
		end
	end
end)
