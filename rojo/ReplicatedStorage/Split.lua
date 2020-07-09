return function (inputstr, sep)
    if sep == nil then
    	sep = "%s"
    end
    local t={}
	local i=1
	if inputstr == nil then
		return nil
	end
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
    end
    return t
end