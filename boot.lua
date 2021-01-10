-- v0.1.3
-- Monitor settings
local mon = peripheral.wrap("top")
local monWidth, monHeight = mon.getSize()
local midX = monWidth / 2
local midY = monHeight / 2
local bootTime = 30

-- Boot text
local title = "=== Mini0n OS [v0.1.3] ==="
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
function writeLine(s, col, row, speed, clear)
    local col = col or 1
    local row = row or 1
    local speed = speed or 0
    local clear = clear or false

    for i = 1, #s do
        mon.setCursorPos(col + i, row)
        mon.write(s:sub(i, i))
        sleep(speed)
    end

    if clear then
        for i = col + #s + 1, monWidth do
            mon.setCursorPos(i, row)
            mon.write(" ")
        end
    end
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
            write(c)
        else
            write(" ")
        end
        sleep(0.5)
    end
end

-- Main program
setupMonitor()
sleep(2)

-- Display boot sequence
writeLine(title, midX - (#title / 2), midY - 1, 0.1, true)
sleep(0.5)
writeLine(state, midX - (#state / 2), midY, 0.1, true)
sleep(0.5)
displaySpinner(midX - (#state / 2), midY + 1, bootTime)

-- Show terminal
mon.clear()

mon.setCursorPos(1, monHeight)
writeLine(title, midX - (#title / 2), 1, 0.1, true)
writeLine("> ", 1, monHeight, 0, true)
displayBlinking()
