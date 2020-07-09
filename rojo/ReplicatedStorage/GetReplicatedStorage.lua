return function(path, beginWith)
	if path == nil then
		return nil
	end
	local Split = require(script.Parent.Split)
	local paths = Split(path, "/")
	if paths == nil then
		print("Error with path " .. path)
		return nil
	end
	local item = game.ReplicatedStorage
	if beginWith ~= nil then
		item = beginWith
	end
	for i, nextPathItem in ipairs(paths) do
		item = item:WaitForChild(nextPathItem)
	end
	return item
end