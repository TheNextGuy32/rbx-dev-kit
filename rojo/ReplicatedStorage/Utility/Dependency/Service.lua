local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))

local Service = Class("Service")

function Service:initialize(serviceName, dependencies)
    if not (serviceName == nil or serviceName == "") then
        self.ServiceName = serviceName
    else
        self.ServiceName = "DefaultService"
    end

    if dependencies ~= nil then 
        self.Dependencies = dependencies
    else
        self.Dependencies = {}
    end
end

function Service:InjectDependency(dependencyName, dependency)
    self[dependencyName] = dependency
end

function Service:VerifyDependencies()
    local injectionMisses = 0
    for d, dependencyName in ipairs(self.Dependencies) do
        if self[dependencyName] == nil then
          warn(self.ServiceName .. " is missing " .. dependencyName)
          injectionMisses = injectionMisses + 1
        end
    end
    return injectionMisses
end

function Service:Print(string)
    print(self.ServiceName .. " -- " .. string)
end

function Service:Warn(string)
    warn(self.ServiceName .. " -- " .. string)
end

function Service:Error(string)
    error(self.ServiceName .. " -- " .. string)
end

return Service