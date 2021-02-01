local function gearPlannerUrl()
  return 'https://classic.wowhead.com/gear-planner'
end

local lib = _G['LibStub']:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
