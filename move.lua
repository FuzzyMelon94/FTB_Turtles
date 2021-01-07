-- v0.1.0
-- Output file help
local function printUsage()
    print("Usages:")
    print("move <x> <y> <z>")
end

-- Check user inputs
local args = {...}
if #args < 3 then
    printUsage()
    return
end

-- Turtle stats
local pos = { -- Starting pos
    x = 0, -- left
    y = 0, -- forward
    z = 0 -- up
}

-- Writes a line to the console - position can be specified
function writeLine(string, row, col, clear)
    local row = row or 1
    local col = col or 1
    local clear = clear or false

    if clear then
        term.clear()
    end

    term.setCursorPos(row, col)
    write(string)
end

-- Move forward a distance in a direction
function move(amount, dir, axis, returning)
    local zFlipped = pos.y % 2 == 1

    for i = 1, amount do
        -- Perform movement in the correct direction
        if dir == "f" then
            turtle.forward()
        elseif dir == "b" then
            turtle.back()
        elseif dir == "u" then
            turtle.up()
        elseif dir == "d" then
            turtle.down()
        else
            print("Not sure which direction to move, staying here.")
        end

        -- Update tracking var
        if axis == "x" then
            if returning then
                pos.x = pos.x - 1
            else
                pos.x = pos.x + 1
            end
        elseif axis == "y" then
            if returning then
                pos.z = pos.z - 1
            else
                pos.z = pos.z + 1
            end
        elseif axis == "z" then
            if returning then
                pos.y = pos.y - 1
            else
                pos.y = pos.y + 1
            end
        else
            print("Not sure which axis to adjust.")
        end
    end
end

-- Main
move(args[1], args[2], args[3])
