 --ROI for each team from forwards
WITH fw_spend AS (
	SELECT
	team,
	SUM(annual) AS total_fw_spend
	FROM player_salaries
	WHERE position LIKE 'FW%' OR position IN ('LW', 'RW', 'CF')
	GROUP BY team
	),
fw_ga AS (
	SELECT
	team,
	SUM(goals) AS fw_g,
	SUM(assists) AS fw_a
	FROM player_stats
	WHERE position LIKE 'FW%' OR position IN ('LW', 'RW', 'CF')
	GROUP BY team
	)
	
SELECT
	s.team,
	ROUND((fga.fw_g + fga.fw_a)/(fs.total_fw_spend/1000000.0), 2) AS ga_per_million
FROM standings s
INNER JOIN fw_spend fs ON s.team = fs.team
INNER JOIN fw_ga fga ON s.team = fga.team
ORDER BY ga_per_million DESC

--ROI for each forward
SELECT
	p.team,
	p.name,
	p.goals,
	p.assists,
	s.annual AS annual_spend,
	ROUND(((p.goals+p.assists)/(s.annual/1000000.0)), 2) AS ga_per_million
FROM player_stats p
INNER JOIN player_salaries s ON p.name = s.player
WHERE p.position LIKE 'FW%' OR p.position IN ('LW', 'RW', 'CF')
ORDER BY ga_per_million DESC