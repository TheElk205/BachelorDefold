-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

environment = {}

dummy_environment_old = {
	{
		["x"] = 0,
		["y"] = 0,
		["values"] = {
			["my_key"] = {
				["initial_value"] = 10,
				["duration"] = 2,
				["started_at"] = 2
			}
		}
	}
}

dummy_environment = {
	{
		["x"] = 0,
		["y"] = 0,
		["radius"] = 20,
		["shape"] = "square",
		["key"] = "my_key",
		["created_at"] = 0, -- Used for sorting which variable with that key is relevant for given coordinates
		["value"] = {
			["initial_value"] = 10, -- value we start with
			["current_value"] = 10, -- current value acording to time and change_rate
			["change_rate"] = 0, -- change per second
			["duration"] = 2, -- If duration is over, it gets deleted. If duration negative, it will stay for ever
			["sprite"] = nil -- Sprite that is used to display the env variable
		}
	}
}

--Add new entry to the environment
--@param x number
--@param y number
--@param key string
--@param value table
function merge_into_environment(x, y, key, radius, shape, value, created_at)
	local default_value = {
		["initial_value"] = 10,
		["final_value"] = 2,
		["current_value"] = 10,
		["change_rate"] = 0,
		["duration"] = 0
	}
	table.insert(dummy_environment, {
		["x"] = x,
		["y"] = y,
		["key"] = key,
		["radius"] = radius,
		["shape"] = shape,
		["value"] = table_merge(default_value, value),
		["created_at"] = created_at
	})
	pprint(dummy_environment)
end

function get_current_env_value(position, key)
	local created_at = 0
	local value = 0
	-- print("getting current value " .. position)
	for k, v in pairs(dummy_environment) do
		-- Check for proper key at coordinate
		if v["key"] == key then
			pprint("x: " .. v["x"] - v["radius"] / 2 <= position["x"] .. " x: " .. v["x"] + v["radius"] / 2)

			if v["x"] - v["radius"] / 2 <= position["x"] and v["x"] + v["radius"] / 2 >= position["x"] and 
			v["y"] - v["radius"] / 2 <= position["y"] and v["y"] + v["radius"] / 2 >= position["y"] then
				if v["created_at"] > created_at then
					created_at = v["created_at"]
					value = v["value"]["current_value"]
				end
			end
		end
	end
	if created_at > 0 then
		return value
	end
	return nil
end

function table_merge(t1, t2)
	for k,v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end