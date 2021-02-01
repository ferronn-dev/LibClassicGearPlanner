local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')

local function gearPlannerUrl()
  local talentBytes = '\031\255'
  return ('https://classic.wowhead.com/gear-planner/'
     .. UnitClassBase('player'):lower()
     .. '/'
     .. UnitRace('player'):lower():gsub(' ', '-')
     .. '/'
     .. LibBase64.Encode('\002'
         .. string.char(UnitLevel('player'))
         .. string.char(talentBytes:len())
         .. talentBytes
         .. ''):gsub('=', ''):gsub('/', '_'):gsub('+', '-'))
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
