local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))

local playerServiceLocator = require(GetReplicatedStorage("Utility/Dependency/ServiceLocator")):new()

local source = GetReplicatedStorage("Source")
local serverLocation = "Server"

for p, projectFolder in pairs(source:GetChildren()) do
	local projectName = projectFolder.Name

    local projectFileName = projectName .. "/" .. projectName .. serverLocation .. "Project"
    local projectSearch = GetReplicatedStorage(projectFileName, source)

    if projectSearch ~= nil then
        local project = require(projectSearch)
        playerServiceLocator:AddProject(project)
    end
end

playerServiceLocator:InjectServiceDependencies()