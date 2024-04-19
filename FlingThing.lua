

function GetPlayer(name)
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Name:lower():sub(1, #name) == name:lower() then
			return v
		end
	end    
end

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local char = plr.Character
local hrp = char.HumanoidRootPart

hrp.Transparency = 0.5
if hrp:FindFirstChildOfClass("AlignPosition") then
	hrp:FindFirstChildOfClass("AlignPosition"):Destroy()
end
if hrp:FindFirstChildOfClass("AlignOrientation") then
	hrp:FindFirstChildOfClass("AlignOrientation"):Destroy()
end
local bp = Instance.new("BodyPosition", hrp)
bp.D = 9999999
bp.P = 999999999999999
bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
bp.Position = hrp.Position
flinger = Instance.new("BodyAngularVelocity",hrp)
flinger.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
flinger.P = 1000000000000000000000000000
flinger.AngularVelocity = Vector3.new(10000,10000,10000)

game:GetService("UserInputService").InputBegan:Connect(function(r,gp)
	if r.KeyCode == Enum.KeyCode.Z and gp == false then
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.RigType.R15 then
			bp.Position = game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso").Position
		else
			bp.Position = game.Players.LocalPlayer.Character:FindFirstChild("Torso").Position
			
			end
	end
end)
game:GetService("UserInputService").InputBegan:Connect(function(r,gp)
	if r.KeyCode == Enum.KeyCode.C and gp == false then
		if game.Players.LocalPlayer:GetMouse().Target ~= nil then
			bp.Position = game.Players.LocalPlayer:GetMouse().Hit.Position
			end
	end
end)
