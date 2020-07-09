local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))

local UIReplicator = Class("UIReplicator", Service)

function UIReplicator:initialize (serviceName, dependencies, player, userInterfaceName)
	Service.initialize(self, serviceName, dependencies)
	
	self.Player = player

	self.UITemplate = GetReplicatedStorage("UI/" .. userInterfaceName)

	if self.UITemplate == nil then
		Service.Error(self, "Cannot find UI named " .. userInterfaceName .. ".")
	end

	self.UI = nil
	self.Initialized = false
	self.GetUIReference = require(GetReplicatedStorage("Utility/UIReferenceFinder"))
end	

function UIReplicator:LoadUI()
	
	if self.UI ~= nil then
		error("Cannot give player mission ui they already have.")
		return
	end
	
	self.Player.PlayerGui:SetTopbarTransparency(0)
	self.UI = UITemplate:clone()
	
	self.UI.Parent = self.Player.PlayerGui 
	self.Initialized = true
end

function UIReplicator:UnloadUI()
	self.Initialized = false

	if self.UI == nil then
		return
	end
	
	self.Player.PlayerGui:SetTopbarTransparency(0)	
	self.UI.Parent = nil	
end

function UIReplicator:SetReferenceVisibility(referenceName, isVisible)
	local uiObject = self.GetUIRef(referenceName)
	uiObject.Visible = isVisible
end

function UIReplicator:SetReferenceColor(referenceName, color)
	local uiObject = self.GetUIRef(referenceName)
	uiObject.ImageColor3 = color
end

function UIReplicator:SetReferenceImageUrl(referenceName, imageUrl)
	local uiObject = self.GetUIRef(referenceName)
	uiObject.Image = imageUrl
end

function UIReplicator:GetUIRef(referenceName)
	if self.UI == nil then
		Service.Error(self, "Cannot alter visibility of reference when UI is not initialized.")
	end
	
	local uiObject = self:GetUIReference(referenceName, self.UI)
	if uiObject == nil then
		Service.Error(self, "Cannot find ui reference " .. referenceName .. ".")
		return nil
	end
	return uiObject
end

function UIReplicator:Update (step)
	if not self.Initialized then
		return
	end
end

return UIReplicator
