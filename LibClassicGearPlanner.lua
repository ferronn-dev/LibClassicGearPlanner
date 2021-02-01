local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')

local function gearPlannerUrl()
  return ('https://classic.wowhead.com/gear-planner/'
     .. UnitRace('player'):lower():gsub(' ', '-')
     .. '/'
     .. UnitClassBase('player'):lower()
     .. '/'
     .. LibBase64.Encode(''):gsub('=', ''))
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
