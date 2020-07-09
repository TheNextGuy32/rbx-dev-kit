local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local Service = require(GetReplicatedStorage("Utility/Dependency/Service"))

local Listener = Class("Listener", Service)

function Listener:initialize(serviceName, dependencies)
    Service.initialize(self, serviceName, dependencies)
end

function Listener:ConnectEndpoints(isServer, eventFolderName, eventNames)
	local eventFolder = GetReplicatedStorage("Events/" .. eventFolderName)
    for i, eventName in pairs(eventNames) do 
        local direction = isServer and "Request" or "Receive"
        local requestEventName = direction .. eventName

        local event = GetReplicatedStorage(requestEventName, eventFolder)
        if event ~= nil then
            self[requestEventName] = event
            if isServer then
                self[requestEventName].OnServerEvent:Connect(self[eventName])
            else
                self[requestEventName].OnClientEvent:Connect(self[eventName])
            end
        else
            error(eventFolderName .. "/" .. requestEventName .. " is missing.")
        end
    end
end

return Listener

