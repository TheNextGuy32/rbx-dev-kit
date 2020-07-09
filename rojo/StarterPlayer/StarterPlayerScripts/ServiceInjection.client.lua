local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))

local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):wait()

local playerServiceLocator = require(GetReplicatedStorage("Utility/Dependency/ServiceLocator")):new()

local source = GetReplicatedStorage("Source")
local serverLocation = "Client"

for p, projectFolder in pairs(source:GetChildren()) do
	local projectName = projectFolder.Name
    local projectFileName = projectName .. "/" .. projectName .. serverLocation .. "Project"
    local projectSearch = GetReplicatedStorage(projectFileName, source)

    if projectSearch ~= nil then 
        local project = require(projectSearch)
        playerServiceLocator:AddProject(project, player)
    end
end

playerServiceLocator:InjectServiceDependencies()

local controls = playerServiceLocator.Services["PlayerControlsReceiver"]
controls:ConnectEndpoints()