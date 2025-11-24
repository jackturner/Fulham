WITH counterparts AS (
	SELECT
		s.team,
		s.rank,
		t.annual
	FROM standings s
	INNER JOIN team_salary t ON s.team = t.team
	WHERE s.team IN (
    'Nott''ham Forest',
    'Brighton',
    'Bournemouth',
    'Crystal Palace',
    'Everton',
    'Leicester City',
    'Southampton',
    'Brentford')
	),
  
  fulham AS (
	SELECT
		s.team,
		s.rank,
		t.annual
	FROM standings s
	INNER JOIN team_salary t ON s.team = t.team
	WHERE s.team = 'Fulham'
	)

SELECT
	c.team,
	f.rank - c.rank AS difference_in_league_position,
	f.annual - c.annual AS difference_in_annual_spend
FROM counterparts c
CROSS JOIN fulham f