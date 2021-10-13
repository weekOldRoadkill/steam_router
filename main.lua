-- Imports
local argparse = require("argparse")
local http = require("socket.http")




-- Code
local parser = argparse(
    "steam_router",
    "Finds the fastest path from one steam user to another going through users' friends lists.",
    "Have fun! :D"
)

parser:argument("key", "Steam Web API key.")
parser:argument("source", "Steam user ID to search from.")
parser:argument("target", "Steam user ID to search for.")

local args = parser:parse()

for k, v in pairs(args) do print(k.." = "..v) end
