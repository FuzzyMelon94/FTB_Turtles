-- v0.1.6
-- Default dig dimensions
local xDist = 3
local yDist = 3
local zDist = 3

-- Current movement
local xCurrent = 0
local yCurrent = 0
local zCurrent = 0

-- Dig above and below
function digVertical()
    while turtle.detectUp() do
        turtle.digUp()
    end

    while turtle.detectDown() do
        turtle.digDown()
    end
end

-- Dig above and below and move forward (y-direction)
function stripAndMove(amount)
    digVertical()

    if amount >= 1 then
        for y = 1, amount - 1 do
            if turtle.detect() then
                turtle.dig()
            end
            move(1, "f", "y")
            digVertical()
        end
    end
end

-- Turn based on falisty
function turn(isLeft)
    if isLeft then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
end

-- Turn around for the next row
function turnNextRow(rowNum)
    local isEven = false
    if rowNum % 2 == 0 then
        isEven = true
    end

    turn(isEven)
    turtle.dig()
    move(1, "f", "x")
    turn(isEven)
end

-- Move forward a distance in a direction
function move(amount, dir, axis, returning)
    local returning = returning or false
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
                xCurrent = xCurrent - 1
            else
                xCurrent = xCurrent + 1
            end
        elseif axis == "y" then
            if returning then
                yCurrent = yCurrent - 1
            else
                yCurrent = yCurrent + 1
            end
        elseif axis == "z" then
            if returning then
                zCurrent = zCurrent - 1
            else
                zCurrent = zCurrent + 1
            end
        else
            print("Not sure which axis to adjust.")
        end
    end
end

-- Return to the starting position
function toOrigin()
    local finalOdd = xCurrent % 2 == 1

    -- Reset the x position
    turn(finalOdd)
    move(xCurrent, "f", "x", true)
    turn(finalOdd)

    -- Reset the y position
    if finalOdd then
        move(yCurrent, "f", "y", true)
    end

    -- Reset the z position
    move(zCurrent, "u", "z", true)
end

-- The main program
function main()
    for x = 1, xDist do
        stripAndMove(yDist)

        if x ~= xDist then
            turnNextRow(x)
        end
    end
    toOrigin()
end

main()
