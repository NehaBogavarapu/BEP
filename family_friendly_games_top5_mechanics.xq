prof:time(
  let $filteredGames := 
    /items/item[
      number(minage/@value) <= 12 and 
      number(statistics/ratings/averageweight/@value) > 4
    ]
  let $mechanics := 
    for $game in $filteredGames
    for $mech in $game/link[@type='boardgamemechanic']
    return data($mech/@value)
  let $grouped := 
    for $m in distinct-values($mechanics)
    let $count := count($mechanics[. = $m])
    order by $count descending
    return <mechanic name="{$m}" count="{$count}"/>
  return
    subsequence($grouped, 1, 10)
)