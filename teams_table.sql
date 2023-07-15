USE olympics;

CREATE TABLE teams(
	team_id INT IDENTITY(1,1) PRIMARY KEY
	,name VARCHAR(255)
	,region_code VARCHAR(55)
);

INSERT INTO teams (name, region_code)
SELECT DISTINCT team_name ,country_code
FROM OlympicsCombined;
