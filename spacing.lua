lua_output_global = {}

-- Compute column spacing
local function tounits(val, units)
        return "\\Convert[unit = " .. units .. "]{" .. val .. "}"
end

-- Compute Background Params
local function background(margin)
        -- Local tables for temporary storage
        local background = {}
        local anchor = {}
        anchor["x"] = tostring(margin) .. "cm"
        anchor["y"] = tostring(margin) .. "cm"
        background["width"]  = "\\dimexpr \\paperwidth - " .. tostring(2 * margin) .. "cm \\relax"
        background["height"] = "\\dimexpr \\paperheight - ".. tostring(2 * margin) .. "cm \\relax"
        
        -- Save background variables into global table
        background["anchor"] = anchor
        lua_output_global["background"] = background
end


local function printer(val)
        print("\n*********************************")
        print("Hello World")
        print(val)
        print("*********************************\n")
end

-- Split strings by delimiter -- default is white space
local function split_string(input_string, delim)
        if delim == nil then
                delim = "%s"
        end
        local t = {}
        for str in string.gmatch(input_string, "([^" .. delim .. "]+)") do
                table.insert(t, #t+1, str)
        end
        return t
end

-- Getter -- Access global output table by white space delimited string
local function get_output(key)
        local keyt = split_string(key)
        local output = nil
        for k, v in ipairs(keyt) do
                if k == 1 then
                        output = lua_output_global[v]
                        goto continue 
                end
                output = output[v]
                ::continue::
        end
        return output
end

return {tounits = tounits,
        printer = printer,
        get = get_output,
        background = background}
