lua_output_global = {}

-- Compute column spacing
local function tounits(val, units)
        return "\\Convert[unit = " .. units .. "]{" .. val .. "}"
end

-- Compute Background Params
local function backgroundanchor(margin)
        local headery = 4
        local anchorx = tostring(margin) .. "cm"
        local anchory = tostring(margin + headery) .. "cm"
        local bgwidth = "\\dimexpr \\paperwidth - " .. tostring(2 * margin) .. "cm \\relax"
        lua_output_global["anchorx"] = anchorx
        lua_output_global["anchory"] = anchory
        lua_output_global["bgwidth"] = bgwidth
end




local function printer(val)
        print("\n*********************************")
        print("Hello World")
        print(val)
        print("*********************************\n")
end

local function get_output(key)
        return lua_output_global[key]
end

return {tounits = tounits,
        printer = printer,
        get = get_output,
        bgxy = backgroundanchor}
