-- Module Script: game.ReplicatedStorage.Player
-- Author: Suno

-- This is the main logic of the Anti Tamper.

local Information = {}

local Constants = {
  ["Services"] = {
    ["Players"] = game.GetService(game, "Players")
  },

  ["Hardcoded"] = {
    ["AutoJumpEnabled"] = true,
    ["AutoRotate"] = true,
    ["AutomaticScalingEnabled"] = true,
    ["BreakJointsOnDeath"] = true,
    ["DisplayDistanceType"] = Enum.HumanoidDisplayDistanceType.Viewer,
    ["HealthDisplayDistance"] = 100,
    ["HealthDisplayType"] = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged,
    ["HipHeight"] = 2,
    ["JumpPower"] = 50,
    ["MaxHealth"] = 100,
    ["MaxSlopeAngle"] = 89,
    ["NameDisplayDistance"] = 100,
    ["NameOcclusion"] = Enum.NameOcclusion.OccludeAll,
    ["WalkSpeed"] = 16,
  }
}

local LocalPlayer = Constants.Services.Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Humanoid = Character.Humanoid or Character:WaitForChild("Humanoid", 10)
local RootPart = Character.HumanoidRootPart or Character:WaitForChild("HumanoidRootPart", 10)

local function CompareValues(Actual, Expected)
  if typeof(Actual) == "number" and typeof(Expected) == "number" then
    return math.abs(Actual - Expected) < 0.5
  else
    return Actual == Expected
  end
end

Information.FetchClientData = function()
  local PlayerData = {}
  local Mismatches = {}

  for Property, Expected in pairs(Constants.Hardcoded) do
    local Success, Value = pcall(function()
      return Humanoid[Property]
    end)

    if Success then
      PlayerData[Property] = Value do
        if not CompareValues(Value, Expected) then
          table.insert(Mismatches, {
            Property = Property,
            Expected = Expected,
            Actual = Value
          })
        end
      end
    else
      PlayerData[Property] = "Error reading property." do
        table.insert(Mismatches, {
          Property = Property,
          Expected = Expected,
          Actual = "Error reading property."
        })
      end
    end
  end

  return PlayerData, Mismatches
end

return Information
