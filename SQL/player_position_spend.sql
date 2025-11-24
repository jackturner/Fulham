-- percentage of annual salary spent on each player (not including loanees)

WITH team_total AS (
	SELECT
		team,
		SUM(annual) AS team_annual_spend
	FROM player_salaries
	WHERE team = 'Fulham'
	GROUP BY team
	)

SELECT
	p.player,
	p.age,
	p.position,
	p.annual,
	t.team_annual_spend,
	ROUND((p.annual * 1.0 /t.team_annual_spend)*100, 2) AS percent
FROM player_salaries p
INNER JOIN team_total t ON p.team = t.team
WHERE p.player NOT IN (
    SELECT name
    FROM transfers
    WHERE (New_Team = 'Fulham FC' OR Former_Team = 'Fulham FC')
      AND Fee LIKE '%loan%'
      AND Season = '2024/2025'
	)
ORDER BY p.team, percent DESC