require "main.utils"

local Boids = {}

-- Boids separation
--@param agent table
--@param neighbours table
--@param parameters table
function Boids.separation(agent, neighbours, parameters, environment)
	-- Calculate separation
	local separation = vmath.vector3(0,0,0)
	local alpha = parameters["separation"]
	for k, v in pairs(neighbours) do
		separation = separation + (agent["position"] - v["position"])
	end
	separation = -separation * alpha
	return separation, true, {}
end

-- Boids cohesion
--@param agent table
--@param neighbours table
--@param parameters table
function Boids.cohesion(agent, neighbours, parameters, environment)
	-- Calculate cohesion
	local cohesion = vmath.vector3(0,0,0)
	local beta = parameters["cohesion"]
	for k, v in pairs(neighbours) do
		cohesion = cohesion + v["position"]
	end
	cohesion = cohesion / math.max(1, table.getKeyCount(neighbours))
	pprint(agent["position"])
	pprint(cohesion)
	pprint(beta)
	cohesion = (cohesion - agent["position"]) * beta
	return cohesion, true, {}
end

-- Boids alignment
--@param agent table
--@param neighbours table
--@param parameters table
function Boids.alignment(agent, neighbours, parameters, environment)
	-- Calculate Alignment
	local alignment = vmath.vector3(0,0,0)
	local gamma = parameters["alignment"]
	for k, v in pairs(neighbours) do
		alignment = alignment + (agent["velocity"] - v["velocity"])
	end
	alignemnt = -alignment * gamma

	return alignment, true, {}
end

return Boids