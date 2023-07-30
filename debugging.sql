USE olympics;

SELECT full_name, o.athlete_id, COUNT(medal_id) AS medals_total
FROM olympics o
JOIN athletes a ON o.athlete_id = a.athlete_id
JOIN categories c ON o.category_id = c.category_id
GROUP BY full_name, o.athlete_id
ORDER BY medals_total DESC;

SELECT *
FROM olympics o
--JOIN athletes a ON o.athlete_id = a.athlete_id
JOIN categories c ON o.category_id = c.category_id
JOIN medals m ON o.medal_id = m.medal_id
JOIN regions r ON o.region_id = r.region_id
--GROUP BY full_name, o.athlete_id
WHERE athlete_id = 115988 AND m.name IS NOT NULL;

SELECT *
FROM dataCombined
WHERE athlete_id = 115988 AND medal IS NOT NULL