
print("Running @casual_degenerate#7475's Roblox Utility")
-- / Debug is enabled to default, and you can change it by adding a value ingame.
local IsDebug = game:GetService("ServerStorage"):FindFirstChild("Debug")
if IsDebug then
	IsDebug = true
else
	IsDebug = false
end
local warn = function(...)
	if IsDebug then
		warn(...)
	end
end

if pcall(function()game:GetService("HttpService"):GetAsync("www.google.com")end) then
	error("Turn off HTTP",0) -- / Just so you don't leak your IP to any people, since your IP is what you use with GetAsync and HTTP stuff, you send request, not the server.
end
local StudioService = game:GetService("StudioService")
do
	-- / This is so I can jump up and down like a happy boy.
	if pcall(function()StudioService:CopyToClipboard("If you see this, lit!")end) then
		warn("CONGRATS COPYTOCLIPBOARD IS A THING! GO AND ADD THAT!",0)
	end
end
local Selection = game:GetService("Selection")
local UserId = game:GetService("StudioService"):GetUserId()
local Plugin = plugin
local Toolbar = Plugin:CreateToolbar('cd')
local FullName = Toolbar:CreateButton("FullName", "Select a Instance", 'rbxasset://cdAssets/Button.png')
FullName.Click:Connect(function()
	for i,v in next, Selection:Get() do
		if i>20 then -- / Stop you from making mistakes
			break
		end
		print("game:GetService('" .. v:GetFullName():split(".")[1] .. "')." .. v:GetFullName():sub(   v:GetFullName():split(".")[1]:len()+2   ,   v:GetFullName():len()   ))
	end
end)
local Detector = Toolbar:CreateButton("Detector", "Used to reverse engineer backdoors, and such", "rbxasset://cdAssets/Button.png")
local Detections = {
	Keywords = {
		"getfenv",
		"require",
		"marketplaceservice",
--		"fire",
		"teleportservice",
		"webhook",
		"discord",
		"trello",
		"http"
	},
	Maxsize = 200000,
}
Detector.Click:Connect(function()
	local Found = workspace:FindFirstChild("Detections")
	if not Found then
		Found = Instance.new("Folder")
		Found.Name = "Detections"
		Found.Parent = workspace
	end
	for i, v in next, Selection:Get() do
		v.Name ..= "_" .. i .. "_"
		local function f1(v1)
			if v1.ClassName == "ModuleScript" or v1.ClassName == "Script" or v1.ClassName == "LocalScript" then
				if v1.Source:len() > Detections.Maxsize then
					local a = Instance.new("StringValue")
					a.Parent = Found
					a.Name = v.Name .. "_MAXSIZE-" .. v1.Source:len()
					a.Value = "--This file was determined to be too large to view.\n" .. v1.Source:sub(1,Detections.Maxsize)
					return
				end
				for i, Keyword in next, Detections.Keywords do
					if v1.Source:lower():find(Keyword) then
						local _v1 = v1:Clone()
						local _object = Instance.new("ObjectValue")
						_object.Name = "Directory"
						_object.Value = v1
						_v1:ClearAllChildren()
						_object.Parent = _v1
						_v1.Parent = Found
						_v1.Name = "KEYWORD-" .. Keyword .. "_LENGTH-" .. v1.Source:len()
						
						_v1.Source = "--[[\nThis file was detected by Skidware(A very real thing by casual_degenerate#7475 586141923048161291 skidware.nekoware.lgbt)\nDetection: " .. Keyword .. "\n]]\n\n" .. v1.Source
						break
					end
				end
			end
		end
		f1(v)
		for i1, v1 in next, v:GetDescendants() do
			f1(v1)
		end
	end
end)
---[[Depricated+My Disapointment
local Disabler = Toolbar:CreateButton("Disabler", "Used to disable all scripts under what you selected", "rbxasset://cdAssets/Button.png")
Disabler.Click:Connect(function()
	for i, v in next, Selection:Get() do
		if pcall(function()v:GetFullName()end) then
			for i1, v1 in next, v:GetDescendants() do
				if v1:FindFirstChild("Disabled by Skidware") then
					v1.Disabled = false
					v1['Disabled by Skidware']:Destroy()
					warn("#Enabled#", v1:GetFullName())
				elseif v1.ClassName == "Script" or v1.ClassName == "LocalScript" and not v1.Disabled then
					v1.Disabled = true
					local note = Instance.new("BoolValue")
					note.Name = "Disabled by Skidware"
					note.Value = true
					note.Parent = v1
					print("#Disabled#", v1:GetFullName())
				end
			end
		end
	end
end)
--]]
local ClearChildren = Toolbar:CreateButton("Clear Children", "Clears children with a button", "rbxasset://cdAssets/Button.png")
ClearChildren.Click:Connect(function()
	for i, Selected in next, Selection:Get() do
		for i1, descendant in next, Selected:GetDescendants() do
			if descendant.ClassName == "Sound" then
				descendant.Volume = 0
			end
		end
		pcall(function()Selected:ClearAllChildren()end)
	end
end)
local Insert = Toolbar:CreateButton("Insert", "Inserts a asset from it's ID", "rbxasset://cdAssets/Button.png")
Insert.Click:Connect(function()
	local Ins = game:GetService("ServerStorage"):FindFirstChild("Insert")
	if not Ins then
		Ins = Instance.new("StringValue")
		Ins.Name = "Insert"
		Ins.Parent = game:GetService("ServerStorage")
		return
	end
	if tonumber(Ins.Value) and tonumber(Ins.Value) > 1 then
		local objex = game:GetObjects("rbxassetid://" .. tonumber(Ins.Value))
		for i, objecs in next, objex do
			print(i, objecs)
			if objecs.ClassName == "Script" or objecs.ClassName == "LocalScript" or objecs.ClassName == "ModuleScript" then
				local dir = game:GetService("ReplicatedStorage"):FindFirstChild("Inserted")
				if not dir then
					dir = Instance.new("Folder")
					dir.Name = "Inserted"
					dir.Parent = game:GetService("ReplicatedStorage")
				end
				objecs.Parent = dir
			end
			for i1, objec in next, objecs:GetDescendants() do
				print(i, objec)
			end
		end
	end
end)




