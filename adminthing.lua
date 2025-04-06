if rawequal(game:IsLoaded(),false) then
	game.Loaded:Wait()
end
wait(0.5)
if replicatesignal then
else
	replicatesignal = false
end
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
local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local cam = workspace.CurrentCamera
if replicatesignal ~= false then
	replicatesignal(game.Players.LocalPlayer.ConnectDiedSignalBackend)
	game.Players.LocalPlayer.SimulationRadius = 1000
else
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
	game.Players.LocalPlayer.SimulationRadius = 1000
end
wait(game.Players.RespawnTime + 0.5)
if  replicatesignal then
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
	game.Players.LocalPlayer.SimulationRadius = 1000
end
if replicatesignal then
	wait(0.5)
	game.Players.LocalPlayer.SimulationRadius = 1000
end
game.Players.LocalPlayer.SimulationRadius = 1000
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = h
workspace.CurrentCamera = cam
wait(0.1)
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
-- function execute(n,...)
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
	scrollingframe.CanvasSize = UDim2.new(0, 0,9, 0)
	local uigridlayout = Instance.new("UIGridLayout",scrollingframe)
	uigridlayout.CellPadding = UDim2.new(0,5,0,5)
	uigridlayout.CellSize = UDim2.new(0.9, 0,0.01, 0)
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
				if replicatesignal then
					wait(0.5)
				else
					wait(game.Players.RespawnTime+0.5)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = h
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
			if replicatesignal then
				wait(0.5)
			else
				wait(game.Players.RespawnTime+0.5)
			end
			HRP = getPlr(ex).Character:FindFirstChild("HumanoidRootPart")
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = h
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
cmd.add({"instakillreach","instksreach"},"Changes sword damage value to 1000 and adds reach.",function(reach)
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
							firetouchinterest(v,Tool.Handle,1)
							firetouchinterest(v,Tool.Handle,0)
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
							firetouchinterest(v,Tool.Handle,1)
							firetouchinterest(v,Tool.Handle,0)
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
cmd.add({"revive"},'"No... ill never give up. I HAVE THE POWER OF FRIENDSHIP!!!" ahh command, anyway this might not work though',function(t)
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
					Part.CFrame = weld.Part1.CFrame
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
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,5)
					else
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,5)
					end
					game:GetService("RunService").Heartbeat:Wait()
					if pc:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,-5)
					else
						HRP.CFrame = Target.HumanoidRootPart.CFrame*CFrame.new(0,0,-5)
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
		firetouchinterest(targetc:FindFirstChild("HumanoidRootPart"),pc:FindFirstChild("HumanoidRootPart"),0)
		firetouchinterest(targetc:FindFirstChild("HumanoidRootPart"),pc:FindFirstChild("HumanoidRootPart"),1)
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
		local h = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local cam = workspace.CurrentCamera
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(15)
		game.Players.LocalPlayer.SimulationRadius = 1000
		if replicatesignal then
			wait(0.5)
		else
			wait(game.Players.RespawnTime+0.5)
		end
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = h
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
Imgl.MouseButton1Down:Connect(function()
	if rawequal(TBox,nil) then
		TBox = Instance.new("TextBox",Main)
		TBox.ZIndex = 100000
		TBox.PlaceholderText = "Command here"
		TBox.Text = ""
		TBox.PlaceholderColor3 = TBox.TextColor3
		TBox.TextScaled = true
		TBox.Position = UDim2.new(0.104, 0,0.882, 0)
		TBox:TweenSize(UDim2.new(0.2, 0,0.097, 0),"InOut","Sine",0.5)
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
		TBox:TweenSize(UDim2.new(0,0.001,0,0.001),"InOut","Sine",0.5)
		delay(0.5,function()
			pcall(function()
				TBox:Destroy()
				TBox = nil
			end)
		end)
	end
end)
local h = Instance.new("UIStroke",Imgl)
h.Thickness = 2
h.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
h = nil
Instance.new("UICorner",Imgl).CornerRadius = UDim.new(0, 8)
notify("TERMINAL has loaded! \n ChatPrefix: t!","TERMINAL Loader")
