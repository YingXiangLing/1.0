
if rawequal(game:IsLoaded(),false) then
	game.Loaded:Wait()
end
wait(0.5)
if setfpscap then
else
	setfpscap = function()

	end
end
if setfps then
else
	setfps = function()

	end
end
if getgenv then
else
	warn("not usable | getgenv")
	getgenv = getfenv
end
if fireproximityprompt then
else
	fireproximityprompt = function()

	end
end
if firetouchinterest then
else
	firetouchinterest = function()

	end
end
local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local cam = workspace.CurrentCamera
wait(0.1)
local oldselectionbox = nil
local gui = nil
task.spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Delete") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Delete"):FindFirstChild("HarkedyesokgoodTerminal") then
			pcall(function()
				if oldselectionbox and oldselectionbox:IsDescendantOf(game) then
					oldselectionbox.Adornee = game.Players.LocalPlayer:GetMouse().Target
					oldselectionbox.Parent = oldselectionbox.Adornee
					if  gui == nil then
						pcall(game.Destroy,gui)
						gui = Instance.new("BillboardGui",oldselectionbox.Adornee)::BillboardGui
						gui.StudsOffsetWorldSpace = Vector3.new(0,3,0)
						gui.Size = UDim2.new(5,0,2,0)
						local txtlabel = Instance.new("TextLabel",gui)
						txtlabel.Visible = true
						txtlabel.Size = UDim2.new(1,0,1,0)
						txtlabel.BackgroundTransparency = 1
						gui.AlwaysOnTop = true
						txtlabel.TextScaled = true
						txtlabel.Text = oldselectionbox.Adornee.Name.." ("..oldselectionbox.Adornee.ClassName..")"
					else

						gui.Parent = oldselectionbox.Adornee
						gui.TextLabel.Text = oldselectionbox.Adornee.Name.." ("..oldselectionbox.Adornee.ClassName..")"
					end
				else
					pcall(game.Destroy,oldselectionbox)
					oldselectionbox = Instance.new("SelectionBox",game.Players.LocalPlayer:GetMouse().Target)
					oldselectionbox.Adornee = game.Players.LocalPlayer:GetMouse().Target
					oldselectionbox.Parent = oldselectionbox.Adornee
					if  gui == nil then
						pcall(game.Destroy,gui)
						gui = Instance.new("BillboardGui",oldselectionbox.Adornee)::BillboardGui
						gui.StudsOffsetWorldSpace = Vector3.new(0,3,0)
						gui.Size = UDim2.new(5,0,2,0)
						local txtlabel = Instance.new("TextLabel",gui)
						txtlabel.Visible = true
						txtlabel.Size = UDim2.new(1,0,1,0)
						txtlabel.BackgroundTransparency = 1
						gui.AlwaysOnTop = true
						txtlabel.TextScaled = true
						txtlabel.Text = oldselectionbox.Adornee.Name.." ("..oldselectionbox.Adornee.ClassName..")"
					else
						gui.Parent = oldselectionbox.Adornee
						gui.TextLabel.Text = oldselectionbox.Adornee.Name.." ("..oldselectionbox.Adornee.ClassName..")"
					end
				end
			end)
		else
			if oldselectionbox then
				pcall(game.Destroy,gui)
				pcall(game.Destroy,oldselectionbox)
				oldselectionbox = nil
				gui = nil
			end
		end
	end)
end)
function checkremotes()
	local found = false
	local namelist = {
		"delete",
		"remove",
		"clear",
		"clean",
		"destroy",
		"vehicle",
		"car",
		"paint",
		"despawn",
		"bullet", "bala", "shoot", "shot", "fire", "segway", "handless", "sword", "attack", "deletar", "apagar" -- "borrowed" from quirkycmd
	}
	local remoteexists = {
		game.ReplicatedFirst,
		game.ReplicatedStorage,
		game.Lighting,
		game.Workspace,
		game.Players
	}
	task.spawn(function()
		for _, vservice in ipairs(remoteexists) do
			for _, v in ipairs(vservice:GetDescendants()) do
				if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
					for _, name in ipairs(namelist) do
						if v.Name:lower():find(name) then
							pcall(function()
								found = true
							end)
							pcall(function()
								found = true
							end)
						else
							continue
						end
					end
				else
					continue
				end
			end
		end
	end)
	return found
end
function RemoteDestroy(instance)
	local namelist = {
		"delete",
		"remove",
		"clear",
		"clean",
		"destroy",
		"vehicle",
		"car",
		"paint",
		"despawn",
		"bullet", "bala", "shoot", "shot", "fire", "segway", "handless", "sword", "attack", "deletar", "apagar" -- "borrowed" from quirkycmd
	}
	local remoteexists = {
		game.ReplicatedFirst,
		game.ReplicatedStorage,
		game.Lighting,
		game.Workspace,
		game.Players
	}
	task.spawn(function()
		pcall(function()
			game:GetService("ReplicatedStorage").DeleteCar:FireServer(instance)
		end)
		for _, vservice in ipairs(remoteexists) do
			for _, v in ipairs(vservice:GetDescendants()) do
				if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
					for _, name in ipairs(namelist) do
						if v.Name:lower():find(name) then
							pcall(function()
								v:FireServer(instance)
							end)
							pcall(function()
								v:InvokeServer(instance)
							end)
						else
							continue
						end
					end
				else
					continue
				end
			end
		end
	end)
end
local admins = {

}
antiflinging = true
local p = game.Players.LocalPlayer
local pc = p.Character
p.CharacterAdded:Connect(function(c)
	pc = c
end)
local function safestring(g)
	local EX,N=pcall(function()
		tostring(g)
	end)
	if EX == true then
		return tostring(g)
	end
end
cmd = {
	add = function(n,g,t)
		table.insert(cmd["list"],{["function"] = t,["description"]=g,["name"]=n})
	end,
	edit = function(n,alias)
		for _, v in pairs(cmd["list"]) do
			if table.find(v.name,n)  then
				table.insert(v.name,alias:lower())
			end
		end
	end,
	list = {}

}
FLYING = false
TPFLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
local velocityHandlerName = randomString()
local gyroHandlerName = randomString()
local mfly1
local mfly2

local unmobilefly = function(speaker)
	local function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	pcall(function()
		FLYING = false
		local root = getRoot(speaker.Character)
		root:FindFirstChild(velocityHandlerName):Destroy()
		root:FindFirstChild(gyroHandlerName):Destroy()
		speaker.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
		mfly1:Disconnect()
		mfly2:Disconnect()
	end)
end

local mobilefly = function(speaker, vfly)
	local function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	unmobilefly(speaker)
	FLYING = true

	local root = getRoot(speaker.Character)
	local camera = workspace.CurrentCamera
	local v3none = Vector3.new()
	local v3zero = Vector3.new(0, 0, 0)
	local v3inf = Vector3.new(9e9, 9e9, 9e9)

	local controlModule = require(speaker.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	local bv = Instance.new("BodyVelocity")
	bv.Name = velocityHandlerName
	bv.Parent = root
	bv.MaxForce = v3zero
	bv.Velocity = v3zero

	local bg = Instance.new("BodyGyro")
	bg.Name = gyroHandlerName
	bg.Parent = root
	bg.MaxTorque = v3inf
	bg.P = 1000
	bg.D = 50

	mfly1 = speaker.CharacterAdded:Connect(function()
		local bv = Instance.new("BodyVelocity")
		bv.Name = velocityHandlerName
		bv.Parent = root
		bv.MaxForce = v3zero
		bv.Velocity = v3zero

		local bg = Instance.new("BodyGyro")
		bg.Name = gyroHandlerName
		bg.Parent = root
		bg.MaxTorque = v3inf
		bg.P = 1000
		bg.D = 50
	end)

	mfly2 = RunService.RenderStepped:Connect(function()
		root = getRoot(speaker.Character)
		camera = workspace.CurrentCamera
		if speaker.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
			local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			local VelocityHandler = root:FindFirstChild(velocityHandlerName)
			local GyroHandler = root:FindFirstChild(gyroHandlerName)

			VelocityHandler.MaxForce = v3inf
			GyroHandler.MaxTorque = v3inf
			if not vfly then humanoid.PlatformStand = true end
			GyroHandler.CFrame = camera.CoordinateFrame
			VelocityHandler.Velocity = v3none

			local direction = controlModule:GetMoveVector()
			if direction.X > 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.X < 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z > 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z < 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if TPFLYING == true then
				pc:MoveTo(VelocityHandler.Velocity)
			end
		end
	end)
end

function sFLY(vfly)
	local function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until Players.LocalPlayer:GetMouse()
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				if TPFLYING == true then
					pc:MoveTo(BV.velocity)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = Players.LocalPlayer:GetMouse().KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end
getPlr = function(Name)
	local Players = game.Players
	if Name:lower() == "random" then
		return Players:GetPlayers()[math.random(#Players:GetPlayers())]
	else
		if Name:lower() == "@view" then
			Name = Players:GetPlayerFromCharacter(workspace.CurrentCamera.CameraSubject.Parent)
			return Name
		else
			Name = Name:lower():gsub("%s", "")
			for _, x in next, Players:GetPlayers() do
				if x.Name:lower():match(Name) then
					return x
				elseif x.DisplayName:lower():match("^" .. Name) then
					return x
				end
			end
		end
	end
end
--function execute(n,...)
--	if rawequal(cmd["list"][n:lower()],nil) ~= true then
--		cmd["list"][n:lower()]["function"](...)
--	else
--		notify("No command found with the name of "..n..".","TERMINAL")
--	end
--end
function notify(t,n,i)
	if rawequal(i,nil) then
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Text = t,
			Title = n,
			Duration = 5;
		})
	else
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Text = t,
			Title = n,
			Duration = tonumber(i);
		})
	end
end
hiddenfling = false
Noclip = nil
locks = {}
if setfpscap then
else
	setfpscap = function()
		warn("not usable | setfpscap ")
	end
end
if setfps then
else
	setfps = function()
		warn("not usable | setfps")
	end
end
if getgenv then
else
	warn("not usable | getgenv")
	getgenv = getfenv
end
if firetouchinterest then
else
	firetouchinterest = function()
		warn("not usable | firetouchinterest")
	end
end
lock = function(instance, par)
	locks[instance] = true
	instance.Parent = par or instance.Parent
	instance.Name = "RightGrip"
end
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://68433924"
local animationTrack:AnimationTrack = humanoid:LoadAnimation(animation)

local isPlaying = false
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local weightValue = Instance.new("NumberValue")
weightValue.Value = 0

