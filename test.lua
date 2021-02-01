local state

do
  env = {
    strmatch = string.match,
    UnitClassBase = function(unit)
      assert(unit == 'player')
      return state.class
    end,
    UnitRace = function(unit)
      assert(unit == 'player')
      return state.race
    end,
  }
  for k, v in pairs(env) do
    _G[k] = v
  end
end

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

do
  local lib = _G['LibStub']:GetLibrary('LibClassicGearPlanner')
  local tests = {
    {
      state = {
        class = 'Warrior',
        race = 'Night Elf',
      },
      url = 'https://classic.wowhead.com/gear-planner/night-elf/warrior/',
    },
    {
      state = {
        class = 'Hunter',
        race = 'Dwarf',
      },
      url = 'https://classic.wowhead.com/gear-planner/dwarf/hunter/',
    },
  }
  for i, test in ipairs(tests) do
    state = test.state
    local want = test.url
    local got = lib.GenerateUrl()
    assert(want == got, string.format('test %d, want %s, got %s', i, want, got))
  end
end
