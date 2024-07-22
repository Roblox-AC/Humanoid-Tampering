-- Local Script: game.StarterPlayer.StarterPlayerScripts.Main
-- Author: Suno

-- Base logic, useful for finding when tampering occurs.

local Player = require(game.GetService(game, "ReplicatedStorage").Player)

while task.wait() do
  local PlayerData, Mismatches = Player.FetchClientData()

  if #Mismatches > 0 then
    while true do
      print("Oof.") -- If the loop runs, they won't be able to see this. (They crash)
    end
  end
end
