-- Module to create bibliography
-- Wonderful idea by Skuost, Dec 5 2023
-- https://tex.stackexchange.com/questions/192917/include-all-bib-files-in-one-directory-to-a-bibliography

-- Checks whether directory exists or not
local function isDir(name)
    -- name must be a string input
	if type(name) ~= "string" then
		return false
	end
    -- Save current location
    local lfs = require("lfs")
	local cd = lfs.currentdir()
    -- Move to name
	local is = lfs.chdir(name) and true or false
    -- Return to original location
	lfs.chdir(cd)
	return is
end


-- Collect *.bib files in Bib directory
local function findBibFiles(folder)
	local files = {}
	local lfs = require("lfs")
    -- Confirm that folder is a directory
	if isDir(folder) then
        -- Save bibliography files in folder
		for file in lfs.dir(folder) do
			if file:match("%.bib$") then
				table.insert(files, folder .. "/" .. file)
			end
		end
	end
	return files
end

-- Assembles bibliography
local function printBibResources(folder)
	-- Get all bib files in folder
	local files = findBibFiles(folder)

	-- For each file, add the file to the bibliography
	for _, file in ipairs(files) do
		tex.print("\\addbibresource{" .. file .. "}")
	end
end

return { make = printBibResources }
