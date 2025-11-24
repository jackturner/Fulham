-- points per million

SELECT
	s.team,
	s.points,
	t.annual,
	ROUND(s.points/(t.annual/1000000.0), 2) AS points_per_million
FROM standings s
INNER JOIN team_salary t ON s.team = t.team
ORDER BY points_per_million DESC