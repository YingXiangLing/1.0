if game:IsLoaded() == false then
	game.Loaded:Wait()
end
task.wait(.1)
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local CanUse = true
local function Fling(TargetName)
	if Players:FindFirstChild(TargetName) then
		local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
		local Target = Players:FindFirstChild(TargetName).Character
		workspace.CurrentCamera.CameraSubject = Target:FindFirstChild("Head")
		HRP.CFrame = Target:GetPivot()
		plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
		local ANGLR = Instance.new("BodyAngularVelocity",HRP)
		local otick;otick=tick()
		repeat
			if Target:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Seated then
				HRP.Position = Target.HumanoidRootPart.Position+(Target:FindFirstChildOfClass("Humanoid").MoveDirection*11)
			else
				HRP.Position = Target.HumanoidRootPart.CFrame*CFrame.new(0,-2,-6)
			end
			ANGLR.P += 5255
			ANGLR.MaxTorque = Vector3.new(5255,5255,5255)
			HRP.Velocity = Vector3.new(100,100,100)
			ANGLR.AngularVelocity = Vector3.new(5255,5255,5255)
			game:GetService("RunService").RenderStepped:Wait()
			task.wait()
		until Target:FindFirstChild("HumanoidRootPart").Velocity.Magnitude >= 99 or tick()-otick >= 3
		workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
	end
end
task.wait(.1)
workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
local FWFWelcome = Instance.new("Message",workspace)
FWFWelcome.Text = "HYPERFling Loaded, press x when you are ready, or you can press z for to fling anyone in a 20 stud radius.";game:GetService("Debris"):AddItem(FWFWelcome,2)
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
			wait(0.2)
			if Success == true then
				plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity"):Destroy()
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
				repeat
					task.wait()
					plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
					plr.Character:FindFirstChild("HumanoidRootPart").AssemblyAngularVelocity= Vector3.new(0,0,0)
					plr.Character:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity= Vector3.new(0,0,0)
					plr.Character:PivotTo(oldpos)
				until tick()-otick >= 0.2
				CanUse = true
				plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
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
			wait(0.2)
			pcall(function()
				plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity"):Destroy()
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
				repeat
					task.wait()
					plr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
					plr.Character:FindFirstChild("HumanoidRootPart").AssemblyAngularVelocity= Vector3.new(0,0,0)
					plr.Character:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity= Vector3.new(0,0,0)
					plr.Character:PivotTo(oldpos)
				until tick()-otick >= 0.2
				CanUse = true
				plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
	end
end)
