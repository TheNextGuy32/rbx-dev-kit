return function(position, lowerTorso)
	position = Vector3.new(position.X, lowerTorso.CFrame.p.Y, position.Z)
--	position = Vector3.new(position.X, lowerTorso.CFrame.p.Y, position.Z)
	lowerTorso.CFrame = CFrame.new(lowerTorso.Position,position)
end