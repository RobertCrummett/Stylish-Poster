-- Compute column spacing

local function tounits(val, units)
  return "\\Convert[unit = " .. units .. "]{" .. val .. "}"
end

local function printer(val)
  print("****************************")
  print(val)
  print("****************************")
  tex.print(val)
end

return {tounits = tounits, printer = printer}
