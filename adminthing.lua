if rawequal(game:IsLoaded(),false) then
	game.Loaded:Wait()
end
wait(0.5)
local p = game.Players.LocalPlayer
local pc = p.Character
p.CharacterAdded:Connect(function(c)
	pc = c
end)
cmd = {
	add = function(n,g,t)
		cmd["list"][n] = {["function"] = t,["description"]=g,["name"]=n}
	end,
	list = {}

}
function execute(n,...)
	if rawequal(cmd["list"][n:lower()],nil) ~= true then
		cmd["list"][n:lower()]["function"](...)
	else
		notify("No command found with the name of "..n..".","Command Handler")
	end
end
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
			Icon = "http://www.roblox.com/asset/?id="..tostring(i),
			Duration = 5;
		})
	end
end
local alreadyblackhole = false
local hiddenfling = false
local Noclip = nil
cmd.add("goto","Teleports you to another player's location.",function(name)

	if rawequal(workspace:FindFirstChild(name),nil) ~= true then
		pc:PivotTo(workspace:FindFirstChild(name):GetPivot())
		notify("Teleported to "..name.."!","GoTo Handler","631727248")
	end
end)
cmd.add("blackhole","Picks up every part near you.",function()
	if rawequal(alreadyblackhole,false) then
		alreadyblackhole = true
		notify("blackhole activated!11","Blackhole Handler","10198213112")
		pcall(function()
			task.spawn(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/YingXiangLing/1.0/main/Chaos.lua"))()
			end)
		end)
	else
		notify("cannot activate blackhole!11","Blackhole Handler","17840065045")
	end
end)
cmd.add("cmds","Shows all of the commands Omnipotent Admin has.",function()
	notify("Say /console in chat or press F9 to see commands.","Omnipotent Admin","18514484572")
	local finishedlist = ""
	task.spawn(function()
		for _, v in pairs(cmd.list) do
			finishedlist ..= "\n Name: '"..v.name.."' Description: '"..v.description.."'"
		end
	end)
	print("Commands: "..finishedlist)
end)
cmd.add("swordreach","Adds extra range to your sword.",function()
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
	notify("extra 40 studs added to yo sword range!11","Reach Handler (Sword Version)","15377165109")
end)
cmd.add("revive",'"No... ill never give up. I HAVE THE POWER OF FRIENDSHIP!!!" ahh command, anyway this might not work though',function(t)
	notify("lol ok now reviving you if you die, MIGHT or might not work","Revive Handler","12916194667")
	local Older;Older=pc:FindFirstChildOfClass("Humanoid").Health
	local reload = true
	task.spawn(function()
		repeat
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Swimming and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Seated and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Jumping and  pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Freefall then
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
				notify("you live to see another day, btw this command only works once per life!11","Reviver","9819687855")
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
cmd.add("sit","Sit.",function()
	pc:FindFirstChildOfClass("Humanoid").Sit = true
	notify("sit.","Sit Handler","16357820944")
end)
cmd.add("reset","die die die die die die die die",function()
	pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,true)
	pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	notify("dei","Death Handler","6656885176")
end)
cmd.add("fling","Flings your target lol.",function(name)
	local Players = game.Players
	local plr = p
	local function Fling(TargetName)
		if Players:FindFirstChild(TargetName) then
			notify("Now flinging "..name.."!","Hyperfling Handler","15412899776")
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
				Fling(name)
			else
				notify("why are you trying to fling yourself","Hyperfling Handler","7202430493")
			end
		else
			notify("no, i cannot fling people while you are r15.","Hyperfling Handler","7202430493")
		end
	end)
end)
cmd.add("ui","Gives you ultra instinct lmao, you might get hit if you use false, it will stop combos by teleporting away though. But true just runs away from anyone near you",function(dclo)

	if dclo ~= nil and rawequal(dclo:lower(),"true") then
		notify("Now dodging attacks, MasteredUI: true","UltraInstinct Handler","7713850578")
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
		notify("Now dodging attacks, MasteredUI: false","UltraInstinct Handler","9819687855")
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
cmd.add("unairwalk","Turns off airwalk.", function()
	for i, v in pairs(workspace:GetChildren()) do
		if tostring(v) == "Airwalk" then
			v:Destroy()
		end
	end
	notify("Disabled airwalk!","Airwalk Handler","16218447187")
end)
cmd.add("airwalk","Turns on airwalk.",function()
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
		notify("Enabled airwalk!","Airwalk Handler","16218447187")
		AirWalk()
	end)
end)
cmd.add("toolfling","Makes one of your tools fling a player to oblivion on touch.",function()
	task.spawn(function()
		local Tool = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
		if not Tool then
			repeat
				task.wait()
				Tool = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
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
		notify("Successfully activated toolfling on "..Tool.Name.."!","Toolfling Handler","12917287778")
	end)
end)
cmd.add("unwalkfling","Disables walkfling.",function()
	notify("Disabled walkfling!","Walkfling Handler","12260174010")
	pcall(function()
		hiddenfling = false
	end)
end)
cmd.add("walkfling","Enables walkfling, credits to nameless admin's walkfling.",function()
	if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		hiddenfling = true
		notify("Enabled walkfling!","Walkfling Handler","12260174010")
	else
		notify("Enabled walkfling!","Walkfling Handler","12260174010")
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
cmd.add("invis","Makes your character invisible (YOU CAN STILL USE TOOLS)",function()
	task.spawn(function()
		local player = game.Players.LocalPlayer
		local position     = player.Character.HumanoidRootPart.Position
		wait(0.1)
		player.Character:MoveTo(position + Vector3.new(0, 1000000, 0))
		wait(0.1)
		local humanoidrootpart = player.Character.HumanoidRootPart:clone()
		wait(0.1)
		player.Character.HumanoidRootPart:Destroy()
		humanoidrootpart.Parent = player.Character
		player.Character:MoveTo(position)
	end)
end)
cmd.add("ownerid","Changes your userid to the owner's userid (CLIENT)",function()
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
	notify("UserId Set to "..game.Players.LocalPlayer.UserId..".","OwnerId Handler","12621969404")
end)
cmd.add("speed","Changes your walkspeed to the specified number, use this with noanti to maximize its potential.",function(num)
	pc:FindFirstChildOfClass("Humanoid").WalkSpeed = num
	notify("Successfully set walkspeed to "..num.."!","Speed Handler","17821867294")
end)
cmd.add("noanti","Attempts to destroy every anticheat instance, this might break the game.",function()
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
	task.wait()
	notify("Removed "..Instances.." anticheat scripts.","NoAnti Handler","12976103126")
end)
cmd.add("clip", "Stops the noclip command.", function()
	Noclip:Disconnect()
	Noclip = nil
	pc:FindFirstChildOfClass("Humanoid").Parent = game.ReplicatedStorage
	game.ReplicatedStorage:FindFirstChild("Humanoid").Parent = pc
	notify("Disabled noclip!","Noclip Handler","13501428865")
end)
cmd.add("noclip","Makes you able to phase trough walls",function()
	if rawequal(Noclip,nil) then notify("Activated noclip!","Noclip Handler","13501428865") else notify("You are already using noclip!","Noclip Handler","15387802901") return end
	Noclip = game:GetService("RunService").Stepped:Connect(function()
		for i, v in pairs(pc:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end)
end)
task.wait()
local Main = Instance.new("ScreenGui",p.PlayerGui)
local Imgl = Instance.new("ImageButton",Main)
Main.ResetOnSpawn = false
Imgl.ZIndex = 99999
Imgl.Image = "http://www.roblox.com/asset/?id=18514484572"
Imgl.Size = UDim2.new(0,0.01,0,0.01)
Imgl:TweenSize(UDim2.new(0.068, 0,0.12, 0),"InOut","Sine",1)
Imgl.Position = UDim2.new(0.023, 0,0.869, 0)
local TBox = nil
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
			local g = TBox.Text
			pcall(function()
				if cmd.list[g:split(" ")[1]] then
					cmd.list[g:split(" ")[1]]["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
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
notify("Omnipotent Admin has loaded!","OA Loader","16124991389")
