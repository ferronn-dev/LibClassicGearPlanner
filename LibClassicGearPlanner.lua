local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')

local function getTalentBytes()
  local t = ''
  for i = 1, GetNumTalentTabs() do
    for j = 1, GetNumTalents(i) do
      t = t .. string.char(select(6, GetTalentInfo(i, j)))
    end
    t = t:gsub('\0*$', '\15')
  end
  local r = ''
  for i = 1, t:len(), 2 do
    local hi = t:sub(i, i):byte()
    local lo = i ~= t:len() and t:sub(i + 1, i + 1):byte() or 0
    r = r .. string.char(hi * 16 + lo)
  end
  return r
end

local function getInventoryBytes()
  local r = ''
  for slot = 1, 18 do
    if slot ~= 4 then
      local link = GetInventoryItemLink('player', slot)
      if link then
        local _, id, _, _, _, _, _, rand = strsplit(':', link)
        local b = ''
        if rand ~= '' then
          slot = slot + 64
          b = string.pack('>I2', tonumber(rand))
        end
        r = r .. string.pack('>BI2', slot, tonumber(id)) .. b
      end
    end
  end
  return r
end

local function gearPlannerUrl()
  local talentBytes = getTalentBytes()
  return ('https://classic.wowhead.com/gear-planner/'
     .. UnitClassBase('player'):lower()
     .. '/'
     .. UnitRace('player'):lower():gsub(' ', '-')
     .. '/'
     .. LibBase64.Encode('\002'
         .. string.char(UnitLevel('player'))
         .. string.char(talentBytes:len())
         .. talentBytes
         .. getInventoryBytes()
         .. ''):gsub('=', ''):gsub('/', '_'):gsub('+', '-'))
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
