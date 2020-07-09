local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))
local Roact = require(GetReplicatedStorage("Roact/init"))

local RoactUIReplicator = Class("RoactUIReplicator", Service)

function RoactUIReplicator:initialize (serviceName, dependencies, player)
	Service.initialize(self, serviceName, dependencies)
	
	self.Player = player

	self.UI = nil
	self.Initialized = false
end	

function RoactUIReplicator:LoadUI()
	
	if self.UI ~= nil then
		error("Cannot give player mission ui they already have.")
		return
	end
	
	local application = self:BuildApplication()
	
	self.UI = Roact.mount(application, self.Player.PlayerGui, self.ServiceName)
	self.Initialized = true
end

function RoactUIReplicator:BuildApplication()
	return Roact.createElement("ScreenGui", {}, {
		HelloWorld = Roact.createElement("TextLabel", {
			Size = UDim2.new(0, 400, 0, 300),
			Text = "Default Application"
		})
	})
end

function RoactUIReplicator:UnloadUI()
	if self.UI == nil then
		return
	end

	Roact.unmount(self.UI)
	self.Initialized = false
end

function RoactUIReplicator:Update (step)
	if not self.Initialized then
		return
	end
end

return RoactUIReplicator