weightValue.Changed:Connect(function(newValue)
	animationTrack:AdjustWeight(newValue)
end)
local remotebans = {}
task.spawn(function()
	game.Players.PlayerAdded:Connect(function(p)
		task.spawn(function()
			task.wait(1)
			if p:IsDescendantOf(game) and table.find(remotebans,p.UserId) then
				RemoteDestroy(p)
			end
		end)
	end)
end)
cmd.add({"partcontrol","pcontrol"},"networkownership goes brr",function()
	notify("Currently fetching all parts, this might reset your character.","TERMINAL")
	local RunService = game:GetService("RunService")
	local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local cam = workspace.CurrentCamera
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
	game.Players.LocalPlayer.SimulationRadius = 1000
	wait(game.Players.RespawnTime + 0.5)
	game.Players.LocalPlayer.SimulationRadius = 1000
	game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = h
	workspace.CurrentCamera = cam
	task.wait(0.2)
	local function NetworkCheck(Part)
		return Part.ReceiveAge == 0
	end
	local foundpart = nil
	for _, v in ipairs(workspace:GetDescendants()) do
		pcall(function()
			if not v.Anchored and #v:GetConnectedParts() <= 1 and NetworkCheck(v) == true then
				foundpart = v
			end
		end)
	end
	if foundpart then
		pc:WaitForChild("Animate"):Destroy()
		notify("Controllable part was found, rejoin to end this command.","TERMINAL")
		foundpart.CFrame = pc:GetPivot()
		if NetworkCheck(foundpart) == true then
			pcall(function()
				task.spawn(function()
					while task.wait(3) do
						foundpart.Velocity = Vector3.new(14.46262424,14.46262424,14.46262424)+Vector3.new(0,math.cos(tick()*10)/100,0)
						pc:PivotTo(foundpart.CFrame)
						workspace.CurrentCamera.CameraSubject = pc:FindFirstChildOfClass("Humanoid")
					end
				end)
			end)
			RunService.Heartbeat:Connect(function()
				local InAttack = false
				pcall(function()
					pcall(function()
						for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
							if v ~= game.Players.LocalPlayer then
								local part = Instance.new("Part",workspace)
								part.Anchored = true
								part.Size = Vector3.new(v.SimulationRadius,v.SimulationRadius,v.SimulationRadius)
								part.Color = Color3.new(1,0,0)
								part.Transparency = 1
								part.CanCollide = false
								part.CastShadow = false
								part.CFrame = v.Character:GetPivot()
								game:GetService("Debris"):AddItem(part,0.1)
								if (pc.Head.Position-v.Character.Head.Position).Magnitude <= 18 then
									InAttack = true
								end
								local part = Instance.new("Part",workspace)
								part.Anchored = true
								part.Size = Vector3.new(27,27,27)
								part.Color = Color3.new(0,0,1)
								part.Transparency = 1
								part.CanCollide = false
								part.CastShadow = false
								part.CFrame = v.Character:GetPivot()
								game:GetService("Debris"):AddItem(part,0.05)
							end
						end
					end)
					workspace.Gravity = 0
					workspace.FallenPartsDestroyHeight = -9999999
					foundpart.Velocity = Vector3.zero
					foundpart.CanCollide = false
					local oldpos = foundpart.Position
					foundpart.CFrame = CFrame.lookAt(oldpos,workspace.CurrentCamera.CFrame*CFrame.new(0,0,-250).Position)
					if NetworkCheck(foundpart) == true then
						foundpart.Velocity = Vector3.zero
						workspace.CurrentCamera.CameraSubject = foundpart
						if InAttack == false then
							pc:PivotTo(CFrame.new(foundpart.Position.X,foundpart.Position.Y-12,foundpart.Position.Z))
						else
							pc:PivotTo(CFrame.new(foundpart.Position.X,foundpart.Position.Y,foundpart.Position.Z))
						end
						local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
						local direction = controlModule:GetMoveVector()
						if direction.X > 0 then
							foundpart.CFrame*=CFrame.new(1,0,0)
						end
						if direction.X < 0 then
							foundpart.CFrame*=CFrame.new(-1,0,0)
						end
						if direction.Y > 0 then
							foundpart.CFrame*=CFrame.new(0,1,0)
						end
						if direction.Y < 0 then
							foundpart.CFrame*=CFrame.new(0,-1,0)
						end
						if direction.Z > 0 then
							foundpart.CFrame*=CFrame.new(0,0,1)
						end
						if direction.Z < 0 then
							foundpart.CFrame*=CFrame.new(0,0,-1)
						end
					else
						foundpart.Velocity = Vector3.new(14.46262424,14.46262424,14.46262424)+Vector3.new(0,math.cos(tick()*10)/100,0)
						pc:PivotTo(foundpart.CFrame)
						workspace.CurrentCamera.CameraSubject = pc:FindFirstChildOfClass("Humanoid")
					end	
				end)
			end)
		else
			notify("Could not reposition part cframe: partcontrol cancelled.","TERMINAL")
		end
	else
		notify("No controllable parts were found.","TERMINAL")
	end
end)
cmd.add({"controltool","controlt"},"Gives you a tool that controls the remotes inside of others's tools, command is purely based if the game is well made or not.",function()
	if not game.Players.LocalPlayer.Backpack:FindFirstChild("GunController-T") then
		local tool = Instance.new("Tool",game.Players.LocalPlayer.Backpack)
		tool.Name = "ToolController-T"
		tool.RequiresHandle = false
		tool.Activated:Connect(function()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("Tool") then
					for _, v2 in ipairs(v:GetDescendants()) do
						if v2:IsA("RemoteEvent") or v2:IsA("BindableEvent") or v2:IsA("RemoteFunction") then
							pcall(function()
								v2:Fire(game.Players.LocalPlayer:GetMouse().Hit)
							end)
							pcall(function()
								v2:Fire(game.Players.LocalPlayer:GetMouse().Hit.Position)
							end)
							pcall(function()
								v2:Fire(game.Players.LocalPlayer:GetMouse().Target)
							end)
							pcall(function()
								v2:FireServer(game.Players.LocalPlayer:GetMouse().Hit)
							end)
							pcall(function()
								v2:FireServer(game.Players.LocalPlayer:GetMouse().Hit.Position)
							end)
							pcall(function()
								v2:FireServer(game.Players.LocalPlayer:GetMouse().Target)
							end)
							pcall(function()
								v2:InvokeServer(game.Players.LocalPlayer:GetMouse().Hit)
							end)
							pcall(function()
								v2:InvokeServer(game.Players.LocalPlayer:GetMouse().Hit.Position)
							end)
							pcall(function()
								v2:InvokeServer(game.Players.LocalPlayer:GetMouse().Target)
							end)
						end
					end
				end
			end
		end)
	else
		notify("You already have this tool!","TERMINAL")
	end
end)
cmd.add({"gettools","tools"},"Attempts to steal tools from others.",function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Tool") or v:IsA("BackpackItem") then
			v.Parent = game.Players.LocalPlayer.Backpack
		end
	end
end)
cmd.add({"clearbans"},"Clears the remoteban table.",function()
	pcall(function()
		table.clear(remotebans)
	end)
end)
cmd.add({"remotedestroygame","rdestroygame"},"Attempts to destroy the game with junk RemoteEvents",function()
	notify("Attempting to destroy the game...","TERMINAL")
	for _, v in ipairs(workspace:GetChildren()) do
		if v.ClassName ~= "Terrain" and v.ClassName ~= "Camera" then
			RemoteDestroy(v)
		end
	end
end)
cmd.add({"remoteban","rban"},"Attempts to ban the target with junk RemoteEvents",function(target)
	target = getPlr(target)
	if target then
		notify("Attempting remoteban...","TERMINAL")
		local targetname;targetname = target.UserId
		task.wait()
		pcall(RemoteDestroy,target)
		task.wait()
		table.insert(remotebans,targetname)
	end
end)
cmd.add({"speedfling","sfling"},"speed fling speed fling",function(target)
	pcall(function()
		if getPlr(target) ~= nil then else return end
		local player = game.Players.LocalPlayer
		local mouse = player:GetMouse()
		local Targets = {getPlr(target).Name}

		local Players = game:GetService("Players")
		local Player = Players.LocalPlayer

		local AllBool = false

		local GetPlayer = function(Name)
			Name = Name:lower()
			if Name == "all" or Name == "others" then
				AllBool = true
				return
			elseif Name == "random" then
				local GetPlayers = Players:GetPlayers()
				if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
				for _,x in next, Players:GetPlayers() do
					if x ~= Player then
						if x.Name:lower():match("^"..Name) then
							return x;
						elseif x.DisplayName:lower():match("^"..Name) then
							return x;
						end
					end
				end
			else
				return
			end
		end

		local Message = function(_Title, _Text, Time)
		end

		local SkidFling = function(TargetPlayer)
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local RootPart = Humanoid and Humanoid.RootPart

			local TCharacter = TargetPlayer.Character
			local THumanoid
			local TRootPart
			local THead
			local Accessory
			local Handle

			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart = THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead = TCharacter.Head
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory = TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessory and Accessory:FindFirstChild("Handle") then
				Handle = Accessory.Handle
			end

			if Character and Humanoid and RootPart then
				if RootPart.Velocity.Magnitude < 50 then
					getgenv().OldPos = RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
				end
				if THead then
					workspace.CurrentCamera.CameraSubject = THead
				elseif not THead and Handle then
					workspace.CurrentCamera.CameraSubject = Handle
				elseif THumanoid and TRootPart then
					workspace.CurrentCamera.CameraSubject = THumanoid
				end
				if not TCharacter:FindFirstChildWhichIsA("BasePart") then
					return
				end

				local FPos = function(BasePart, Pos, Ang)
					RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
					Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
					RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
					RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
				end

				local SFBasePart = function(BasePart)
					local TimeToWait = 2
					local Time = tick()
					local Angle = 0

					repeat
						if RootPart and THumanoid then
							if BasePart.Velocity.Magnitude < 50 then
								Angle = Angle + 100

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()
							else
								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
				end

				workspace.FallenPartsDestroyHeight = 0/0

				local BV = Instance.new("BodyVelocity")
				BV.Name = "EpixVel"
				BV.Parent = RootPart
				BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
				BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

				if TRootPart and THead then
					if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
						SFBasePart(THead)
					else
						SFBasePart(TRootPart)
					end
				elseif TRootPart and not THead then
					SFBasePart(TRootPart)
				elseif not TRootPart and THead then
					SFBasePart(THead)
				elseif not TRootPart and not THead and Accessory and Handle then
					SFBasePart(Handle)
				else
				end

				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				workspace.CurrentCamera.CameraSubject = Humanoid

				repeat
					RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(), function(_, x)
						if x:IsA("BasePart") then
							x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
						end
					end)
					task.wait()
				until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
				workspace.FallenPartsDestroyHeight = getgenv().FPDH
			else
			end
		end

		getgenv().Welcome = true
		if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

		if AllBool then
			for _,x in next, Players:GetPlayers() do
				SkidFling(x)
			end
		end

		for _,x in next, Targets do
			if GetPlayer(x) and GetPlayer(x) ~= Player then
				if GetPlayer(x).UserId ~= 1414978355 then
					local TPlayer = GetPlayer(x)
					if TPlayer then
						SkidFling(TPlayer)
					end
				else
				end
			elseif not GetPlayer(x) and not AllBool then
			end
		end
	end)
