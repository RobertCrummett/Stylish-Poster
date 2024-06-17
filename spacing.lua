local function_container = {}
local variable_container = {}

-- Compute logo margin
local function logomargin(size)
        local logo = {}
        local anchor = {}
        logo['margin'] = size .. 'cm'
        logo['anchor'] = anchor
end
function_container['logomargin'] = logomargin

-- Compute title dimensions
local function titleheight(size)
        local title = {}
        title['height'] = tostring(size) .. 'cm'
        title['width'] = '\\paperwidth'

        title['top'] = '0cm'
        title['bottom'] = title['height']
        title['left'] = '0cm'
        title['right'] = title['width']
        variable_container['title'] = title
end
function_container['titleheight'] = titleheight

-- Compute background dimensions
local function backgroundmargin(margin_size)
        -- Local tables for temporary storage
        local size = tonumber(margin_size)
        local background = {}
        local anchor = {}
        background["margin"] = tostring(size) .. "cm"
        anchor["x"] = background["margin"]
        anchor["y"] = background["margin"]
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

-- Set up variables at runtime
local function setup_at_runtime()
        -- Get internal dimensions of border
        local background_margin = variable_container["background"]["margin"]
        local title_height = variable_container["title"]["height"]
        local background_x = variable_container["background"]["anchor"]["x"]
        local background_w = variable_container["background"]["width"]

        local internal = {}
        internal["top"] = title_height
        internal["bottom"] = "\\dimexpr \\paperheight - " .. background_margin .. " \\relax"
        internal["left"] = background_x
        internal["right"] = "\\dimexpr \\paperwidth - " .. background_x .. " \\relax"
        internal["height"] = "\\dimexpr \\paperheight - " .. title_height .. " - " .. background_margin .. " \\relax"
        internal["width"] = background_w
        
        local internal_margin = {}
        internal_margin["value"] = background_margin
        internal_margin["top"] = "\\dimexpr " .. internal["top"] .. " + " .. internal_margin["value"] .. " \\relax"
        internal_margin["bottom"] = "\\dimexpr " .. internal["bottom"] .. " - " .. internal_margin["value"] .. " \\relax"
        internal_margin["right"] = "\\dimexpr " .. internal["right"] .. " - " .. internal_margin["value"] .. " \\relax"
        internal_margin["left"] = "\\dimexpr " .. internal["left"] .. " + " .. internal_margin["value"] .. " \\relax"
        internal_margin["height"] = "\\dimexpr " .. internal_margin["bottom"] .. " - " .. internal_margin["top"] .. " \\relax"
        internal_margin["width"] = "\\dimexpr " .. internal_margin["right"] .. " - " .. internal_margin["left"] .. " \\relax"
        
        
        internal["margin"] = internal_margin
        variable_container["internal"] = internal
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
        set = set,
        setup = setup_at_runtime}
