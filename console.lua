-- v0.1.0
-- Console settings
local termHeight = 13
local termWidth = 40

-- Text formatting
local top = "======================================="
local separator = "||-----------------------------------||"
local bottom = "======================================="
local edge = "||"

-- Program stats
local title = "Tom-Bot Controller [v0.1]"
local version = "v0.1"
local writeDelay = 0.2

-- Bot stats
local name = {
    title = "Name: ",
    prefix = "",
    suffix = "",
    screenX = 4,
    screenY = 4
}
local fuel = {
    title = "Fuel: ",
    prefix = "",
    suffix = "",
    screenX = 4,
    screenY = 5
}
local status = {
    title = "",
    prefix = "(",
    suffix = ")",
    screenX = 27,
    screenY = 4
}
local inventory = {
    title = "Inv: ",
    prefix = "",
    suffix = "%",
    screenX = 27,
    screenY = 4
}
local position = {
    title = "Position",
    prefix = "",
    suffix = "",
    screenX = 4,
    screenY = 6
}
local taskTitle = {
    title = "Current Task:",
    prefix = "",
    suffix = "",
    screenX = 4,
    screenY = 8
}
local taskValue = {
    title = "",
    prefix = "",
    suffix = "",
    screenX = 6,
    screenY = 9
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

-- Print the window
function writeWindow()
    for i = 1, termHeight do
        if i == 1 then -- Ln1 - top border
            term.setCursorPos(1, 1)
            write(top)
        elseif i == 3 then -- Ln3 - title separator
            term.setCursorPos(1, 3)
            write(separator)
        elseif i == 7 then -- Ln7 - data separator
            term.setCursorPos(1, 7)
            write(separator)
        else -- edges for all other lines
            term.setCursorPos(1, 2)
            write(edge)
            term.setCursorPos(1, termWidth - #edge)
            write(edge)
        end
        sleep(writeDelay)
    end

    term.setCursorPos(1, 13)
end

-- Print a field with a value
function writeField(field, value)
    term.setCursorPos(field.screenX, field.screenY)
    write(field.prefix .. field.title .. tostring(value) .. field.suffix)
    term.setCursorPos(1, 13)
end

-- Update a field with a new value
function updateFieldValue(field, value)
    term.setCursorPos(field.screenX + #field.prefix + #field.title, field.screenY)
    write(tostring(value))
    term.setCursorPos(1, 13)
end

-- Write default data
function writeDefaultData()
    writeField(name, "Jack")
    writeField(fuel, 100)
    writeField(status, "Idle")
    writeField(inventory, 50)
    writeField(position, "100, -300, 20")
    writeField(taskTitle, "")
    writeField(taskValue, "Taking a break")
end

-- Main program
term.clear()
writeWindow()
writeDefaultData()
sleep(2)

updateFieldValue(status, "Busy")
updateFieldValue(taskValue, "Returning to base")
local pos = {
    x = 100,
    y = -300,
    z = 20
}
for i = 1, 20 do
    updateFieldValue(fuel, 100 - i)
    updateFieldValue(inventory, 50 + i)

    local moveDirRand = math.random(1, 3)
    local moveAmount = 1
    if math.random(0, 1) == 1 then
        moveAmount = -1
    end

    if moveDirRand == 1 then
        pos.x = pos.x + moveAmount
    elseif moveDirRand == 2 then
        pos.y = pos.y + moveAmount
    else
        pos.z = pos.z + moveAmount
    end

    updateFieldValue(position, pos.x .. ", " .. pos.y .. ", " .. pos.z)
end

updateFieldValue(status, "Idle")
updateFieldValue(taskValue, "Resting at base")

print()