end)
cmd.add({"fireproximityprompts","fpp"},"Fires all of the proximityprompts in the game.",function()
	local fti = 0
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("ProximityPrompt")then
			fti += 1
			pcall(function()
				fireproximityprompt(v)
			end)
		end
	end
	notify("Fired "..fti.." proximityprompts.","TERMINAL")
end)
cmd.add({"remotespam","rspam"},"Fires all of the remote events in the game to cause lag. This command can only be stopped by rejoining.",function()
	game:GetService("RunService").Heartbeat:Connect(function()
		for _, v in ipairs(game:GetDescendants()) do
			if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
				pcall(function()
					v:FireServer()
				end)
				pcall(function()
					v:InvokeServer()
				end)
			end
		end
	end)
end)
cmd.add({"fireremotes","firer"},"Fires all of the remote events in the game.",function()
	local fti = 0
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
			fti += 1
			pcall(function()
				v:FireServer()
			end)
			pcall(function()
				v:InvokeServer()
			end)
		end
	end
	notify("Fired "..fti.." remotes.","TERMINAL")
end)
cmd.add({"resetspawn","illusion"},"Makes your respawnpoint be the place where you died.",function()
	local hi = false
	local lastdied
	game:GetService("RunService").Heartbeat:Connect(function()
		if hi == false and pc:FindFirstChildOfClass("Humanoid").Health <= 0 then
			hi = true
			lastdied = pc:GetPivot()
		end
		if hi == true then
			pcall(function()
				if p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
					p.Character:PivotTo(lastdied)
				end
			end)
			pcall(function()
				if p.Character:FindFirstChildOfClass("Humanoid").Health > 1 then
					hi = false
				end
			end)
		end
	end)
end)
cmd.add({"firetouchinterests","fti"},"Fires all of the touch interests in workspace.",function()
	local fti = 0
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("TouchTransmitter") then
			fti += 1
			pcall(firetouchinterest,v.Parent,0)
			pcall(firetouchinterest,v.Parent,1)
		end
	end
	notify("Fired "..fti.." touchinterests.","TERMINAL")
end)
cmd.add({"bringunanchored","bringua"},"Brings unanchored parts to you.",function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v.ReceiveAge == 0 and v.Anchored == false and #v:GetConnectedParts() == 1 then
			pcall(function()
				v.CFrame = game:GetService("Players").LocalPlayer.Character:GetPivot()
			end)
		end
	end
end)
cmd.add({"spook"},"spookey",function(target)
	local Username = target
	local Target = getPlr(Username)

	local oldCF = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	Target = getPlr(Username)    
	local distancepl = 2
	if Target.Character and Target.Character:FindFirstChild('Humanoid') then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame +  Target.Character.HumanoidRootPart.CFrame.lookVector * distancepl
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Target.Character.HumanoidRootPart.Position)
		wait(.5)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCF
	end

