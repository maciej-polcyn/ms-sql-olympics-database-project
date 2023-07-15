USE olympics;

DROP TABLE IF EXISTS athletes;

CREATE TABLE athletes(
	athlete_id INT NOT NULL PRIMARY KEY
	,full_name NVARCHAR(255) 
	,gender NVARCHAR(55)
	,team_id INT
);
-- There are multiple values of age and team for some athletes 

INSERT INTO athletes
	(athlete_id
	,full_name
	,birthdate_year
	,gender
	,team_id)
SELECT DISTINCT athlete_id, athlete_name, gender, team_id
FROM OlympicsCombined o
JOIN teams t ON o.team_name = t.name 
ORDER BY athlete_id;

SELECT DISTINCT 
	athlete_id
	,athlete_name
	,year(game_year) - age AS birthdate_year
	,gender
	,weight
	,height
FROM OlympicsCombined o
JOIN teams t ON o.team_name = t.name 
ORDER BY athlete_id;


SELECT athlete_name, COUNT(distinct year(game_year) - age)
FROM OlympicsCombined
GROUP BY athlete_name
HAVING COUNT(distinct year(game_year) - age) > 1