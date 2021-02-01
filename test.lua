_G['strmatch'] = string.match
do
  local addonFiles = {
    'libbase64-1-0/LibStub/LibStub.lua',
    'libbase64-1-0/LibBase64-1.0.lua',
    'LibClassicGearPlanner.lua',
  }
  for _, file in ipairs(addonFiles) do
    dofile(file)
  end
end

local lib = _G['LibStub']:GetLibrary('LibClassicGearPlanner')
assert(lib.GenerateUrl() == 'https://classic.wowhead.com/gear-planner')
