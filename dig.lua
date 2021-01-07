-- v0.1.2
local xDist = 3
local yDist = 3
local zDist = 3

-- Dig for x
function stripAndMove(amount)
    turtle.digUp()
    turtle.digDown()

    if amount >= 1 then
        for x = 0, amount do
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
    stripAndMove(0)
end

-- Main
stripAndMove(3)
turnNextRow(1)
stripAndMove(3)
turnNextRow(2)