end)
cmd.add({"seatbring","sbring"},"the seat kidnap 😱😱 real",function(target)
	local target = getPlr(target)
	if target then
		task.spawn(function()
			if not pc:FindFirstChildOfClass("Tool") then
				notify("Hold out your seated tool.","TERMINAL")
				repeat task.wait() until pc:FindFirstChildOfClass("Tool") ~= nil
			end
			local tool = pc:FindFirstChildOfClass("Tool")
			local seat = tool:FindFirstChildWhichIsA("Seat",true) or nil
			local oldpos;oldpos = pc:GetPivot()
			local otick;otick = tick();
			repeat
				if seat ~= nil then
					firetouchinterest(seat,target.Character.HumanoidRootPart,0)
					firetouchinterest(seat,target.Character.HumanoidRootPart,1)
				end
				pc:PivotTo((target.Character.HumanoidRootPart.CFrame+(target.Character:FindFirstChildOfClass("Humanoid").MoveDirection*9))*CFrame.new(-4,0,3))
				game:GetService("RunService").Heartbeat:Wait()
				if seat ~= nil then
					firetouchinterest(seat,target.Character.HumanoidRootPart,0)
					firetouchinterest(seat,target.Character.HumanoidRootPart,1)
				end
				pc:PivotTo((target.Character.HumanoidRootPart.CFrame+(target.Character:FindFirstChildOfClass("Humanoid").MoveDirection*9))*CFrame.new(4,0,3))
				game:GetService("RunService").Heartbeat:Wait()
				game:GetService("RunService").Heartbeat:Wait()
			until tick()-otick >= 4 or seat ~= nil and seat:FindFirstChild("SeatWeld") or target.Character.Humanoid.Sit == true
			pc:PivotTo(oldpos)
		end)
	end
end)
cmd.add({"toollag","tlag"},"Tung Tung Tung Sahur lag",function()
	local function ToolLag()
		for _, v in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
			v.Parent = game:GetService("Players").LocalPlayer.Character
			task.delay(0.0001,function()
				v.Parent = game:GetService("Players").LocalPlayer.Character
				v.Parent = game:GetService("Players").LocalPlayer.Backpack
				v.Parent = game:GetService("Players").LocalPlayer.Character
				v.Parent = game:GetService("Players").LocalPlayer.Backpack
				ToolLag()
				task.delay(0.01,function()
					ToolLag()
				end)
			end)
		end
	end
	ToolLag()
end)
cmd.add({"remoteragdoll","rragdoll"},"Attempts to ragdoll the target with junk RemoteEvents",function(target)
	target = getPlr(target)
	if target then
		notify("Attempting remoteragdoll...","TERMINAL")
		task.wait()
		pcall(RemoteDestroy,target.Character.HumanoidRootPart)
	end
end)
cmd.add({"remotehumanoidkill","rhumanoidkill"},"Attempts to kill the target's humanoid with junk RemoteEvents",function(target)
	target = getPlr(target)
	if target then
		notify("Attempting remotehumanoidkill...","TERMINAL")
		task.wait()
		pcall(RemoteDestroy,target.Character.Humanoid)
	end
end)
cmd.add({"remotekill","rkill"},"Attempts to kill the target with junk RemoteEvents",function(target)
	target = getPlr(target)
	if target then
		notify("Attempting remotekill...","TERMINAL")
		task.wait()
		pcall(RemoteDestroy,target.Character.Head)
	end
end)
cmd.add({"remotekick","rkick"},"Attempts to kick the target with junk RemoteEvents",function(target)
	target = getPlr(target)
	if target then
		notify("Attempting remotekick...","TERMINAL")
		task.wait()
		pcall(RemoteDestroy,target)
	end
end)
cmd.add({"uninhead","unihead"},"Disables the inhead animation.",function()
	local function start()
		--if not isPlaying then
		--	animationTrack:Play()
		--	animationTrack:AdjustSpeed(0)
		--	isPlaying = true
		--	local tween = TweenService:Create(weightValue, tweenInfo, {Value = 1})
		--	tween:Play()
		--else
		local tween = TweenService:Create(weightValue, tweenInfo, {Value = 0})
		tween:Play()
		tween.Completed:Connect(function()
			animationTrack:Stop()
		end)
		isPlaying = false
		--	end
	end
	start()
end)
cmd.add({"remotebtools","rbtools"},"Gives you a serversided delete tool if found!!!!",function()
	if checkremotes() == true then
		notify("Remotes found! Btools given!","TERMINAL")
		local btools = Instance.new("Tool",Players.LocalPlayer.Backpack)
		btools.Name = "Delete"
		Instance.new("StringValue",btools).Name = "HarkedyesokgoodTerminal"
		btools.RequiresHandle = false
		btools.Activated:Connect(function()
			if Players.LocalPlayer:GetMouse().Target ~= nil then
				pcall(function()
					RemoteDestroy(Players.LocalPlayer:GetMouse().Target)
				end)
			end
		end)
	else
		notify("Could not find remotes.","TERMINAL")
	end
end)
cmd.add({"flingchar","flingc"},"self explanatory (you cant stop this command)",function()
	loadstring(game:HttpGet([[https://raw.githubusercontent.com/YingXiangLing/1.0/refs/heads/main/proxyhellyEAH.lua]]))()
end)
cmd.add({"inhead","ihead"},"Animates your head so that it's inside your body.",function()
	local function start()
		--if not isPlaying then
		animationTrack:Play()
		animationTrack:AdjustSpeed(0)
		isPlaying = true
		local tween = TweenService:Create(weightValue, tweenInfo, {Value = 1})
		tween:Play()
		--else
		--	local tween = TweenService:Create(weightValue, tweenInfo, {Value = 0})
		--	tween:Play()
		--	tween.Completed:Connect(function()
		--		animationTrack:Stop()
		--	end)
		--	isPlaying = false
		-- end
		--end
	end
	start()
end)
cmd.add({"respawnto","respawngoto","rto"},"Teleports you to another player's location by respawn, a bit more undetectable.",function(name)

	if getPlr(name) then
		local h = getPlr(name).Character:WaitForChild("HumanoidRootPart").CFrame
		local cam = workspace.CurrentCamera
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
		game.Players.LocalPlayer.SimulationRadius = 1000
		wait(game.Players.RespawnTime + 0.5)
		game.Players.LocalPlayer.SimulationRadius = 1000
		game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = h
		workspace.CurrentCamera = cam
	end
end)
cmd.add({"to","goto"},"Teleports you to another player's location.",function(name)

	if getPlr(name) then
		pc:PivotTo(getPlr(name).Character:GetPivot())
	end
end)
cmd.add({"run","src","source","exe","execute"},"Runs the selected code.",function(code)
	loadstring(code)()
end)
cmd.add({"commands","cmds","help"},"Shows all of the commands TERMINAL has.",function()
	local gui = Instance.new("ScreenGui",game:GetService("CoreGui"))
	local frame = Instance.new("Frame",gui)
	local hb = game:GetService("RunService").Heartbeat:Connect(function()
		frame.Draggable = true
	end)
	frame.Size = UDim2.new(0.171, 0,0.442, 0)
	frame.ClipsDescendants = true
	frame.Position = UDim2.new(0.132, 0,0.412, 0)
	frame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	frame.BackgroundTransparency = 0
	local uistroke1 = Instance.new("UIStroke",frame)
	uistroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uistroke1.Color = Color3.fromRGB(143,143,143)
	uistroke1.LineJoinMode = Enum.LineJoinMode.Round
	uistroke1.Thickness = 1
	uistroke1.Transparency = 0
	local scrollingframe = Instance.new("ScrollingFrame",frame)
	scrollingframe.ClipsDescendants = true
	scrollingframe.Active = true
	scrollingframe.Visible = true
	scrollingframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scrollingframe.BackgroundTransparency = 1
	scrollingframe.Size = UDim2.new(1, 0,0.901, 5)
	scrollingframe.Position = UDim2.new(0, 0,0.08, 0)
	scrollingframe.CanvasSize = UDim2.new(0, 0,14, 0)
	local uigridlayout = Instance.new("UIGridLayout",scrollingframe)
	uigridlayout.CellPadding = UDim2.new(0,5,0,5)
	uigridlayout.CellSize = UDim2.new(0.9, 0,0.008, 0)
	local exitbutton = Instance.new("TextButton",frame)
	exitbutton.MouseButton1Up:Connect(function()
		hb:Disconnect()
		frame:Destroy()
	end)
	exitbutton.Text = "X"
	exitbutton.Size = UDim2.new(0.117, 0,0.08, 0)
	exitbutton.ZIndex = 3
	exitbutton.Position = UDim2.new(0.883, 0,-0, 0)
	exitbutton.BackgroundColor3 = Color3.new(255,0,0)
	exitbutton.TextScaled = true
	exitbutton.TextStrokeTransparency = 1
	local uistroke2 = Instance.new("UIStroke",exitbutton)
	uistroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uistroke1.Color = Color3.fromRGB(143,143,143)
	uistroke1.LineJoinMode = Enum.LineJoinMode.Round
	uistroke1.Thickness = 1
	uistroke1.Transparency = 0
	pcall(function()
		for i,x in next, cmd["list"] do
			local aliases = {}
			for m, v in pairs(x["name"]) do
				if m == 1 then continue end
				if m ~= #x["name"] then
					table.insert(aliases,v..", ")
				else
					table.insert(aliases,v..".")
				end
			end
			if #aliases > 0 then
				local string = ""
				for _, v in ipairs(aliases) do
					string ..= v
				end
				task.spawn(function()
					local k = Instance.new("Frame",scrollingframe)
					k.Name = x["name"][1]
					k.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
					local seemore = Instance.new("TextButton",k)
					seemore.Size = UDim2.new(0.284, 0,1, 0)
					seemore.Position = UDim2.new(0.716, 0,0, 0)
					seemore.Visible = true
					seemore.BackgroundColor3 = Color3.fromRGB(61,61,61)
					seemore.TextScaled = true
					seemore.Text = "See More"
					seemore.MouseButton1Up:Connect(function()
						notify(x['description'].." \n  Aliases: "..string,x["name"][1],8)
					end)
					local txt = Instance.new("TextLabel",k)
					txt.Size = UDim2.new(0.716, 0,1, 0)
					txt.Position = UDim2.new(0, 0,0, 0)
					txt.BackgroundTransparency = 1
					txt.TextScaled = 1
					txt.Text = x["name"][1]
					task.wait()
				end)
			else
				task.spawn(function()
					local k = Instance.new("Frame",scrollingframe)
					k.Name = x["name"][1]
					k.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
					local seemore = Instance.new("TextButton",k)
					seemore.Size = UDim2.new(0.284, 0,1, 0)
					seemore.Position = UDim2.new(0.716, 0,0, 0)
					seemore.Visible = true
					seemore.BackgroundColor3 = Color3.fromRGB(61,61,61)
					seemore.TextScaled = true
					seemore.Text = "See More"
					seemore.MouseButton1Up:Connect(function()
						notify(x['description'].." \n Aliases: none",x["name"][1],8)
					end)
					local txt = Instance.new("TextLabel",k)
					txt.Size = UDim2.new(0.716, 0,1, 0)
					txt.Position = UDim2.new(0, 0,0, 0)
					txt.BackgroundTransparency = 1
					txt.TextScaled = 1
					txt.Text = x["name"][1]
					task.wait()
				end)
			end
		end
	end)
end)
local partjails = {}
cmd.add({"leave"},"Makes you leave the game forcefully.",function()
	Players.LocalPlayer:Destroy()
end)
cmd.add({"unpartjail","unjail","unpjail"},"Unjails someone.",function(_x)
	local target = getPlr(_x)
	if target then
		for ie, v in pairs(partjails) do
			if v.uid == target.UserId then
				table.remove(partjails,ie)
				table.insert(partjails,{uid=target.UserId,connection=false})
			end
		end
	end
end)
cmd.add({"partjail","jail","pjail"},"Eternally jails someone with moving parts.",function(_x)
	local target = getPlr(_x)
	if target then
		local function flingaura(target)
			notify("Currently fetching all parts, this might reset your character.","TERMINAL")
			local RunService = game:GetService("RunService")

			local character = target.Character
			local HRP = character:WaitForChild("HumanoidRootPart")
			target.CharacterAppearanceLoaded:Connect(function()
				character = target.Character
				HRP = character:WaitForChild("HumanoidRootPart")
			end)
			local CYCLE_DURATION = 3
			local DISTANCE = 8

			local i = 0
			task.spawn(function()
				local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				local cam = workspace.CurrentCamera
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
				game.Players.LocalPlayer.SimulationRadius = 1000
				wait(game.Players.RespawnTime + 0.5)
				game.Players.LocalPlayer.SimulationRadius = 1000
				game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = h
				workspace.CurrentCamera = cam
				task.wait(0.2)
				local Parts = {}
				local function isplayer(ve)
					for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
						if v.Character:IsAncestorOf(ve) then
							return true
						end
					end
					return false
				end
				for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
						if not v.Anchored and not isplayer(v) and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
							if v.Parent ~= workspace and v.Parent:FindFirstChildOfClass("Humanoid") or v.Parent ~= workspace and v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
							else
								if #v:GetConnectedParts() < 2 then
									table.insert(Parts,v)
								end
							end
						end
					end
				end
				workspace.DescendantAdded:Connect(function(v)
					if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
						if not v.Anchored and not isplayer(v) and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
							if v.Parent ~= workspace and v.Parent:FindFirstChildOfClass("Humanoid") or v.Parent ~= workspace and v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
							else
								if #v:GetConnectedParts() < 2 then
									table.insert(Parts,v)
								end
							end
						end
					end
				end)
				task.wait(1)
				local alreadychecked = false
				local connectionheart = game:GetService("RunService").Heartbeat:Connect(function(dt)
					for _, v in ipairs(Parts) do
						if v:IsDescendantOf(game) then
							local s,l = pcall(function()
								if not HRP:IsDescendantOf(workspace) and not target:IsDescendantOf(game) then error("Player Left") end
								if v.ReceiveAge == 0 and v.Anchored ~= true then else return end
								v.CanCollide = false
								v.Velocity = Vector3.new(0,500000000000,0)
								i = (i + dt/CYCLE_DURATION) % 1
								local alpha = 2 * math.pi * i
								if HRP:IsDescendantOf(workspace) then
									v.CFrame = CFrame.Angles(0, alpha, 0)
										* CFrame.new(0, 0, DISTANCE+v.Size.Magnitude)
										+ HRP.Position
								end
							end)
							if not s then
								local found
								if not alreadychecked then
									for ie, v in pairs(partjails) do
										if v.uid == target.UserId then
											table.remove(partjails,ie)
											table.insert(partjails,{uid=target.UserId,connection=false})
										end
									end
									alreadychecked = true
								end
								table.remove(Parts,table.find(Parts,v))
								continue
							end
						else
							table.remove(Parts,table.find(Parts,v))
							continue
						end
					end
				end)
				table.insert(partjails,{uid=target.UserId,connection=true})
				task.spawn(function()
					while task.wait(1.5) do
						for ie, v in pairs(partjails) do
							if v.uid == target.UserId and v.connection == false then
								print("Test run")
								connectionheart:Disconnect()
								table.remove(partjails,ie)
								break
							end
						end
					end
				end)
			end)
		end
		flingaura(target)
	end
end)
cmd.add({"deleteunanchored","deleteua","delua","delunanchored"},"Deletes every unanchored part across the map.",function()
	notify("Currently fetching all parts, this might reset your character.","TERMINAL")
	task.spawn(function()
		print("Localized Instance")
		local old = game:GetService("Players").LocalPlayer.Character:GetPivot()
		local success = false
		pcall(function()
			game:GetService("Players").LocalPlayer.SimulationRadius = 1000
			game:GetService("Players").LocalPlayer.Character:BreakJoints()
			success = true
		end)
		task.wait(0.01)
		task.wait(game:GetService("Players").RespawnTime+0.5)
		game:GetService("Players").LocalPlayer.Character:PivotTo(old)
		task.wait(1)
		task.wait(0.2)
		local function playerisv(v)
			for _, ve in ipairs(game:GetService("Players"):GetPlayers()) do
				if v:IsDescendantOf(ve.Character) then
					return true
				end
			end
			return false
		end
		for _, v:Part in ipairs(workspace:GetDescendants()) do
			pcall(function()
				if v.ReceiveAge == 0 and not v.Anchored and not playerisv(v) and #v:GetConnectedParts() < 2 then
					v.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight+10,0)
					v.CanCollide = false
				end
			end)
		end
	end)
end)
cmd.add({"unantifling","unafling","unantif"},"Disables antifling.",function()
	pcall(function()
		antiflinging:Disconnect()
	end)
end)
local doneonce = false
local accepted = false
cmd.add({"unaccept"},"Unaccept",function()
	accepted = false
	doneonce = false
end)
cmd.add({"aliasadd","adda"},"Adds an alias to a command (THIS CANNOT BE UNDONE)",function(cmde,alias)
	if accepted == false then
		notify([[Are you sure you want to add this alias? If yes, then run "aliasadd", if not then run unaccept. THIS CANNOT BE UNDONE!]],"TERMINAL")
		doneonce = {cmde,alias}
		accepted = true
	else
		local s,d = pcall(function()
			cmd.edit(doneonce[1],doneonce[2])
		end)
		if s then
			accepted = false
			notify("Successfully added alias '"..doneonce.alias.."' to "..doneonce.cmd.."!","TERMINAL")
		else
			accepted = false
			notify("Error changing aliases, errorcode: "..d,"Terminal")
		end
	end
end)
cmd.add({"r15"},"Changes your parttype to R15.",function()
	local function respawn()
		local cf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.Humanoid.Health = 0
		player.CharacterAdded:wait(1); wait(0.2);
		character:WaitForChild("HumanoidRootPart").CFrame = cf
	end

	local avs = game:GetService("AvatarEditorService")
	avs:PromptSaveAvatar(game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription,Enum.HumanoidRigType.R15)
	notify("Press allow","TERMINAL")
	local result = avs.PromptSaveAvatarCompleted:Wait()
	if result == Enum.AvatarPromptResult.Success
	then
		notify("You are now R15","TERMINAL")
		respawn()
	else
		notify("An error has occured","TERMINAL")
	end
end)
cmd.add({"r6"},"Changes your parttype to R6.",function()
	local function respawn()
		local cf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.Humanoid.Health = 0
		player.CharacterAdded:wait(1); wait(0.2);
		character:WaitForChild("HumanoidRootPart").CFrame = cf
	end

	local avs = game:GetService("AvatarEditorService")
	avs:PromptSaveAvatar(game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription,Enum.HumanoidRigType.R6)
	notify("Press allow","TERMINAL")
	local result = avs.PromptSaveAvatarCompleted:Wait()
	if result == Enum.AvatarPromptResult.Success
	then
		notify("You are now R6","TERMINAL")
		respawn()
	else
		notify("An error has occured","TERMINAL")
	end
end)
cmd.add({"antifling","afling","antif"},"Stops other exploiters from flinging you. (WILL NOT WORK AGAINST PARTFLING)",function()
	antiflinging = game:GetService("RunService").Heartbeat:Connect(function()
		local otherplayers = game:GetService("Players"):GetPlayers()
		table.remove(otherplayers,table.find(otherplayers,game:GetService("Players").LocalPlayer))
		for _, v in ipairs(otherplayers) do
			pcall(function()
				for _, ver in ipairs(v.Character:GetChildren()) do
					pcall(function()
						ver.Velocity = Vector3.zero
						ver.AssemblyAngularVelocity = Vector3.zero
					end)
				end
			end)
		end
	end)
end)
cmd.add({"setfps","sfps","fpsset","fset","fpss"},"Sets the game's current FramePerSecond cap.",function(fps)
	pcall(function()
		setfps(fps)
	end)
	pcall(function()
		setfpscap(fps)
	end)
end)
cmd.add({"unantisit","unantis","unasit"},"Enables sitting.",function()
	game:GetService("Players").LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", true)
	game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = false
end)
cmd.add({"antisit","antis","asit"},"Disables sitting.",function()
	game:GetService("Players").LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", false)
	game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = true
end)
cmd.add({"partwalkfling","pwalkfling","partwalkf","pwalkf"},"Spins parts around you to fling players (CAN BE ALSO GIVEN TO OTHER PLAYERS), can also do partwalkfling [plr] true, for torso walkfling",function(ex,torso)
	local function flingaura(target)
		notify("Currently fetching all parts, this might reset your character.","TERMINAL")
		local RunService = game:GetService("RunService")


		local character = target.Character
		local HRP
		local CYCLE_DURATION = 3
		local DISTANCE = 5
		DISTANCE = 18

		local i = 0
		task.spawn(function()
			local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			local cam = workspace.CurrentCamera
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
			game.Players.LocalPlayer.SimulationRadius = 1000
			wait(game.Players.RespawnTime + 0.5)
			local HRP = getPlr(ex).Character:WaitForChild("HumanoidRootPart")
			game.Players.LocalPlayer.SimulationRadius = 1000
			game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = h
			workspace.CurrentCamera = cam
			task.wait(0.2)
			local Parts = {}
			local function isplayer(ve)
				for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
					if v.Character:IsAncestorOf(ve) then
						return true
					end
				end
				return false
			end
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
					if not v.Anchored and not isplayer(v) and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
						if v.Parent ~= workspace and v.Parent:FindFirstChildOfClass("Humanoid") or v.Parent ~= workspace and v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
						else
							if #v:GetConnectedParts() < 2 then
								table.insert(Parts,v)
							end
						end
					end
				end
			end
			workspace.DescendantAdded:Connect(function(v)
				if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
					if not v.Anchored and not isplayer(v) and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
						if v.Parent ~= workspace and v.Parent:FindFirstChildOfClass("Humanoid") or v.Parent ~= workspace and v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
						else
							if #v:GetConnectedParts() < 2 then
								table.insert(Parts,v)
							end
						end
					end
				end
			end)
			task.wait(1)
			local connectionheart
			connectionheart = game:GetService("RunService").Heartbeat:Connect(function(dt)
				for _, v in ipairs(Parts) do
					if v:IsDescendantOf(game) then
						local s,l = pcall(function()
							if not HRP:IsDescendantOf(workspace) and not target:IsDescendantOf(game) then error("Player Left") end
							if v.ReceiveAge == 0 and v.Anchored ~= true then else return end
							v.CanCollide = false
							v.Velocity = Vector3.new(0,500000000000,0)
							if tostring(torso):lower()  ~= "true" then
								i = (i + dt/CYCLE_DURATION) % 1
								local alpha = 2 * math.pi * i
								if HRP:IsDescendantOf(workspace) then
									v.CFrame = CFrame.Angles(0, alpha, 0)
										* CFrame.new(0, 0, DISTANCE+v.Size.Magnitude)
										+ HRP.Position
								else
									error("No HRP")
								end
							else
								if target == game:GetService("Players").LocalPlayer then
									if HRP:IsDescendantOf(workspace) then
										v.CFrame = HRP.CFrame
									else
										error("No HRP")
									end
								else
									if HRP:IsDescendantOf(workspace) then
										game:GetService("Players").LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", false)
										game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = true
										v.CFrame = HRP.CFrame*CFrame.new(0,0,-(17+v.Size.Magnitude))
										game.Players.LocalPlayer.Character:PivotTo(HRP.CFrame*CFrame.new(0,0,-(17+v.Size.Magnitude)))
									else
										error("No HRP")
									end
								end
							end

						end)
						if not s then
							connectionheart:Disconnect()
							table.remove(Parts,table.find(Parts,v))
							continue
						end
					else
						table.remove(Parts,table.find(Parts,v))
						continue
					end
				end
			end)
		end)
	end
	pcall(function()
		if getPlr(tostring(ex)) then
			flingaura(getPlr(tostring(ex)))
		end
	end)
end)
cmd.add({"wallwalk","spiderman","ww"},"makes you walk on walls",function()
	loadstring(game:HttpGet("https://pastebin.com/raw/s4FjP97j"))()
end)
cmd.add({"httpspy","hspy"},"Executes http spy.", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/HttpSpy'))()
end)
cmd.add({"unadmin"},"Removes another player's admin privileges.",function(player)
	if tostring(player) ~= nil then
		local pe
		pcall(function()
			pe = game:GetService("Players"):FindFirstChild(tostring(getPlr(player)))
		end)
		if pe then
			if table.find(admins,pe.UserId) then
				table.remove(admins,table.find(admins,pe.UserId))
				notify("Player has been removed from TERMINAL adminlist.","TERMINAL")
			else
				notify("Player is not a TERMINAL admin!", "TERMINAL")
			end
		else
			notify("Player is not inside of the server.", "TERMINAL")
		end
	else
		notify("You didn't provide a valid player.", "TERMINAL")	
	end
end)
cmd.add({"admin"},"Gives another player admin privileges.",function(player)
	if tostring(player) ~= nil then
		local pe
		pcall(function()
			pe = game:GetService("Players"):FindFirstChild(tostring(getPlr(player)))
		end)
		if pe and pe ~= Players.LocalPlayer then
			table.insert(admins,pe.UserId)
			notify("Player has been added to TERMINAL adminlist.","TERMINAL")
		else
			notify("Player is not inside of the server.", "TERMINAL")
		end
	else
		notify("You didn't provide a valid player.", "TERMINAL")	
	end
end)
cmd.add({"remotespy","rspy"},"Executes remote spy.",function()
	loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
end)
cmd.add({"gravity"},"Sets workspace gravity value to [number].",function(gravity)
	workspace.Gravity = gravity or 20
end)
local fakelag = false
cmd.add({"unfakelag","undesync"},"Disables fake lag.",function()
	fakelag = false
end)
cmd.add({"nomessages","nomsg","nohints","noh"},"Deletes all of instances.ClassName == 'Hint' or 'Message'",function()
	for _, v in ipairs(workspace:GetDescendants())  do
		if v.ClassName == "Message" or v.ClassName == "Hint" then
			v:Destroy()
		end
	end
end)
cmd.add({"joinjobid","joinjbid"},"Joins a specific jobid.",function(jbid)
	if not jbid then notify("You must provide a jobid to use this command!","TERMINAL") return end
	local s,d = pcall(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,jbid,Players.LocalPlayer)
	end)
	if s then
		notify("Joining server...","TERMINAL")
	else
		notify("Error on execution: "..d,"TERMINAL")
	end
end)
cmd.add({"jobid","jbid"},"Displays the server's jobid.",function()
	local k = Instance.new("Message",workspace)
	k.Text = game.JobId.."\n Use nomessages to clear this message!"
end)
cmd.add({"fakelag","desync"},"Creates fake lag applied on your character.",function()
	fakelag = true
	task.spawn(function()
		while fakelag do
			pcall(function()
				game.Players.LocalPlayer.Character.Torso.Anchored = true
			end)
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
				end
			end)
			pcall(function()
				for _, v:AnimationTrack in ipairs(game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
					v:AdjustSpeed(v.Speed*1.1)
				end
			end)
			game.Players.LocalPlayer.Character.Humanoid.Jump = true
			task.wait(0.1)
			pcall(function()
				for _, v:AnimationTrack in ipairs(game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
					v:AdjustSpeed(v.Speed*1.05)
				end
			end)
			pcall(function()
				game.Players.LocalPlayer.Character.Torso.Anchored = false
			end)
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
				end
			end)
			task.wait(0.1)
		end
	end)
end)
cmd.add({"instakillreach","instksreach"},"Always applies newest damage inflicted 50 times and adds reach.",function(reach)
	pcall(function()
		local reachsize =  40
		if tonumber(reach) then
			reachsize = reach
		end
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
		if not Tool then notify("Please equip a tool and run this command.","TERMINAL") end
		Tool.Activated:Connect(function()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v.Name == "HumanoidRootPart" and v.Parent:FindFirstChildOfClass("Humanoid") or v.Name == "Head" and v.Parent:FindFirstChildOfClass("Humanoid") then
					if (Tool.Handle.Position-v.Position).Magnitude <= reachsize then
						for i=1,50 do
							firetouchinterest(v,Tool.Handle,0)
							firetouchinterest(v,Tool.Handle,1)
							task.wait()
						end
					end
				end
			end
		end)
	end)
end)
cmd.add({"firetouchswordreach","ftireach","firetouchr"},"Adds extra range to your sword.",function(reach)
	pcall(function()
		local reachsize =  40
		if tonumber(reach) then
			reachsize = reach
		end
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
		if not Tool then notify("Please equip a tool and run this command.","TERMINAL") end
		Tool.Activated:Connect(function()
			for _, v in ipairs(workspace:GetDescendants()) do
				if v.Name == "HumanoidRootPart" and v.Parent:FindFirstChildOfClass("Humanoid") or v.Name == "Head" and v.Parent:FindFirstChildOfClass("Humanoid") then
					if (Tool.Handle.Position-v.Position).Magnitude <= reachsize then
						for i=1,15 do
							firetouchinterest(v,Tool.Handle,0)
							firetouchinterest(v,Tool.Handle,1)
							task.wait()
						end
					end
				end
			end
		end)
	end)
end)
cmd.add({"swordreach","reach"},"Adds extra range to your sword.",function()
	pcall(function()
		local reachsize =  40
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
		if Tool:FindFirstChild("OGSize3") then
			Tool.Handle.Size = Tool.OGSize3.Value
			Tool.OGSize3:Destroy()
			Tool.Handle.FunTIMES:Destroy()
		end
		local val = Instance.new("Vector3Value",Tool)
		val.Name = "OGSize3"
		val.Value = Tool.Handle.Size
		local sb = Instance.new("SelectionBox")
		sb.Adornee = Tool.Handle
		sb.Name = "FunTIMES"
		sb.Parent = Tool.Handle
		Tool.Handle.Massless = true
		Tool.Handle.Size = Vector3.new(reachsize,reachsize,reachsize)
	end)
end)
cmd.add({"partaura","paura","parta"},"Makes parts orbit your character.",function()
	task.spawn(function()
		print("Localized Instance")
		local old = game:GetService("Players").LocalPlayer.Character:GetPivot()
		local success = false
		pcall(function()
			game:GetService("Players").LocalPlayer.SimulationRadius = 1000
			game:GetService("Players").LocalPlayer.Character:BreakJoints()
			success = true
		end)
		task.wait(0.01)
		if success == true then
			task.wait(game:GetService("Players").RespawnTime+0.2)
			game:GetService("Players").LocalPlayer.Character:PivotTo(old)
		end
		task.wait(0.2)
		local Parts = {}
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
				if not v.Anchored and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
					table.insert(Parts,v)
				end
			end
		end
		workspace.DescendantAdded:Connect(function(v)
			if v:IsA("Part") or v:IsA("BasePart") or v:IsA('MeshPart') or v:IsA("UnionOperation") then
				if not v.Anchored and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
					table.insert(Parts,v)
				end
			end
		end)
		game:GetService("RunService").Heartbeat:Connect(function()
			for _, v in ipairs(Parts) do
				if v:IsDescendantOf(game) then
					v.CanCollide = false
					local TargetDensity = 0.1
					local FRICTION = 0.5
					local ELASTICITY = 1
					local FRICTION_WEIGHT = 0.3
					local ELASTICITY_WEIGHT = 1
					local BP = v -- Change this to the right body part (You could do this for all body parts individually if you'd like)
					local DesiredMass = 0.1 -- Change this to the final mass you want the part to be
					BP.Massless = false
					BP.CustomPhysicalProperties = PhysicalProperties.new(TargetDensity, FRICTION, ELASTICITY, FRICTION_WEIGHT, ELASTICITY_WEIGHT)
					local Volume = BP.Mass / BP.CustomPhysicalProperties.Density
					local OTargetDensity = Volume*(DesiredMass)
					local Modifier =  DesiredMass/(Volume*OTargetDensity) -- This will adjust the offput of the mass to make it the DesiredMass
					local TargetDensity = Volume*(DesiredMass * Modifier)
					local physProperties = PhysicalProperties.new(TargetDensity, FRICTION, ELASTICITY, FRICTION_WEIGHT, ELASTICITY_WEIGHT)
					BP.CustomPhysicalProperties = physProperties
					local bv = v:FindFirstChild("OkEAA")
					if not v:FindFirstChild("OkEAA") then
						bv = Instance.new("BodyPosition",v)
						bv.Name = "OkEAA"
					end
					pcall(function()
						bv.Position = game:GetService("Players").LocalPlayer.Character:GetPivot()*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)).Position
					end)
				else
					table.remove(Parts,table.find(Parts,v))
					continue
				end
			end
		end)
	end)
end)
cmd.add({"revive"},'Attempts to give you a second shot at life.',function(t)
	local Older;Older=pc:FindFirstChildOfClass("Humanoid").Health
	local reload = true
	task.spawn(function()
		repeat
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.FallingDown and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Swimming and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Seated and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Jumping and  pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Freefall then
					pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
				end
			end)
		until rawequal(reload,false)
	end)
	task.spawn(function()
		repeat
			task.wait(0.13)
			pcall(function()
				if rawequal(reload,true) then
					Older=pc:FindFirstChildOfClass("Humanoid").Health
				end
			end)
		until pc:FindFirstChildOfClass("Humanoid").Health <= 0
	end)
	local idk
	pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
	pc:FindFirstChildOfClass("Humanoid").RequiresNeck = false
	pc:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
	idk = pc:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
		local r;r = pc:FindFirstChildOfClass("Humanoid").Health
		pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
		if tonumber(Older)>tonumber(r) then
			pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
			pc:FindFirstChildOfClass("Humanoid").Parent = game.ReplicatedStorage
			game.ReplicatedStorage:FindFirstChild("Humanoid").Parent = pc
			if r<=5 then
				idk:Disconnect()
				delay(0.02,function()
					reload = false
				end)
			end
		else
			Older = r
		end
	end)
