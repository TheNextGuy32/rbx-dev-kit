local GetReplicatedStorage = require(game.ReplicatedStorage:WaitForChild("GetReplicatedStorage"))
local Class = require(GetReplicatedStorage("middleclass"))
local ServiceTemplate = require(GetReplicatedStorage("Utility/Dependency/Service"))

local {{ serviceName }}Processor = Class("{{ serviceName }}Processor", ServiceTemplate)

function {{ serviceName }}Processor:initialize()
	local dependencies = { }
	ServiceTemplate.initialize(self, "{{ serviceName }}Processor", dependencies)
end

{% for event in events %}
function {{ serviceName }}Processor:Process{{ event.name }}({{ event.params }})
	print("{{ serviceName }}Processor -- Processing {{ event.name }}!")
end

{% endfor %}
return {{ serviceName }}Processor
