prof:time(
  for $year in //yearpublished[@value > 2020]
  let $game := $year/parent::item
  return
    <game>
      <id>{data($game/@id)}</id>
      <name>{data($game/name[@type='primary']/@value)}</name>
      <year>{data($year/@value)}</year>
    </game>
)
