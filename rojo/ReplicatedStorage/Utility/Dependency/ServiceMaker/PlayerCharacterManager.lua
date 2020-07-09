local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))

local PlayerCharacterManager = Class("PlayerCharacterManager", Service)

function PlayerCharacterManager:initialize (serviceName, dependencies)
	Service.initialize(self, serviceName, dependencies)	
end	

function PlayerCharacterManager:AddPlayer(player)
    if player == nil then
        Service.Warn(self, "Cannot add a nil player on add.")
        return
    end

    self.Players[player.Name] = player
end

function PlayerCharacterManager:RemovePlayer(player)
    if player == nil then
        Service.Warn(self, "Cannot remove a nil player.")
        return
    end

    table.remove(self.Players, player.Name)
end

function PlayerCharacterManager:Update (step)
	
end

return PlayerCharacterManager
