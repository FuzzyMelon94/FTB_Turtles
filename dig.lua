-- v0.1.5
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
            move(1, "f")
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
    turtle.forward()
    turn(isEven)
end

-- Move forward a distance in a direction
function move(amount, dir)
    for y = 1, amount do
        if dir == "f" then
            turtle.forward()
            yCurrent = yCurrent + 1
        elseif dir == "b" then
            turtle.back()
            yCurrent = yCurrent - 1
        elseif dir == "u" then
            turtle.up()
            zCurrent = zCurrent + 1
        elseif dir == "d" then
            turtle.down()
            zCurrent = zCurrent - 1
        else
            print("Not sure which direction to move, staying here.")
        end
    end
end

-- Return to the starting position
function toOrigin()
    local finalOdd = xCurrent % 2 == 1

    turn(finalOdd)
    move(xCurrent)
    turn(finalOdd)

    if finalOdd then
        move(yCurrent, "u")
    end

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
