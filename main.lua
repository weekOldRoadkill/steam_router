-- Imports
local argparse = require("argparse")
local http = require("socket.http")




-- Argument Parsing
local parser = argparse(
    "steam_router",
    "Finds the fastest path from one steam user to another going through users' friends lists."
)

parser:argument("key", "Steam Web API key.")
parser:argument("source", "Steam user ID to search from.")
parser:argument("target", "Steam user ID to search for.")

local args = parser:parse()




-- Code
local json = http.request("http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key="..
args.key.."&steamid="..args.source)

for id in json:gmatch("\"%d+\"") do
    print(id:sub(0x02, -0x02))
end
