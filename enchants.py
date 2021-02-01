from google.cloud import bigquery

print('local enchantTable = {')
for row in bigquery.Client(project='wow-ferronn-dev').query(
    query='''
        SELECT
            slot,
            ARRAY_AGG(STRUCT(effect, spell))
        FROM (
            SELECT
                CAST(e.spellid AS INT64) AS spell,
                CAST(e.effectmiscvalue_0_ AS INT64) AS effect,
                CAST(q.equippediteminvtypes AS INT64) AS invmask
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
            invmask & (1 << slot) > 0
        GROUP BY slot
        ORDER BY slot
    ''',
    job_config=bigquery.job.QueryJobConfig(
        default_dataset='wow-ferronn-dev.wow_tools_dbc_1_13_6_36935',
    ),
):
    print(f'  [{row[0]}] = {{')
    for s in row[1]:
      print(f'    [{s["effect"]}] = {s["spell"]},')
    print('  },')
print('}')
