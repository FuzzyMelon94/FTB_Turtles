-- v0.1.0
-- Output file help
local function printUsage()
    print("Usages:")
    print("rotate <current facing>")
end

-- Check user inputs
local args = {...}
if #args < 1 then
    printUsage()
    return
end
local facing = 1

-- Rotate to a random facing
function rotateRandom()
    local rot = math.random(1, 4)
    for i = 1, rot do
        turnLeft()
    end
end

-- Turn and track the facing
function turnLeft()
    turtle.turnLeft()
    facing = facing - 1

    if facing < 1 then
        facing = 4
    elseif facing > 4 then
        facing = 1
    end
end

-- Convert integer facing to a string
function facingToString(f)
    if f == 1 then
        return "North"
    elseif f == 2 then
        return "East"
    elseif f == 3 then
        return "South"
    elseif f == 4 then
        return "West"
    else
        return "Unknown"
    end
end

-- Main
print("Initial facing is " .. facingToString(facing))
rotateRandom()
print("Final facing is " .. facingToString(facing))
