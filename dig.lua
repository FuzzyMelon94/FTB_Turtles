local x = 3
local y = 3
local z = 3

for i = 1, z do
    local flip = false;
    for j = 1, y do
        for k = 1, x - 1 do
            turtle.dig()
            turtle.forward()
        end

        if flip then
            turtle.turnRight()
        else
            turtle.turnLeft()
        end

        if flip then
            turtle.turnRight()
        else
            turtle.turnLeft()
        end

        flip = not flip
    end
    turtle.digDown()
    turtle.down()
    flip = not flip
end
