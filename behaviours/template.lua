require "main.utils"

local Template = {}

-- Template microBehaviour
--@param agent table Current agent we are calculating the micro behavior for
--@param neighbours table Other agents within perception
--@param parameters table Parameters for the specific microbehavior
--@param environment table Environment of the coordinate we are on
function Template.microBehaviour(agent, neighbours, parameters, environment)
return vmath.vector3(0, 0, 0), true, { 
	["pheromone01"] = {
		["value"] = 10,
		["duration"] = 2
	}
}
end

return Template