end)
cmd.add({"partfling","pf","partf"},"Flings someone using parts, far more undetectable and works in collisions off.",function(name)
	local function PartFling(target)
		if target then
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
								if #v:GetConnectedParts() < 2 then
									biggestmagnitude = (game.Players.LocalPlayer.Character.Head.Position-v.Position).Magnitude
									bestpart = v
								end
							end
						end
					end
				end
				return bestpart
			end
			local Part = getclosestpart()
			if Part == nil then return end
			local oldcf=game:GetService("Players").LocalPlayer.Character:GetPivot()
			if NetworkCheck(Part) == false then
				repeat
					game:GetService("Players").LocalPlayer.Character:PivotTo(Part.CFrame)
					game:GetService("RunService").RenderStepped:Wait()
				until NetworkCheck(Part) == true
			end
			game:GetService("Players").LocalPlayer.Character:PivotTo(oldcf)
			game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			Part.Velocity = Vector3.new(0,5000,0)
			local weld = {Part1 = target.Character.HumanoidRootPart,Part0 = Part}
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
					Part.CFrame = weld.Part1.CFrame+(weld.Part1.Parent:FindFirstChildOfClass("Humanoid").MoveDirection*11)
				end
			end)
		end
	end
	PartFling(getPlr(name))
end)
cmd.add({"print"},"Prints text in the console.",print)
cmd.add({"sit"},"Sit.",function()
	pc:FindFirstChildOfClass("Humanoid").Sit = true
end)
cmd.add({"reset","die"},"die die die die die die die die",function()
	pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,true)
	pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
