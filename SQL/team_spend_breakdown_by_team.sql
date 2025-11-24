--how does each team spend their money (percentages on positions)

WITH defenders AS (
	SELECT
		team,
		SUM(annual) AS defender_spend
	FROM player_salaries
	WHERE position LIKE 'DF%' OR position IN ('LB', 'CB', 'RB')
	GROUP BY team
	),
	
goalkeepers AS (
	SELECT
		team,
		SUM(annual) AS goalkeeper_spend
	FROM player_salaries
	WHERE position = 'GK'
	GROUP BY team
	),

midfielders AS (
	SELECT
		team,
		SUM(annual) AS midfielder_spend
	FROM player_salaries
	WHERE position LIKE 'MF%' OR position IN ('DM', 'CM', 'AM')
	GROUP BY team
	),

forwards AS (
	SELECT
		team,
		SUM(annual) AS forward_spend
	FROM player_salaries
	WHERE position LIKE 'FW%' OR position IN ('LW', 'RW', 'CF')
	GROUP BY team
	),
	
total AS (
	SELECT
		team,
		player,
		SUM(annual) AS total_spend
	FROM player_salaries
	GROUP BY team
	)

SELECT
	d.team,
	ROUND((g.goalkeeper_spend * 1.0 / t.total_spend) * 100, 2) AS goalkeeper_percent,
	ROUND((d.defender_spend * 1.0 / t.total_spend) * 100, 2) AS defender_percent,
	ROUND((m.midfielder_spend * 1.0 / t.total_spend) * 100, 2) AS midfielder_percent,
	ROUND((f.forward_spend * 1.0 / t.total_spend) * 100, 2) AS forward_percent
FROM defenders d
INNER JOIN goalkeepers g ON d.team = g.team
INNER JOIN midfielders m ON d.team = m.team
INNER JOIN forwards f ON d.team = f.team
INNER JOIN total t ON d.team = t.team
WHERE t.player NOT IN (
	SELECT name
    FROM transfers
    WHERE  Fee LIKE '%loan%' AND Season = '2024/2025'
	)