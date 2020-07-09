return function(here, toThere, color3, duration)
	local beam = Instance.new("Part")
	if color3 ~= nil then
		beam.Color = color3
	else
		beam.BrickColor = BrickColor.new("Bright red")
	end
	
	beam.FormFactor = "Custom"
	beam.Material = "Neon"
	beam.Transparency = 0.25
	beam.Anchored = true
	beam.Locked = true
	beam.CanCollide = false
	
	local directionToHit = toThere - here
	local distance = (directionToHit).magnitude
	beam.Size = Vector3.new(0.3, 0.3, distance)
	beam.CFrame = CFrame.new(here, toThere) * CFrame.new(0, 0, -distance / 2)
	beam.Parent = workspace.UI
	
	local deathTimer = duration ~= nil and duration or 0.05
	game:GetService("Debris"):AddItem(beam, deathTimer)
end