end)
cmd.add({"fling","hf","hyperf"},"Flings your target lol.",function(name)
	local Players = game.Players
	local plr = p
	local function Fling(TargetName)
		if Players:FindFirstChild(TargetName) then
			local oldpos;oldpos=plr.Character:FindFirstChild("HumanoidRootPart").CFrame
			local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
			HRP.Transparency = 0.5
			HRP.BrickColor = BrickColor.new("Persimmon")
			HRP:FindFirstChildOfClass("Motor6D").Enabled = false
			local Target = Players:FindFirstChild(TargetName).Character
			workspace.CurrentCamera.CameraSubject = Target:FindFirstChild("Head")
			HRP.CFrame = Target:GetPivot()
			plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
			local otick;otick=tick()
			local MODEL = Instance.new("Model",workspace)
			Instance.new("Humanoid",MODEL).Name = "1"
			repeat
				HRP.Parent = MODEL
				HRP.Position = Target.HumanoidRootPart.Position+(Target:FindFirstChildOfClass("Humanoid").MoveDirection*11)
				for _, v in ipairs(plr.Character:GetChildren()) do
					pcall(function()
						HRP.Velocity = Vector3.new(99999,99999,99999)
						HRP.AssemblyAngularVelocity= Vector3.new(99999,99999,99999)
					end)
				end
				HRP.Velocity = Vector3.new(99999,99999,99999)
				HRP.AssemblyAngularVelocity= Vector3.new(99999,99999,99999)
				task.wait()
			until Target:FindFirstChild("HumanoidRootPart").Velocity.Magnitude >= 99 or tick()-otick >= 3
			MODEL:FindFirstChild("1"):Destroy()
			task.wait(.1)
			workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
			HRP.Parent = plr.Character
			MODEL:Destroy()
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					HRP.Velocity = Vector3.new(0,0,0)
					HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			task.wait(.1)
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			HRP:FindFirstChildOfClass("Motor6D").Enabled = true
			otick=tick()
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					HRP.Velocity = Vector3.new(0,0,0)
					HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					v.Velocity = Vector3.new(0,0,0)
					v.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			local ootick;ootick=tick()
			plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			HRP.Transparency = 1
			plr.Character:FindFirstChild("Head").Anchored = false
			repeat
				workspace:BulkMoveTo({HRP},{oldpos})
				task.wait()
			until tick()-ootick >= 0.3
		end
	end
	pcall(function()
		if pc:FindFirstChild("Torso") then
			if name ~= tostring(p.Name) then
				Fling(getPlr(name).Name)
			else
			end
		else
			notify("R15 does not work on HYPERFLING, instead try cframefling.","TERMINAL")
		end
	end)
end)
cmd.add({"damagetp","dmgtp"},"Teleports away when you get damaged, true for it to avoid players.",function(dclo)

	if dclo ~= nil and rawequal(dclo:lower(),"true") then
		repeat
			task.wait()
			for _, v in ipairs(game.Players:GetPlayers()) do
				if v ~= p then
					if (pc:GetPivot().Position-v.Character:GetPivot().Position).Magnitude <= 50 and v.Team ~= p.Team or (pc:GetPivot().Position-v.Character:GetPivot().Position).Magnitude <= 50 and rawequal(v.Team,nil) then
						pc:PivotTo(pc:GetPivot()*CFrame.new(math.random(-13,23),0,math.random(-13,23)))
					end
				end
			end
		until pc:FindFirstChildOfClass("Humanoid").Health <= 0
	elseif rawequal(dclo,nil) or rawequal(dclo:lower(),"false") then
		local Older;Older=pc:FindFirstChildOfClass("Humanoid").Health
		task.spawn(function()
			repeat
				task.wait(0.13)
				Older=pc:FindFirstChildOfClass("Humanoid").Health
			until pc:FindFirstChildOfClass("Humanoid").Health <= 0
		end)
		pc:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
			local r = pc:FindFirstChildOfClass("Humanoid").Health
			if tonumber(Older)>tonumber(r) then
				pc:PivotTo(pc:GetPivot()*CFrame.new(math.random(-13,23),0,math.random(-13,23)))
			else
				Older = r
			end
		end)
	end
