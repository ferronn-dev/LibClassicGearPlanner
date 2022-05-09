local LibBase64 = LibStub:GetLibrary('LibBase64-1.0')
local EnchantDB = LibStub:GetLibrary('LibClassicGearPlanner-EnchantDB')

local function getTalentBytes()
  local t = ''
  for i = 1, GetNumTalentTabs() do
    for j = 1, GetNumTalents(i) do
      local count = select(5, GetTalentInfo(i, j))
      t = t .. string.char(count)
    end
    t = t:gsub('%z*$', '') .. '\15'
  end
  local r = ''
  for i = 1, t:len(), 2 do
    local hi = t:sub(i, i):byte()
    local lo = i ~= t:len() and t:sub(i + 1, i + 1):byte() or 0
    r = r .. string.char(hi * 16 + lo)
  end
  return r
end

local function pack16(n)
  return string.char(math.floor(n / 256)) .. string.char(math.fmod(n, 256))
end

local function getInventoryBytes()
  local r = ''
  for slot = 1, 18 do
    if slot ~= 4 then
      local link = GetInventoryItemLink('player', slot)
      if link then
        local _, id, ench, _, _, _, _, rand = strsplit(':', link)
        local sb = slot
        local b = ''
        if ench ~= '' then
          local st = EnchantDB[slot]
          local v = st and st[tonumber(ench)] or nil
          if v ~= nil then
            sb = sb + 128
            b = b .. pack16(v)
          else
            print('[LibClassicGearPlanner]: failed on slot ' .. slot)
          end
        end
        if rand ~= '' then
          sb = sb + 64
          b = b .. pack16(tonumber(rand))
        end
        r = r .. string.char(sb) .. pack16(tonumber(id)) .. b
      end
    end
  end
  return r
end

local function gearPlannerUrl()
  if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
    return nil
  end
  local talentBytes = getTalentBytes()
  return (
      'https://classic.wowhead.com/gear-planner/'
      .. UnitClassBase('player'):lower()
      .. '/'
      .. UnitRace('player'):lower():gsub(' ', '-')
      .. '/'
      .. LibBase64.Encode(
        '\002'
          .. string.char(UnitLevel('player'))
          .. string.char(talentBytes:len())
          .. talentBytes
          .. getInventoryBytes()
          .. ''
      ):gsub('=', ''):gsub('/', '_'):gsub('+', '-')
    )
end

local lib = LibStub:NewLibrary('LibClassicGearPlanner', 1)
if lib then
  lib.GenerateUrl = gearPlannerUrl
end
