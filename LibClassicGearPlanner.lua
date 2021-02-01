local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')

local function gearPlannerUrl()
  return ('https://classic.wowhead.com/gear-planner/'
     .. UnitClassBase('player'):lower()
     .. '/'
     .. UnitRace('player'):lower():gsub(' ', '-')
     .. '/'
     .. LibBase64.Encode(''):gsub('=', ''))
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