end)
cmd.add({"commandcount","countcmd","cmdcount","countcommands"},"Counts all of TERMINAL's commands.",function()
	local c = 0
	for _, v in pairs(cmd.list) do
		c+=1
	end
	notify("There are "..c.." commands in total.","TERMINAL")
end)
cmd.add({"unairwalk","unairw"},"Turns off airwalk.", function()
	for i, v in pairs(workspace:GetChildren()) do
		if tostring(v) == "Airwalk" then
			v:Destroy()
		end
	end
end)
cmd.add({"airwalk","airw"},"Turns on airwalk.",function()
	task.spawn(function()
		local function AirWalk()

			local AirWPart = Instance.new("Part", workspace)
			local crtl = true
			local Mouse = game.Players.LocalPlayer:GetMouse()
			AirWPart.Size = Vector3.new(7, 2, 3)
			AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
			AirWPart.Transparency = 1
			AirWPart.Anchored = true
			AirWPart.Name = "Airwalk"
			for i = 1, math.huge do
				AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
				wait (.1)
			end
		end
		AirWalk()
	end)
end)
cmd.add({"toolfling","toolf"},"Makes one of your tools fling a player to oblivion on touch.",function()
	task.spawn(function()
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
		if not Tool then
			notify("Please equip a tool.","TERMINAL")
		end
		if not Tool then
			repeat
				task.wait()
				Tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
			until Tool
		end
		Tool.Handle.Massless = true
		task.spawn(function()
			repeat
				task.wait()
				pcall(function()
					if hiddenfling == false then
						local ovel = pc:FindFirstChild("HumanoidRootPart").Velocity
						Tool.Handle.AssemblyLinearVelocity = Vector3.new(99999,9999,999999)
						game:GetService("RunService").RenderStepped:Wait()
						pc:FindFirstChild("HumanoidRootPart").Velocity = ovel
						ovel = pc:FindFirstChild("HumanoidRootPart").Velocity
					end
				end)
			until Tool == nil
		end)
		notify("Successfully activated toolfling on "..Tool.Name.."!","TERMINAL")
	end)
end)
cmd.add({"unwalkfling","unwalkf"},"Disables walkfling.",function()
	pcall(function()
		hiddenfling = false
	end)
end)
cmd.add({"walkfling","walkf"},"Enables walkfling, credits to nameless admin's walkfling.",function()
	if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		hiddenfling = true
	else
		hiddenfling = true
		local detection = Instance.new("Decal")
		detection.Name = "juisdfj0i32i0eidsuf0iok"
		detection.Parent = game:GetService("ReplicatedStorage")
		local function fling()
			local hrp, c, vel, movel = nil, nil, nil, 0.1
			while true do
				game:GetService("RunService").Heartbeat:Wait()
				if hiddenfling then
					local lp = game.Players.LocalPlayer
					while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
						game:GetService("RunService").Heartbeat:Wait()
						c = lp.Character
						hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
					end
					if hiddenfling then
						vel = hrp.Velocity
						hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
						game:GetService("RunService").RenderStepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel
						end
						game:GetService("RunService").Stepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel + Vector3.new(0, movel, 0)
							movel = movel * -1
						end
					end
				end
			end
		end

		fling()
	end
end)
cmd.add({"view"},"Lets you view someone.",function(name)
	local target = getPlr(name)
	if target then
		local targetc = target.Character
		workspace.CurrentCamera.CameraSubject = targetc.Humanoid
	end
end)
cmd.add({"unview"},"Changes your camera back to normal.",function()
	local target = p
	if target then
		local targetc = target.Character
		workspace.CurrentCamera.CameraSubject = targetc.Humanoid
	end
end)
local im_going_mentally_insane
cmd.add({"unantivoid","unantiv"},"it disable anti void",function()
	pcall(function()
		im_going_mentally_insane:Disconnect()
	end)
end)
cmd.add({"antivoid","antiv"},"Stops the void from killing you.",function()
	im_going_mentally_insane = game:GetService("RunService").Heartbeat:Connect(function()
		if pc:GetPivot().Position.Y <= workspace.FallenPartsDestroyHeight+30 then
			for _, v in ipairs(pc:GetChildren()) do
				pcall(function()
					v.Velocity = Vector3.new(0,0,0)
					v.AssemblyLinearVelocity = Vector3.new(0,0,0)
				end)
			end
			pc:PivotTo(pc:GetPivot()*CFrame.new(0,(workspace.FallenPartsDestroyHeight*-1)+50,0))
		end
	end)
end)
cmd.add({"disabletouchevent","disablete"},"Disables the touched event of all parts using it.",function()
	local connect
	connect = game:GetService("RunService").Heartbeat:Connect(function()
		if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health < 1 then
			connect:Disconnect()
			for _, v in ipairs(workspace:GetDescendants()) do
				pcall(function()
					v.CanTouch = true
				end)
			end
		end
		for _, v in ipairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
			pcall(function()
				v.CanTouch = false
			end)
		end
	end)
	for _, v in ipairs(workspace:GetDescendants()) do
		pcall(function()
			v.CanTouch = false
		end)
	end
end)
cmd.add({"cframefling","cffling","cframef"},"Flings someone using CFrame.",function(name)
	local target = getPlr(name)
	if target then
		local targetc = target.Character
		local done = false
		local opos;opos = pc:GetPivot()
		pc:FindFirstChild("HumanoidRootPart").CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,-15,0)
		pc:FindFirstChildOfClass("Humanoid"):ChangeState(1)
		task.spawn(function()
			repeat
				game:GetService("RunService").Heartbeat:Wait()
				pcall(function()
					local HRP = pc:FindFirstChild("HumanoidRootPart")
					local Target = targetc
					pc:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,9999,0)
					if pc:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,16)
					else
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,16)
					end
					game:GetService("RunService").Heartbeat:Wait()
					if pc:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,-1)
					else
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,-1)
					end
				end)
			until done == true or targetc.HumanoidRootPart.Velocity.Magnitude >= 50 or targetc:FindFirstChild("Head") == nil
			task.wait()
			local otick;otick = tick()
			repeat
				pc:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,2,0)
				for _, v in ipairs(pc:GetChildren()) do
					pcall(function()
						v.Velocity = Vector3.new(0,0,0)
						v.AssemblyAngularVelocity = Vector3.new(0,0,0)
						v.AssemblyLinearVelocity = Vector3.new(0,0,0)
					end)
				end
				pc:PivotTo(opos)
				pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
				task.wait()
			until tick()-otick >= 1
		end)
		delay(3,function()
			if not done then
				done = not done
			end
		end)
	end
end)
local humanoidrootpart2
cmd.add({"visible","uninvis","uninvisible"},"simple",function()
	if humanoidrootpart2 == nil then
		notify("You must be in invisible mode already.", "TERMINAL")
	else
		humanoidrootpart2 = nil
		local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local cam = workspace.CurrentCamera
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
		game.Players.LocalPlayer.SimulationRadius = 1000
		wait(game.Players.RespawnTime + 0.5)
		game.Players.LocalPlayer.SimulationRadius = 1000
		game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = h
		workspace.CurrentCamera = cam
	end
end)
cmd.add({"invisible","invis"},"Makes your character invisible for others (YOU CAN STILL USE TOOLS).",function()
	task.spawn(function()
		local player = game.Players.LocalPlayer
		local position     = player.Character.HumanoidRootPart.Position
		wait(0.1)
		player.Character:MoveTo(position + Vector3.new(0, 1000000, 0))
		wait(0.1)
		local humanoidrootparttest = player.Character.HumanoidRootPart:clone()
		wait(0.1)
		humanoidrootpart2 = player.Character.HumanoidRootPart
		humanoidrootpart2:Destroy()
		humanoidrootparttest.Parent = player.Character
		task.delay(0.2,function()
			player.Character:MoveTo(position)
		end)
	end)
end)
cmd.add({"creatorid","ownerid","oid"},"Changes your userid to the owner's userid (CLIENT).",function()
	task.spawn(function()
		if game.CreatorType == Enum.CreatorType.User then
			game.Players.LocalPlayer.UserId = game.CreatorId
		end
	end)
	task.spawn(function()
		if game.CreatorType == Enum.CreatorType.Group then
			game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
		end
	end)
	task.wait(0.2)
	notify("UserId Set to "..game.Players.LocalPlayer.UserId..".","TERMINAL")
end)
local IsOnMobile = false
pcall(function()
	IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
end)
cmd.add({"unfly"},"Disables flight.",function()
	if not IsOnMobile then NOFLY() else unmobilefly(Players.LocalPlayer) end
end)
cmd.add({"fly"},"Enables flight.",function(flyspeed)
	if not IsOnMobile then
		NOFLY()
		wait()
		sFLY()
	else
		mobilefly(Players.LocalPlayer)
	end
	if flyspeed and tonumber(flyspeed) then
		iyflyspeed = tonumber(flyspeed)
	end
end)
cmd.add({"dex","explorer"},"Lets you see every instance in the game.",function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)
local loopws
local oldwsloop = 16
cmd.add({"unloopwalkspeed","unloopws"},"Disables loopwalkspeed",function()
	loopws:Disconnect()
	wait()
	Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = oldwsloop
end)
cmd.add({"loopwalkspeed","loopws"},"LoopSets your walkspeed to specified number.",function(speed)
	if not speed then
		speed = 32
	end
	oldwsloop = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed
	loopws = game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			pc:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
		end)
	end)
