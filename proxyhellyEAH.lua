if game:IsLoaded() == false then
	game.Loaded:Wait()
	wait(1)
else
	wait(1)
end
local char;char = game:GetService("Players").LocalPlayer.Character
local owner = game:GetService("Players").LocalPlayer
local animtables = {}
char.Archivable = true
local proxy = char:Clone()
local oldposes = {}
owner.Character = proxy
proxy.Parent = workspace
local stop = false
local function displayHealth()
	pcall(function()
		if char:FindFirstChild("Head") and char:FindFirstChild("Head"):FindFirstChild("HealthProxyCharEquals") then
			char:FindFirstChild("Head"):FindFirstChild("HealthProxyCharEquals"):Destroy()
		end
		if proxy:FindFirstChild("Head") and proxy:FindFirstChild("Head"):FindFirstChild("HealthProxyCharEquals") then
			proxy:FindFirstChild("Head"):FindFirstChild("HealthProxyCharEquals"):Destroy()
		end
		local billboardHealth = Instance.new("BillboardGui",proxy:FindFirstChild("Head"))
		billboardHealth.Name = "HealthProxyCharEquals"
		billboardHealth.StudsOffsetWorldSpace = Vector3.new(0,3.2,0)
		billboardHealth.Size = UDim2.new(6,0,1.7,0)
		local txb = Instance.new("TextLabel",billboardHealth)
		txb.BackgroundTransparency = 1
		txb.TextColor3 = Color3.new(1,1,1)
		txb.TextScaled = true
		txb.Size = UDim2.new(1,0,1,0)
		if pcall(function()txb.Text = "ProxyHealth: "..char:FindFirstChildOfClass("Humanoid").Health;end) ~= true then
			txb.Text = "ProxyHealth: 0 (Reviving...)"
		end
		game:GetService("Debris"):AddItem(billboardHealth,0.01)
	end)
end
task.spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		if stop == true then return end
		pcall(game.Destroy,billboardHealth)
		displayHealth()
		for _, v in ipairs(char.Humanoid:GetPlayingAnimationTracks()) do
		v:Stop()
		end
		proxy:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
		game:GetService("Players").LocalPlayer.Character = proxy
		char:PivotTo(proxy:GetPivot())
		if proxy.Parent ~= workspace then
			proxy.Parent = workspace
		end
		pcall(function()
			proxy:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
			proxy:FindFirstChildOfClass("Humanoid").PlatformStand = false
			proxy:FindFirstChildOfClass("Humanoid").Sit = false
			proxy:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Physics,false)
			if proxy:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Physics then
				proxy:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			end
		end)
		for _, v in ipairs(proxy:GetDescendants()) do
			pcall(function()
				if v.Velocity.Magnitude >= 250 then
					v.Velocity = Vector3.zero
					v.AssemblyAngularVelocity = Vector3.zero
					v.Anchored = true
					v.CFrame = oldposes[v.Name]
					v.Velocity = Vector3.zero
					v.AssemblyAngularVelocity = Vector3.zero
					task.delay(0.12,function()
						v.Anchored = false
						v.Velocity = Vector3.zero
						v.AssemblyAngularVelocity = Vector3.zero
						v.CFrame = oldposes[v.Name]
					end)
				else
					oldposes[v.Name] = v.CFrame
				end
				v.CanCollide = false
			end)
		end
		for _, v in ipairs(char:GetDescendants()) do
			pcall(function()
				v.Velocity = Vector3.new(5000,5000,5000)
				v.Transparency = 0.6
				v.CanCollide = false
			end)
		end
	end)
end)
game:GetService("Players").LocalPlayer.Character = proxy
char:FindFirstChildOfClass("Humanoid").Died:Once(function()
	stop = true
	task.delay(game:GetService("Players").RespawnTime+0.5,function()
		workspace.CurrentCamera.CameraSubject = proxy:FindFirstChildOfClass("Humanoid")
		stop = false
	end)
end)
owner.CharacterAdded:Connect(function(m)
	if stop == true then
		task.wait(0.23)
		char = m
		char:FindFirstChildOfClass("Humanoid").Died:Once(function()
			stop = true
			task.delay(game:GetService("Players").RespawnTime+0.5,function()
				workspace.CurrentCamera.CameraSubject = proxy:FindFirstChildOfClass("Humanoid")
				stop = false
			end)
		end)
	end
end)
