prof:time(
  let $user := 'alzsara'
  let $commentedGames := distinct-values(
    /items/item[comments/comment[@username = $user and number(@rating) >= 6]]/@id
  )
  let $weights := 
    for $id in $commentedGames
    let $game := /items/item[@id = $id]
    let $weight := $game/statistics/ratings/averageweight/@value
    where exists($weight)
    return xs:decimal($weight)
  return
    if (empty($weights)) then ()
    else avg($weights)
)