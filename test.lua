local state

do
  env = {
    GetInventoryItemLink = function(unit, i)
      assert(unit == 'player')
      assert(i > 0 and i < 19 and i ~= 4)
      return state.inventory[i]
    end,
    GetNumTalentTabs = function()
      return 3
    end,
    GetNumTalents = function()
      return 10
    end,
    GetTalentInfo = function(i, j)
      assert(i >= 1 and i <= 3)
      assert(j >= 1 and j <= 10)
      local c = state.talents[string.format('%d:%d', i, j)] or 0
      return nil, nil, nil, nil, nil, c
    end,
    strmatch = string.match,
    strsplit = function(sep, s, n)
      assert(n == nil)
      local result = {}
      for w in string.gmatch(s, '([^'..sep..']+)') do
        table.insert(result, w)
      end
      return table.unpack(result)
    end,
    UnitClassBase = function(unit)
      assert(unit == 'player')
      return state.class
    end,
    UnitLevel = function(unit)
      assert(unit == 'player')
      return state.level
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
        inventory = {},
        level = 42,
        race = 'Night Elf',
        talents = { ['1:1'] = 1 },
      },
      url = 'https://classic.wowhead.com/gear-planner/warrior/night-elf/AioCH_8',
    },
    {
      state = {
        class = 'Hunter',
        inventory = {},
        level = 42,
        race = 'Dwarf',
        talents = { ['1:1'] = 1 },
      },
      url = 'https://classic.wowhead.com/gear-planner/hunter/dwarf/AioCH_8',
    },
  }
  for i, test in ipairs(tests) do
    state = test.state
    local want = test.url
    local got = lib.GenerateUrl()
    assert(want == got, string.format('test %d, want %s, got %s', i, want, got))
  end
end
