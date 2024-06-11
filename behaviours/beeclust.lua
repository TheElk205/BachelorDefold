require "main.utils"

local Beeclust = {}

-- Beeclust waiting
--@param agent table
--@param neighbours table
--@param parameters table
function Beeclust.waiting(agent, neighbours, parameters, environment)
    pprint(parameters)
	local hitDistance = parameters["hit_distance"]
	local maxWaitTime = parameters["max_wait_time"]
    local timeOffset = parameters["time_offset"]

	for k, v in pairs(neighbours) do
        -- If neighbour is within hit distance, we calculate a hit
		if math.abs(vmath.length(v["position"] - agent["position"])) <= hitDistance then
            print("found neighbour in hit distance: " .. math.abs(vmath.length(v["position"] - agent["position"])))
            local temperature_square = 0
            -- If we have no temperature, waiting time is only defined by maxWaitTime and the timeOffset
            if environment["temperature"] ~= nil then
                temperature_square = environment["temperature"] * environment["temperature"]
            end
            local waitingTime = (maxWaitTime * temperature_square) / (temperature_square + timeOffset)
            local envKey = agent["number"] .. "_waiting"
            return vmath.vector3(0,0,0), false, {
                [envKey] = {
                    ["value"] = 1,
		            ["duration"] = waitingTime
                }
            }
        end
	end
	return vmath.vector3(0,0,0), true, {}
end

-- Beeclust random walk
--@param agent table
--@param neighbours table
--@param parameters table
function Beeclust.randomWalk(agent, neighbours, parameters, environment)
	local max_angle = parameters["max_angle"]
    local wiggleBy = (math.random() + math.random(0, max_angle*2)) / 2

    local newVelocity = rotate_vector(agent["velocity"], wiggleBy)
	return newVelocity, true, {}
end

return Beeclust