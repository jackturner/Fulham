--Highest paid with the least minutes
SELECT
	s.name,
	s.team,
	s.minutes,
	p.annual AS annual,
	(s.minutes/(p.annual/1000000)) AS mins_per_million
FROM player_stats s
INNER JOIN player_salaries p ON s.name = p.Player
WHERE p.annual > 10000000
ORDER BY mins_per_million

-- Cost of injuries (how much did teams spend on injured players)

