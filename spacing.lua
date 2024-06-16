local function_container = {}
local variable_container = {}

-- Compute Background Params
local function backgroundmargin(margin_size)
        -- Local tables for temporary storage
        local size = tonumber(margin_size)
        local background = {}
        local anchor = {}
        anchor["x"] = tostring(size) .. "cm"
        anchor["y"] = tostring(size) .. "cm"
        background["width"]  = "\\dimexpr \\paperwidth - " .. tostring(2 * size) .. "cm \\relax"
        background["height"] = "\\dimexpr \\paperheight - ".. tostring(2 * size) .. "cm \\relax"
        -- Save background variables into global table
        background["anchor"] = anchor
        variable_container["background"] = background
end
function_container['backgroundmargin'] = backgroundmargin


-- Split strings by delimiter -- default is white space
local function split_string(input_string, delim)
        if delim == nil then delim = "%s" end
        local t = {}
        for str in string.gmatch(input_string, "([^" .. delim .. "]+)") do
                table.insert(t, #t+1, str)
        end
        return t
end

-- Join strings -- ie, remove whitespace
local function join_string(input_tab)
        local output = ''
        for k, v in ipairs(input_tab) do
                output = output .. v
        end
        return output
end

-- Get variables from 'container' of all variables
local function get(key)
        -- Tables indexed by white spaced delimited key
        local keyt = split_string(key)
        local output = nil
        -- Index 'container' until value is reached
        for k, v in ipairs(keyt) do
                if k == 1 then
                        output = variable_container[v]
                        goto continue -- do not modify self on first iteration
                end
                output = output[v]
                ::continue::
        end
        tex.print(output)
end

-- Set variables into 'container'
local function set(argument)
        -- Split variable and value
        local kv =  split_string(argument,'=')
        local key = join_string(split_string(kv[1]))
        local val = kv[2]
        -- Call function from tabl of functions
        function_container[key](val) 
end

return {get = get,
        set = set}
