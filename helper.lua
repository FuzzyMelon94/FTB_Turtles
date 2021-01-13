-- v0.1.0
-- Returns true if the specified table contains the value
function contains(table, value)
    for i = 1, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end
