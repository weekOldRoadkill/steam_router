-- Imports
local argparse = require("argparse")
local http = require("socket.http")




-- Argument Parsing
local parser = argparse(
    "steam_router",
    "Finds the fastest path from one steam user to another going through users' friends lists."
)

parser:argument("key", "Steam Web API key.")
parser:argument("mode", "Determines whether it maps or paths."):choices({"map", "path"})
parser:argument("file", "Map filename.")
parser:argument("source", "Steam user ID to search from.")
parser:argument("target", "Steam user ID to search for.")
parser:argument("iterations", "Maximum search iterations. (default: 3)"):args("?")

local args = parser:parse()
args.iterations = tonumber(args.iterations) or 0x03




-- Get Friends Function
local count = 0x00
local function get_friends(user)
    local json
    repeat
        json = http.request("https://api.steampowered.com/ISteamUser/GetFriendList/v1/?key="..
        args.key.."&steamid="..user)
    until json

    local friends = {}
    for i in json:gmatch("\"%d+\"") do
        friends[#friends+0x01] = i:sub(0x02, -0x02)
    end

    count = count+0x01
    return friends
end




-- Code
if args.mode == "map" then
    local users = {}
    users[args.source] = get_friends(args.source)

    for i = 0x01, args.iterations do
        local temp = {}
        for k, v in pairs(users) do temp[k] = v end

        local done = false
        for k, v in pairs(temp) do
            for j = 0x01, #v do
                users[v[j]] = users[v[j]] or get_friends(v[j])
                if v[j] == args.target then done = true break end
                io.write(count.."\r")
                io.flush()
            end
        end
        if done then break end
    end

    print(count)
else
    error("Path mode not implemented yet.")
end
