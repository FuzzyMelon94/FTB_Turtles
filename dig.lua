-- v0.1.4
local xDist = 3
local yDist = 3
local zDist = 3

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
            turtle.forward()
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

-- Move forward a distance (y-direction)
function move(amount)
    for y = 1, yDist do
        turtle.forward()
    end
end

-- Return to the starting position
function toOrigin()
    local finalOdd = xDist % 2 == 1

    turn(finalOdd)
    move(xDist)
    turn(finalOdd)

    if finalOdd then
        move(yDist)
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
