local Queue = {}
Queue.__index = Queue

function Queue.new ()
	return setmetatable({first = 0, last = -1}, Queue)
end

function Queue:Push (value)
	local newLast = self.last + 1
	self.last = newLast
	self[newLast] = value
end

function Queue:Peek()
	return self[self.first]
end

function Queue:Pop ()
	local first = self.first

	if first > self.last then 
		return nil
	end

	local value = self[first]
	self[first] = nil 
	self.first = first + 1
	
	return value
end

return Queue