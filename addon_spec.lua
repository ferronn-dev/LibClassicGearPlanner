describe('url generation', function()
  local function prepare(data)
    wow.state.equipment = data.inventory
    wow.state.player.class = data.class
    wow.state.player.level = data.level
    wow.state.player.race = data.race
    wow.state.talents = data.talents
  end

  local function liburl()
    return wow.env.LibStub('LibClassicGearPlanner'):GenerateUrl()
  end

  it('works on an empty night elf warrior', function()
    prepare({
      class = 1,
      inventory = {},
      level = 42,
      race = 'Night Elf',
      talents = { { 1 }, {}, {} },
    })
    assert.same(liburl(), 'https://classic.wowhead.com/gear-planner/warrior/night-elf/AioCH_8')
    assert.same(wow.state.printed, '')
  end)

  it('works on an empty dwarf hunter', function()
    prepare({
      class = 3,
      inventory = {},
      level = 42,
      race = 'Dwarf',
      talents = { { 1 }, {}, {} },
    })
    assert.same(liburl(), 'https://classic.wowhead.com/gear-planner/hunter/dwarf/AioCH_8')
    assert.same(wow.state.printed, '')
  end)

  it('works on a decked out human paladin', function()
    prepare({
      class = 2,
      inventory = {
        '|cff0070dd|Hitem:10833::::::::60:::1::::|h[Horns of Eranikus]|h|r',
        '|cff0070dd|Hitem:18317::::::::60:::1::::|h[Tempest Talisman]|h|r',
        '|cff0070dd|Hitem:22234::::::::60:::1::::|h[Mantle of Lost Hope]|h|r',
        '|cffffffff|Hitem:2575::::::::60:::11::::|h[Red Linen Shirt]|h|r',
        '|cff0070dd|Hitem:13168::::::::60:::1::::|h[Plate of the Shaman King]|h|r',
        '|cff0070dd|Hitem:18327::::::::60:::1::::|h[Whipvine Cord]|h|r',
        '|cff0070dd|Hitem:11841::::::::60:::1::::|h[Senior Designer\'s Pantaloons]|h|r',
        '|cff0070dd|Hitem:22275::::::::60:::1::::|h[Firemoss Boots]|h|r',
        '|cff1eff00|Hitem:15182::::::2038:366342272:60:::1::::|h[Praetorian Wristbands of Healing]|h|r',
        '|cff0070dd|Hitem:18309::::::::60:::1::::|h[Gloves of Restoration]|h|r',
        '|cff0070dd|Hitem:18314::::::::60:::1::::|h[Ring of Demonic Guile]|h|r',
        '|cff0070dd|Hitem:18314::::::::60:::1::::|h[Ring of Demonic Guile]|h|r',
        '|cff0070dd|Hitem:20512::::::::57:::11::::|h[Sanctified Orb]|h|r',
        '|cff0070dd|Hitem:11819::::::::60:::1::::|h[Second Wind]|h|r',
        '|cff1eff00|Hitem:9938::::::2037:415671040:60:::1::::|h[Abjurer\'s Cloak of Healing]|h|r',
        '|cff0070dd|Hitem:11923::::::::60:::1::::|h[The Hammer of Grace]|h|r',
        '|cff0070dd|Hitem:9393::::::::60:::1::::|h[Beacon of Hope]|h|r',
        '|cff0070dd|Hitem:22400::::::::60:::1::::|h[Libram of Truth]|h|r',
      },
      level = 59,
      race = 'Human',
      talents = {
        { 0, 5, 5, 0, 3, 1, 2, 0, 5, 2, 1, 1, 5, 0 },
        {},
        {},
      },
    })
    assert.same(
      liburl(),
      'https://classic.wowhead.com/gear-planner/paladin/human/'
        .. 'AjsIBVAxIFIRX_8BKlECR40DVtoFM3AGR5cHLkEIVwNJO04H9gpHhQtHigxHig1QIA4uK08m0gf1EC6TESSxEleA'
    )
    assert.same(wow.state.printed, '')
  end)

  it('works on a decked out night elf druid', function()
    prepare({
      class = 11,
      inventory = {
        '|cff0070dd|Hitem:11925::::::::60:::1::::|h[Ghostshroud]|h|r',
        '|cff0070dd|Hitem:11933::::::::60:::1::::|h[Imperial Jewel]|h|r',
        '|cff0070dd|Hitem:10783::::::1616:145203584:60:::1::::|h[Atal\'ai Spaulders of Defense]|h|r',
        '|cffffffff|Hitem:2575::::::::60:::11::::|h[Red Linen Shirt]|h|r',
        '|cff0070dd|Hitem:12793::::::::60:::1::::|h[Mixologist\'s Tunic]|h|r',
        '|cff0070dd|Hitem:13252::::::::60:::1::::|h[Cloudrunner Girdle]|h|r',
        '|cff1eff00|Hitem:15431::::::630:422168192:60:::1::::|h[Peerless Leggings of the Monkey]|h|r',
        '|cff0070dd|Hitem:11675::::::::60:::1::::|h[Shadefiend Boots]|h|r',
        '|cff0070dd|Hitem:10800:929:::::610:528211200:60:::1::::|h[Darkwater Bracers of the Monkey]|h|r',
        '|cff1eff00|Hitem:12114::::::::60:::11::::|h[Nightfall Gloves]|h|r',
        '|cff0070dd|Hitem:22255::::::::60:::1::::|h[Magma Forged Band]|h|r',
        '|cff0070dd|Hitem:11669::::::::60:::1::::|h[Naglering]|h|r',
        '|cff0070dd|Hitem:11810::::::::60:::1::::|h[Force of Will]|h|r',
        '|cff1eff00|Hitem:17774::::::::60:::11::::|h[Mark of the Chosen]|h|r',
        '|cff0070dd|Hitem:11626::::::::60:::1::::|h[Blackveil Cape]|h|r',
        '|cff0070dd|Hitem:11921::::::::60:::1::::|h[Impervious Giant]|h|r',
      },
      level = 59,
      race = 'Night Elf',
      talents = {
        {},
        { 5, 0, 5, 0, 3, 0, 1, 3, 0, 3, 0, 2, 2, 1, 5 },
        { 5, 5, 5 },
      },
    })
    assert.same(
      liburl(),
      'https://classic.wowhead.com/gear-planner/druid/night-elf/'
        .. 'AjsL9QUDATAwIhX1VfABLpUCLp1DKh8GUAUx-QYzxEc8RwJ2CC2bySowNnkCYgovUgtW7wwtlQ0uIg5Fbg8tahAukQ'
    )
    assert.same(wow.state.printed, '')
  end)

  it('is resilient to unknown slots', function()
    prepare({
      class = 1,
      inventory = {
        [15] = '|cff0070dd|Hitem:11626:929:::::::60:::1::::|h[Blackveil Cape]|h|r',
      },
      level = 42,
      race = 'Night Elf',
      talents = { { 1 }, {}, {} },
    })
    assert.same(liburl(), 'https://classic.wowhead.com/gear-planner/warrior/night-elf/AioCH_8PLWo')
    assert.same(wow.state.printed, '[LibClassicGearPlanner]: failed on slot 15\n')
  end)

  it('is resilient to unknown enchants', function()
    prepare({
      class = 1,
      inventory = {
        [16] = '|cff0070dd|Hitem:11923:9999:::::::60:::1::::|h[The Hammer of Grace]|h|r',
      },
      level = 42,
      race = 'Night Elf',
      talents = { { 1 }, {}, {} },
    })
    assert.same(liburl(), 'https://classic.wowhead.com/gear-planner/warrior/night-elf/AioCH_8QLpM')
    assert.same(wow.state.printed, '[LibClassicGearPlanner]: failed on slot 16\n')
  end)
end)
