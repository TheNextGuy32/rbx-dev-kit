local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))

local Controller = Class("Controller", Service)

local Players = game:GetService("Players")

function Controller:initialize (serviceName, dependencies)
	Service.initialize(self, serviceName, dependencies)
	
end	

function Controller:ConnectEndpoints()
	Players.PlayerAdded:Connect(function(player)
		self:OnPlayerAdded(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:OnPlayerRemoved(player)
	end)
end

function Controller:OnPlayerAdded(player)
    if player == nil then
        Service.Warn(self, "Cannot add a nil player on add.")
        return
    end

    self.Players[player.Name] = player
end

function Controller:OnPlayerRemoved(player)
    if player == nil then
        Service.Warn(self, "Cannot remove a nil player.")
        return
    end

    table.remove(self.Players, player.Name)
end

function Controller:Update (step)
	
end

return Controller
