local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))

local UIModelReplicator = Class("UIModelReplicator", Service)

function UIModelReplicator:initialize (serviceName, dependencies, player, userInterfaceModelName)
	Service.initialize(self, serviceName, dependencies)
	
	self.Player = player

	if userInterfaceModelName ~= nil and userInterfaceModelName ~= "" then
		self.UIModelTemplate = GetReplicatedStorage("UI/Models/" .. userInterfaceModelName)
	else
		self.UIModelTemplate = nil
	end

	if self.UIModelTemplate == nil then
		Service.Error(self, "Cannot find UI named " .. userInterfaceName .. ".")
	end

	self.UIModelModel = nil
	self.Initialized = false
end	

function UIModelReplicator:LoadUI(uiModelTemplate)
	
	if self.UIModel ~= nil then
		Service.Error(self, "Cannot give player ui they already have.")
		return -1
	end

	self.UIModelTemplate = GetReplicatedStorage("UI/Models/" .. uiModelTemplate)
	
	self.Player.PlayerGui:SetTopbarTransparency(0)
	self.UIModel = UITemplate:clone()
	
	self.UIModel.Parent = workspace
	self.Initialized = true

	return 0
end

function UIModelReplicator:UnloadUI()
	self.Initialized = false

	if self.UIModel == nil then
		return -1
	end
	
	self.Player.PlayerGui:SetTopbarTransparency(0)	
	self.UIModel.Parent = nil

	return 0
end

function UIModelReplicator:Update (step)
	if not self.Initialized then
		return
	end
	self:PositionUIModel()
end

return UIModelReplicator
