SELECT
    slot,
    ARRAY_AGG(STRUCT(effect, [spell]) ORDER BY effect)
FROM (
    SELECT
        CAST(e.spellid AS INT64) AS spell,
        CAST(e.effectmiscvalue_0_ AS INT64) AS effect,
        CAST(q.equippediteminvtypes AS INT64) AS invmask,
        (q.equippeditemclass = '2') AS for_weapon
    FROM
        spelleffect e,
        spellequippeditems q,
        spellname n
    WHERE
        e.effect = "53"
      AND
        e.spellid = q.spellid
      AND
        n.id = e.spellid
      AND
        n.name_lang not like "QA%"
), UNNEST(GENERATE_ARRAY(1, 19)) slot
WHERE
    invmask & (1 << slot) > 0 OR
    (slot in (16, 17, 18) and for_weapon)
GROUP BY slot
ORDER BY slot;
