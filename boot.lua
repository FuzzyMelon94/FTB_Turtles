-- v0.1.6
-- Monitor settings
local mon = peripheral.wrap("top")
local monWidth, monHeight = mon.getSize()
local midX = monWidth / 2
local midY = monHeight / 2
local bootTime = 30
local writeSpeed = 0.2
local spinnerSpeed = 0.1
local cursorBlinkRate = 0.5

-- Boot text
local title = "=== Mini0n OS [v0.1.6] ==="
local state = "Booting..."

-- Prepares the monitor for use
function setupMonitor()
    mon.clear()
    mon.setTextColor(colors.yellow)
    mon.setBackgroundColor(colors.black)
    mon.setTextScale(0.5)
    mon.clear()
end

-- Write a line at a position, with character delay and clearing if required
function writeLine(s, col, row, clear)
    local col = col or 1
    local row = row or 1
    local clear = clear or false

    for i = 1, #s do
        mon.setCursorPos(col, row)
        mon.write(s:sub(i, i))
        sleep(writeSpeed)
    end

    if clear then
        for i = col + #s + 1, monWidth do
            mon.setCursorPos(i, row)
            mon.write(" ")
        end
    end
end

-- Moves a line up or down the monitor
function moveLines(s, col, rowStart, distance)
    local rowStart = rowStart or 1
    local distance = 5
    local isUp = distance < 0

    writeLine(s, col, rowStart, true)
    for i = 1, distance do
        writeLine(s, col, rowStart + i, true)
        writeLine(" ", col, rowStart + i - 1, true)
    end
    writeLine(" ", col, rowStart + distance - 1, true)
end

-- Display a spinner at a position for a duration
function displaySpinner(col, row, duration)
    local spinA = "-"
    local spinB = "\\"
    local spinC = "|"
    local spinD = "/"

    for i = 1, duration do
        step = i % 4
        mon.setCursorPos(col, row)

        if step == 0 then
            mon.write(spinA)
        elseif step == 1 then
            mon.write(spinB)
        elseif step == 2 then
            mon.write(spinC)
        else
            mon.write(spinD)
        end

        sleep(spinnerSpeed)
    end
end

-- ! Display blinking caret - interrupt to be added
function displayBlinking(c, col, row, duration)
    local c = c or "_"
    local col = col or 1
    local row = row or 1
    local duration = duration or 60
    local showing = false

    for i = 0, duration do
        mon.setCursorPos(col, row)
        if i % 2 == 0 then
            mon.write(c)
        else
            mon.write(" ")
        end
        sleep(cursorBlinkRate)
    end
end

-- Main program
setupMonitor()
sleep(2)

-- Display boot sequence
writeLine(title, midX - (#title / 2), midY - 1, true)
sleep(0.5)
writeLine(state, midX - (#state / 2), midY, true)
sleep(0.5)
displaySpinner(midX, midY + 1, bootTime)
sleep(0.5)

-- Show terminal
mon.clear()

mon.setCursorPos(1, monHeight)
writeLine(title, midX - (#title / 2), 1, true)
writeLine(">", 1, monHeight, true)
sleep(0.5)
displayBlinking("_", 2, monHeight, 30)
