 --ROI for each team from goalkeepers & defenders
WITH gk_def_spend AS (
	SELECT
	team,
	SUM(annual) AS total_gk_def_spend
	FROM player_salaries
	WHERE position LIKE 'DF%' OR position IN ('LB', 'CB', 'RB') OR position = 'GK'
	GROUP BY team
	)

SELECT
	s.team,
	ROUND(s.conceded/(gds.total_gk_def_spend/1000000.0), 2) AS c_per_million
FROM standings s
INNER JOIN gk_def_spend gds ON s.team = gds.team
ORDER BY c_per_million

-- ROI for defenders



-- ROI for goalkeepers