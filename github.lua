-- v1.0.8
local github = {}
-- GitHub QoL Variables
local sUser = "username"
local sRepo = "repository"

-- Repurposed from ComputerCraft repo, modified "pastebin.lua"
local function printUsage()
    print("Usages:")
    print("github get <url> <filename>")
end

-- Check user inputs
local tArgs = {...}
if #tArgs < 3 then
    printUsage()
    return
end

-- Get the file from GitHub
local function get(sUrl)
    local cacheBuster = tostring(math.random(1, 999999))
    print("Downloading [" .. sUrl .. "] from GitHub")
    local response = http.get("http://raw.githubusercontent.com/" .. textutils.urlEncode(sUrl) .. "?" ..
                                  textutils.urlEncode(cacheBuster))
    if response then
        print("Success.")

        local sResponse = response.readAll()
        response.close()
        return sResponse
    else
        print("Failed.")
    end
end

-- Download the requested file and save it
local function download(sUrl, sFile)
    local sPath = shell.resolve(sFile)

    -- Ensure the file doesn't already exist
    if fs.exists(sPath) then
        print("File already exists")
        return
    end

    -- Get file from GitHub
    local fullUrl = sUser .. "/" .. sRepo .. "/" .. sUrl
    local res = get(fullUrl)
    if res then
        local file = fs.open(sPath, "w")
        file.write(res)
        file.close()

        print("Downloaded as " .. sFile)
    end
end

-- Main program
local sCommand = tArgs[1]
if sCommand == "get" then
    -- Ensure inputs valid
    if #tArgs < 3 then
        printUsage()
        return
    end

    download(tArgs[2], tArgs[3])
end

return github
