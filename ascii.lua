-- v0.1.0
-- Generate a string of ascii
function titleLine(width, text, fill, align, padding, padChar)
    local align = align or "c"
    local padding = padding or 1
    local padChar = padChar or " "
    local alignmentOffset = 4
    local strLeft = ""
    local strRight = ""
    local remaining = width - #text
    local isOdd = remaining % 2 == 1

    -- Generate using alignment
    if string.lower(align) == "l" then
        for i = 1, alignmentOffset do
            strLeft = strLeft .. fill
        end

        for i = 1, remaining - alignmentOffset do
            strRight = strRight .. fill
        end
    elseif string.lower(align) == "c" then
        for i = 1, (remaining / 2) - padding do
            strLeft = strLeft .. fill
            strRight = strRight .. fill
        end

        if isOdd then
            strRight = strRight .. fill
        end
    elseif string.lower(align) == "r" then
        for i = 1, alignmentOffset do
            strRight = strRight .. fill
        end

        for i = 1, remaining - alignmentOffset do
            strLeft = strLeft .. fill
        end
    else
        print("ASCII Line Generator - Invalid alignment: '" .. align .. "'")
        return
    end

    -- Add the padding
    for i = 1, padding do
        strLeft = strLeft .. padChar
        strRight = padChar .. strRight
    end
end

-- Creates an edge border line
function borderedLine(width, char, thickness, fill)
    local char = char or "|"
    local thickness = thickness or 2
    local fill = fill or " "
    local str = ""

    for i = 0, width do
        if i < thickness then
            str = str .. char
        elseif i > width - thickness then
            str = str .. char
        else
            str = str .. fill
        end
    end
end

-- Generate an entire window of ascii
function createWindow(width, height, title, separators, windowChars)
    local title = title or {
        text = "",
        line = 1
    }
    local separators = separators or {}
    local windowChars = windowChars or {
        top = "=",
        bottom = "=",
        side = "|",
        sep = "-",
        fill = " "
    }
    local windowString = ""

    -- create each line of the window using supplied settings
    for y = 0, height do
        if y == title.line then
            windowString = windowString .. titleLine(width, title.text, windowChars.fill) .. "\n"
        elseif helpers.contains(separators, y) then
            windowString = windowString .. borderedLine(width, windowChars.side, 1, windowChars.sep) .. "\n"
        else
            windowString = windowString .. borderedLine(width, windowChars.side, 1, windowChars.fill) .. "\n"
        end
    end
end
