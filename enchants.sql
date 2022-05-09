WITH spelleffects AS (
  SELECT
    CAST(spelleffect.spellid AS INT64) AS spell,
    CAST(spelleffect.effectmiscvalue_0_ AS INT64) AS effect,
    CAST(
      spellequippeditems.equippediteminvtypes AS INT64
    ) AS invmask,
    (spellequippeditems.equippeditemclass = '2') AS for_weapon
  FROM
    spelleffect,
    spellequippeditems,
    spellname
  WHERE
    spelleffect.effect = '53'
    AND spelleffect.spellid = spellequippeditems.spellid
    AND spellname.id = spelleffect.spellid
    AND spellname.name_lang NOT LIKE 'QA%'
)

SELECT
  slot,
  ARRAY_AGG(STRUCT(effect, [spell]) ORDER BY effect) AS effects
FROM (
  SELECT
    slot,
    effect,
    MIN(spell) AS spell  -- TODO this can't be right
  FROM spelleffects, UNNEST(GENERATE_ARRAY(1, 19)) AS slot
  WHERE
    invmask & (1 << slot) > 0
    OR (slot IN (16, 17, 18) AND for_weapon)
  GROUP BY slot, effect
  ORDER BY slot, effect)
GROUP BY slot
ORDER BY slot;
