-- v0.1.3
local xDist = 3
local yDist = 3
local zDist = 3

-- Dig forward (y)
function stripAndMove(amount)
    turtle.digUp()
    turtle.digDown()

    if amount >= 1 then
        for y = 1, amount - 1 do
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.digDown()
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

-- Return to the starting position
function toOrigin()
    local finalEven = xDist % 2 == 0

    turn(not finalEven)

    for y = 1, yDist do
        turtle.forward()
    end

    turn(finalEven)
end

-- The main program
function main()
    for x = 1, xDist do
        stripAndMove(yDist)

        if x ~= xDist then
            turnNextRow(x)
        end
    end
end

main()
