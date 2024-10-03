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
task.spawn(function()
	while game:GetService("RunService").Heartbeat:Wait() do
		if stop == true then continue end
		proxy:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
		game:GetService("Players").LocalPlayer.Character = proxy
		char:PivotTo(proxy:GetPivot())
		for _, v in ipairs(char:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
			v:Stop()
		end
		if proxy.Parent ~= workspace then
			proxy.Parent = workspace
		end
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
				v.Transparency = 1
				v.CanCollide = false
			end)
		end
	end
end)
for _, v in ipairs(char:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
	v:Stop()
end
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
