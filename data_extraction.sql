USE olympics;

SELECT game_year, COUNT(DISTINCT region) AS frequency
FROM dataCombined dc
JOIN regionCodes rc ON dc.country_code = rc.region_code
GROUP BY game_year
ORDER BY game_year;

WITH diff AS (
SELECT athlete_id, COUNT(DISTINCT discipline) AS count_disc
FROM dataCombined
GROUP BY athlete_id )
SELECT MAX(count_disc)
FROM diff;

SELECT discipline, COUNT(distinct category) AS no_cotegories
FROM dataCombined
GROUP BY discipline
ORDER BY no_cotegories DESC;

SELECT region, COUNT(DISTINCT game) AS different_games
FROM dataCombined dc
JOIN regionCodes rc ON dc.country_code = rc.region_code
GROUP BY region
ORDER BY different_games DESC;

-- Œrednia iloœæ medali na olimpiadê

WITH med AS (
SELECT game, region, COUNT(medal) AS medals
FROM dataCombined dc
JOIN regionCodes rc ON dc.country_code = rc.region_code
GROUP BY game, region
)
SELECT region, AVG(medals) AS avg_medals
FROM med
GROUP BY region
ORDER BY avg_medals DESC


-- Najwy¿sza frekwencja
WITH freq AS (
SELECT game, COUNT(DISTINCT region) AS frequency
FROM olympics o
JOIN regions r ON r.region_id = o.region_id 
GROUP BY game)
SELECT game, frequency
FROM freq
WHERE frequency = 
	(SELECT MAX(frequency)
	FROM freq)

