-- v0.1.0
local monitor = {}

-- Monitor settings
local mon = peripheral.wrap("top")
local monWidth, monHeight = mon.getSize()
local midX = monWidth / 2
local midY = monHeight / 2

-- Prepares the monitor for use
function setupMonitor()
    mon.clear()
    mon.setTextColor(colors.yellow)
    mon.setBackgroundColor(colors.black)
    mon.setTextScale(0.5)
    mon.clear()
end

-- Display a spinner at a position for a duration
function spinner(x, y, speed, duration)
    local spinA = "-"
    local spinB = "\\"
    local spinC = "|"
    local spinD = "/"

    for i = 1, duration do
        step = i % 4
        mon.setCursorPos(x, y)

        if step == 0 then
            mon.write(spinA)
        elseif step == 1 then
            mon.write(spinB)
        elseif step == 2 then
            mon.write(spinC)
        else
            mon.write(spinD)
        end

        sleep(speed)
    end

    mon.setCursorPos(x, y)
    mon.write(spinA)
end

-- Display a progress bar at a position with length and style
function progressBar()
    print("To be implemented...")
end

-- Display a line of text with optional character delay and position
function text(s, x, y, speed, clear)
    local x = x or 1
    local y = y or 1
    local speed = speed or 0
    local clear = clear or false

    for i = 0, #s do
        mon.setCursorPos(x + i, y)
        mon.write(s:sub(i, i))
        sleep(speed)
    end

    if clear then
        for i = x + #s + 1, monWidth do
            mon.setCursorPos(i, y)
            mon.write(" ")
        end
    end
end

-- Text that moves up the screen
function movingText(s, x, y, distance)
    local y = y
    local isUp = distance > 0

    text(s, x, y, true)
    for i = 1, distance do
        for i = 0, #s do
            mon.setCursorPos(x + i, y)
            mon.write(s:sub(i, i))
            sleep(speed)
        end

        if clear then
            for i = x + #s + 1, monWidth do
                mon.setCursorPos(i, y)
                mon.write(" ")
            end
        end

        writeLine(s, x, y + i, true)
        writeLine(" ", x, y + i - 1, true)
    end
    writeLine(" ", x, y + distance - 1, true)
end

-- Show a blinking cursor for input
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

return monitor
