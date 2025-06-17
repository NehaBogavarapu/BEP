-- QUERY 1
-- What are all the games published after 2020? OK
EXPLAIN ANALYZE SELECT game_id, primary_name, year_published
FROM boardgames
WHERE year_published > 2020;

CREATE INDEX bg_year ON boardgames(year_published);
DROP INDEX bg_year;

-- QUERY 2
-- What is the average weight of all the games that user "specific user" commented on and rated above 6?
EXPLAIN ANALYZE SELECT AVG(s.average_weight) AS avg_weight
FROM user_comments uc
JOIN boardgame_stats s ON uc.game_id = s.game_id
WHERE uc.username = 'alzsara' and uc.rating >=6;

CREATE INDEX uc_username ON user_comments(username);
DROP INDEX uc_username;

-- QUERY 3
-- What are the top 10 mechanics most commonly used in games that are both family-friendly (age ≤ 8) and have a weight above 4? OK
EXPLAIN ANALYZE SELECT m.mechanic_name, COUNT(*) AS usage_count
FROM boardgames bg
JOIN boardgame_stats s ON bg.game_id = s.game_id
JOIN boardgame_mechanics bm ON bg.game_id = bm.game_id
JOIN mechanics m ON bm.mechanic_id = m.mechanic_id
WHERE bg.min_age <= 12
  AND s.average_weight > 4
GROUP BY m.mechanic_name
ORDER BY usage_count DESC
LIMIT 10;

CREATE INDEX bg_min_age ON boardgames(min_age);
CREATE INDEX bs_average_weight ON boardgame_stats(average_weight);
DROP INDEX IF EXISTS bg_min_age;
DROP INDEX IF EXISTS bs_average_weight;
