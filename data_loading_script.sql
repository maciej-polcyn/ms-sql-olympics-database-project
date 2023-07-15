IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'olympics')
BEGIN
    CREATE DATABASE olympics;
END;

USE olympics;

DROP TABLE IF EXISTS OlympicsCombined;

CREATE TABLE OlympicsCombined(
	athlete_id INT
	,athlete_name NVARCHAR(255)
	,gender NVARCHAR(55)
	,age TINYINT
	,height TINYINT
	,weight FLOAT
	,team_name NVARCHAR(255)
	,country_code NVARCHAR(55)
	,game NVARCHAR(255)
	,game_year DATE
	,season NVARCHAR(55)
	,city NVARCHAR(55)
	,sport NVARCHAR(255)
	,event_name NVARCHAR(255)
	,medal NVARCHAR(55)
);

BULK INSERT OlympicsCombined
FROM 'C:\Workspace\MS_SQL\ms-sql-olympics-database-project\athletic_events.csv'
WITH
(
	FORMAT='CSV',
	FIRSTROW=2
)
GO;

CREATE TABLE OlympicsRegions(
	country_code NVARCHAR(55)
	,region NVARCHAR(255)
	,notes NVARCHAR(255)
);

BULK INSERT OlympicsRegions
FROM 'C:\Workspace\MS_SQL\ms-sql-olympics-database-project\noc_regions.csv'
WITH
(
	FORMAT='CSV',
	FIRSTROW=2
)
GO;