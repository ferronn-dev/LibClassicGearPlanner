local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')

local function gearPlannerUrl()
  local b = '\002\042\002\031\255'
  return ('https://classic.wowhead.com/gear-planner/'
     .. UnitClassBase('player'):lower()
     .. '/'
     .. UnitRace('player'):lower():gsub(' ', '-')
     .. '/'
     .. LibBase64.Encode(b):gsub('=', ''):gsub('/', '_'):gsub('+', '-'))
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
