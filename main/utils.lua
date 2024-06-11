function print_line(...)
	print(debug.getinfo(2).short_src .. ":" .. debug.getinfo(2).currentline)
	print(...)
end

function pprint_line(...)
	print(debug.getinfo(2).short_src .. ":" .. debug.getinfo(2).currentline)
	pprint(...)
end

function table.getKeyCount(neighbours)
	local count = 0
	for k, v in pairs(neighbours) do
		if k ~= nil then
			count = count + 1
		end
	end
	return count
end

function angle_between_vectors(v0, v1)
	-- simplified to two dimensions
	return math.deg(math.atan2(v1.y*v0.x - v1.x*v0.y, v1.x*v0.x + v1.y*v0.y))
end

function rotate_vector(v0, angle_degree)
	return vmath.vector3(v0.x * math.cos(angle_degree) - v0.y * math.sin(angle_degree), 
	v0.x * math.sin(angle_degree) + v0.y * math.cos(angle_degree),
	v0.z)
end