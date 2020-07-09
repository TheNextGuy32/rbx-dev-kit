local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))

local ServiceLocator = Class("ServiceLocator")

function ServiceLocator:initialize()
    self.Services = {}
end

function ServiceLocator:AddService(service)
    if service == nil then
        warn("Passed a null service.")
        return
    end
    if service.ServiceName == nil then
        error("Passed a service with a missing name.")
        return
    end
    if self.Services[service.ServiceName] ~= nil then
        warn("Attempting to add a second " .. service.ServiceName .. " service!")
        return
    end
    self.Services[service.ServiceName] = service

end

function ServiceLocator:AddProject(project, player)
    if project == nil then
        return
    end

    for serviceName, service in pairs(project) do
        self:AddService(service:new(player))
    end
end

function ServiceLocator:InjectServiceDependencies()
    local injectionMisses = 0

    for serviceName, service in pairs(self.Services) do
        for d, dependencyName in ipairs(service.Dependencies) do
            service:InjectDependency(dependencyName, self.Services[dependencyName])
        end
        injectionMisses = injectionMisses + service:VerifyDependencies()
    end

    if injectionMisses ~= 0 then
        error("Service injection failed! Missed " .. injectionMisses .. " dependencies.")
    else
		print("Services injected.")
    end
end

return ServiceLocator

