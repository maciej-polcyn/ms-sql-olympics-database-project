USE olympics;

-- Athletes table
DROP TABLE IF EXISTS athletes;

WITH cleaning AS (
SELECT athlete_id, MIN(birth_year) AS birth_year
FROM dataCombined
GROUP BY athlete_id
)
SELECT 
	DISTINCT c.athlete_id
	,full_name
	,c.birth_year
	,sex
	,height
	,weight
INTO athletes
FROM cleaning c
JOIN dataCombined dc
ON c.athlete_id = dc.athlete_id
ORDER BY athlete_id;


-- Teams table
DROP TABLE IF EXISTS teams;

CREATE TABLE teams (
	team_id INT IDENTITY(1,1) PRIMARY KEY
	,team NVARCHAR(255)
);

INSERT INTO teams(team)
SELECT DISTINCT	team
FROM dataCombined
ORDER BY team;


-- Regions table
DROP TABLE IF EXISTS regions;

CREATE TABLE regions (
	region_id INT IDENTITY(1,1) PRIMARY KEY
	,region NVARCHAR(255)
	,note NVARCHAR(255)
);

INSERT INTO regions(region, note)
SELECT DISTINCT	region, note
FROM regionCodes
ORDER BY region;

-- Disciplines table
DROP TABLE IF EXISTS disciplines;

CREATE TABLE disciplines (
	discipline_id INT IDENTITY(1,1) PRIMARY KEY
	,discipline_name NVARCHAR(255)
);

INSERT INTO disciplines(discipline_name)
SELECT DISTINCT
	discipline
FROM dataCombined
ORDER BY discipline;

-- Categories table
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
	category_id INT IDENTITY(1,1) PRIMARY KEY
	,category NVARCHAR(255)
);

INSERT INTO categories(category)
SELECT DISTINCT
	category
FROM dataCombined
ORDER BY category;

-- Medals table
DROP TABLE IF EXISTS medals;

CREATE TABLE medals (
	medal_id TINYINT IDENTITY(1,1) PRIMARY KEY
	,name NVARCHAR(55)
)

INSERT INTO medals(name)
VALUES ('Gold'), ('Silver'), ('Bronze');

-- Main olympics table
DROP TABLE IF EXISTS olympics;

CREATE TABLE olympics (
	game NVARCHAR(255)
	,game_year INT
	,season NVARCHAR(55)
	,city NVARCHAR(255)
	,athlete_id INT
	,team_id INT
	,region_id INT
	,discipline_id INT
	,category_id INT
	,medal_id INT
);

INSERT INTO olympics(game, game_year, season, city, athlete_id, team_id, region_id, discipline_id, category_id, medal_id)
SELECT 
	game
	,game_year
	,season
	,city
	,a.athlete_id
	,t.team_id
	,r.region_id
	,d.discipline_id
	,c.category_id
	,m.medal_id
FROM dataCombined dc
LEFT JOIN regionCodes rc ON dc.country_code = rc.region_code
LEFT JOIN athletes a ON dc.athlete_id = a.athlete_id
LEFT JOIN teams t ON dc.team = t.team
LEFT JOIN regions r ON rc.region = r.region
LEFT JOIN disciplines d ON dc.discipline = d.discipline_name
LEFT JOIN categories c ON dc.category = c.category
LEFT JOIN medals m ON dc.medal = m.name
ORDER BY athlete_id;