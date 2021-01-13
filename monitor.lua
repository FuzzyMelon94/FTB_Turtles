-- v0.1.7
local monitor = {}

-- Prepares the monitor for use
function setup(mon)
    mon.clear()
    mon.setTextColor(colors.yellow)
    mon.setBackgroundColor(colors.black)
    mon.setTextScale(0.5)
    mon.clear()
end

-- Display a spinner at a position for a duration
function spinner(mon, x, y, speed, duration)
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
function progressBar(mon)
    print("To be implemented...")
end

-- Display a line of text with optional character delay and position
function text(mon, s, x, y, speed, clear)
    local x = x or 1
    local y = y or 1
    local speed = speed or 0
    local clear = clear or false
    local width, height = mon.getSize()
    local str = ""
    local offset = 0

    for i = 0, #s do
        str = s:sub(i, i)
        mon.setCursorPos(x + i - offset, y)
        mon.write(str)

        if str == "\n" then
            y = y + 1
            offset = i
        end

        sleep(speed)
    end

    if clear then
        for i = x + #s + 1, width do
            mon.setCursorPos(i, y)
            mon.write(" ")
        end
    end
end

-- Display multiple lines at once
function textAllLines(mon, str, x, y, speedX, speedY, clear)
    local x = x or 1
    local y = y or 1
    local speedX = speedX or 0
    local speedY = speedY or 0
    local clear = clear or false
    local width, height = mon.getSize()
    local lines = {}
    local longest = 0
    local char = ""

    -- Split the string into lines and add to table
    for s in string.gmatch(str, "[^\r\n]+") do
        table.insert(lines, s)
    end

    -- Calc longest line
    for i = 1, #lines do
        if #lines[i] > longest then
            longest = #lines[i]
        end
    end

    -- Print the lines at the same time
    for i = 0, longest do
        for j = 1, #lines do
            char = lines[j]:sub(i, i)
            mon.setCursorPos(x + i, y + j)
            mon.write(char)
            sleep(speedY)
        end
        sleep(speedX)
    end
end

-- Text that moves up the screen
function movingText(mon, s, x, y, distance, speed)
    local isUp = distance > 0
    local width, height = mon.getSize()

    text(s, x, y, true)
    for i = 1, distance do
        for i = 0, #s do
            mon.setCursorPos(x + i, y)
            mon.write(s:sub(i, i))
            sleep(speed)
        end

        if clear then
            for i = x + #s + 1, width do
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
function caret(mon, symbol, x, y, blinkRate, duration)
    local symbol = symbol or "_"
    local x = x or 1
    local y = y or 1
    local duration = duration or 60
    local showing = false

    for i = 0, duration do
        mon.setCursorPos(x, y)
        if i % 2 == 0 then
            mon.write(symbol)
        else
            mon.write(" ")
        end
        sleep(blinkRate)
    end
end

return monitor