local function func1(_Instance)
	if pcall(function()_Instance.Text:len()end) then
		-- / Playername is named unknown which is stupid to look at. I'd prefer my name.
		local function detect(__Instance)
			if __Instance.Text:lower():find("unknown") then
				__Instance.Text = "cd/"
			end
		end
		_Instance:GetPropertyChangedSignal("Text"):Connect(function()
			detect(_Instance)
		end)
		detect(_Instance)
	elseif pcall(function()_Instance.Image:len()end) then
		if pcall(function()game:GetService("CoreGui").RobloxGui.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame.p_0.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image:len()end) then
			game:GetService("CoreGui").RobloxGui.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame.p_0.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Visible = false
		end
		_Instance:GetPropertyChangedSignal("Image"):Connect(function()
			--rbxassetid is stuff you'd ask from api, rbxasset is from files, so you already can load those easily if you have the file.
			if _Instance.Image:find("rbxassetid://") then
				warn("Missing asset", _Instance, _Instance.Image)
				_Instance.Image = "rbxasset://textures/DevConsole/Warning.png"
			end
		end)
		if _Instance.Image:find("rbxassetid://") then
			warn("Missing asset", _Instance, _Instance.Image)
			_Instance.Image = "rbxasset://textures/DevConsole/Warning.png"
		end
	end
end

if UserId == 1090451412 then
	-- / To prevent copy paste I used a function.
	for _, v in next, game:GetService("CoreGui"):GetDescendants() do
		func1(v)
	end
	game:GetService("CoreGui").DescendantAdded:Connect(function(d)
		func1(d)
	end)
end