end)
cmd.add({"showinventory","showinv"},"Enables inventory.",function()
	game.StarterGui:SetCoreGuiEnabled(2, true)
end)
cmd.add({"walkspeed","speed","ws"},"Changes your walkspeed to the specified number, use this with noanti to maximize its potential.",function(num)
	pc:FindFirstChildOfClass("Humanoid").WalkSpeed = num or 32
end)
cmd.add({"noanti"},"Attempts to destroy every anticheat instance, this might break the game.",function()
	local Instances = 0
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("LuaSourceContainer") then
			if tostring(v.Name):lower():match("anti") or tostring(v.Name):lower():match("noch") or tostring(v.Name):lower():match("air") or tostring(v.Name):lower():match("cheat") or tostring(v.Name):lower():match("fly") or tostring(v.Name):lower():match("fling") or tostring(v.Name):lower():match("teleport") then
				if v ~= script then
					Instances += 1
					v:Destroy()
				end
			end
		end
	end
end)
local followe
cmd.add({"unfollow"},"Stops the follow command.",function()
	pcall(function()
		followe:Disconnect()
	end)
end)
cmd.add({"rejoin","rj"},"Rejoins the server if terminal is broken.",function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,Players.LocalPlayer)
end)

cmd.add({"teleporttool","clicktp",'tptool'},"Gives you a tool which teleports you to your cursor position.",function()
	local ok = Instance.new('Tool',game.Players.LocalPlayer.Backpack)
	ok.Name = "ClickTP"
	ok.RequiresHandle = false
	ok.Activated:Connect(function()
		pcall(function()
			if game:GetService("Players").LocalPlayer:GetMouse().Target ~= nil then
				game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(game:GetService("Players").LocalPlayer:GetMouse().Hit.Position+Vector3.new(0,4,0)))
			end
		end)
	end)
end)
cmd.add({"follow"},"Follows the selected player.",function(name,studs)
	if not studs then
		studs = 5
	end
	if getPlr(name) then
		pcall(function()
			followe:Disconnect()
		end)
		followe = game:GetService("RunService").Heartbeat:Connect(function()
			pcall(function()
				if pc:FindFirstChild("UpperTorso") then
					pc:PivotTo(getPlr(name).Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-studs))
				else
					pcall(function()
						pc:PivotTo(getPlr(name).Character.HumanoidRootPart.CFrame*CFrame.new(0,1.2,-studs))
					end)
				end
			end)
		end)
	end
end)
cmd.add({"clip"}, "Stops the noclip command.", function()
	Noclip:Disconnect()
	Noclip = nil
	pc:FindFirstChildOfClass("Humanoid").Parent = game.ReplicatedStorage
	game.ReplicatedStorage:FindFirstChild("Humanoid").Parent = pc
end)
cmd.add({"noclip"},"Makes you able to phase through walls.",function()
	Noclip = game:GetService("RunService").Stepped:Connect(function()
		for i, v in pairs(pc:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end)
end)
task.wait()
local Main = Instance.new("ScreenGui",game:GetService("CoreGui"))
local Imgl = Instance.new("TextButton",Main)
Main.ResetOnSpawn = false
Imgl.ZIndex = 99999
Imgl.Text = "TERMINAL"
Imgl.BackgroundColor3=Color3.new(0,0.5,0)
Imgl.TextColor3=Color3.new(0,0,0)
Imgl.TextScaled = true
Imgl.Size = UDim2.new(0,0.01,0,0.01)
Imgl:TweenSize(UDim2.new(0.068, 0,0.12, 0),"InOut","Sine",1)
Imgl.Position = UDim2.new(0.023, 0,0.869, 0)
local TBox = nil
if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
	game:GetService("TextChatService").OnIncomingMessage = function(textChatMessage)
		if textChatMessage.Status == Enum.TextChatMessageStatus.Success then
			if table.find(admins,game.Players:FindFirstChild(tostring(textChatMessage.TextSource)).UserId) or game.Players:FindFirstChild(tostring(textChatMessage.TextSource)).UserId == Players.LocalPlayer.UserId then
				if textChatMessage.Text:sub(1,2):upper() == "T!" then
					if textChatMessage.Text:len() ~= 2 then
						pcall(function()
							local g = textChatMessage.Text
							local cmde = nil
							for _, v in pairs(cmd["list"]) do
								if table.find(v.name,g:split(" ")[1]:lower():split("t!")[2]) then
									cmde = v
								end
							end
							local sound = Instance.new("Sound",workspace)
							sound.SoundId = "rbxassetid://3450794184"
							sound.Volume = 1
							sound:Play()
							game:GetService("Debris"):AddItem(sound,1.2)
							notify("Executed command! \n Operator: "..game.Players:FindFirstChild(tostring(textChatMessage.TextSource)).Name,"Chat Command Loader")
							cmde["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
						end)
					end
				end
			end
		end
	end
else
	for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
		v.Chatted:Connect(function(textChatMessage)
			if game:GetService("Players"):GetPlayerFromCharacter(v.Character) then
				local textChatMessage = {Text=textChatMessage,Source=v}
				if table.find(admins,textChatMessage.Source.UserId) or textChatMessage.Source.UserId == Players.LocalPlayer.UserId then
					if textChatMessage.Text:sub(1,2):upper() == "T!" then
						if textChatMessage.Text:len() ~= 2 then
							pcall(function()
								local g = textChatMessage.Text
								local cmde = nil
								for _, v in pairs(cmd["list"]) do
									if table.find(v.name,g:split(" ")[1]:lower():split("t!")[2]) then
										cmde = v
									end
								end
								local sound = Instance.new("Sound",workspace)
								sound.SoundId = "rbxassetid://3450794184"
								sound.Volume = 1
								sound:Play()
								game:GetService("Debris"):AddItem(sound,1.2)
								notify("Executed command! \n Operator: "..textChatMessage.Source.Name,"Chat Command Loader")
								cmde["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
							end)
						end
					end
				end
			end
		end)
	end
	game:GetService("Players").PlayerAdded:Connect(function(v)
		v.Chatted:Connect(function(textChatMessage)
			if game:GetService("Players"):GetPlayerFromCharacter(v.Character) then
				local textChatMessage = {Text=textChatMessage,Source=v}
				if table.find(admins,textChatMessage.Source.UserId) or textChatMessage.Source.UserId == Players.LocalPlayer.UserId then
					if textChatMessage.Text:sub(1,2):upper() == "T!" then
						if textChatMessage.Text:len() ~= 2 then
							pcall(function()
								local g = textChatMessage.Text
								local cmde = nil
								for _, v in pairs(cmd["list"]) do
									if table.find(v.name,g:split(" ")[1]:lower():split("t!")[2]) then
										cmde = v
									end
								end
								local sound = Instance.new("Sound",workspace)
								sound.SoundId = "rbxassetid://3450794184"
								sound.Volume = 1
								sound:Play()
								game:GetService("Debris"):AddItem(sound,1.2)
								notify("Executed command! \n Operator: "..textChatMessage.Source.Name,"Chat Command Loader")
								cmde["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
							end)
						end
					end
				end
			end
		end)
	end)
end
local oldcommand = ""
local cooldown = false
Imgl.MouseButton1Down:Connect(function()
	if cooldown == false then
		if rawequal(TBox,nil) then
			TBox = Instance.new("TextBox",Main)
			TBox.ZIndex = 100000
			TBox.Size = UDim2.new(0.001,0,0.097,0)
			TBox.PlaceholderText = "Command here"
			TBox.Text = oldcommand
			TBox.PlaceholderColor3 = TBox.TextColor3
			TBox.TextScaled = true
			TBox.Position = UDim2.new(0.104, 0,0.882, 0)
			TBox:TweenSize(UDim2.new(0.2, 0,0.097, 0),"InOut",Enum.EasingStyle.Quad,0.5)
			local sound = Instance.new("Sound",workspace)
			sound.SoundId = "rbxassetid://127533251122014"
			sound.Volume = 1.5
			sound:Play()
			cooldown = true
			task.delay(0.5,function()
				cooldown = false
			end)
			Instance.new("UICorner",TBox).CornerRadius = UDim.new(0, 8)
			local h = Instance.new("UIStroke",TBox)
			h.Thickness = 2
			h.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			h = nil
			TBox.FocusLost:Connect(function()
				pcall(function()
					local g = TBox.Text
					local cmde = nil
					for _, v in pairs(cmd["list"]) do
						if table.find(v.name,g:split(" ")[1]:lower()) then
							cmde = v
						end
					end
					if cmde then
						local sound = Instance.new("Sound",workspace)
						sound.SoundId = "rbxassetid://3450794184"
						sound.Volume = 1
						sound:Play()
						game:GetService("Debris"):AddItem(sound,1.2)
						notify("Executed command!","Command Loader")
						cmde["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
					else
						local ge = safestring(g:split(" ")[1])
						if not ge then
							ge = "null"
						end
						if ge == "" then
						else
							notify("No command has been found with the name of '"..ge.."'.","Command Loader")
						end
					end
				end)
			end)
		else
			TBox:TweenSize(UDim2.new(0.001,0,0.097,0),"InOut",Enum.EasingStyle.Quad,0.7)
			local sound = Instance.new("Sound",workspace)
			sound.SoundId = "rbxassetid://132442985525251"
			sound.Volume = 1.5
			sound:Play()
			task.delay(0.65,function()
				pcall(function()
					oldcommand = TBox.Text
					TBox:Destroy()
					TBox = nil
					cooldown = false
				end)
			end)
		end
	end
end)
local h = Instance.new("UIStroke",Imgl)
h.Thickness = 2
h.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
h = nil
Instance.new("UICorner",Imgl).CornerRadius = UDim.new(0, 8)
notify("TERMINAL has loaded! \n ChatPrefix: t!","TERMINAL Loader")
