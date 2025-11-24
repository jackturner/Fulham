SELECT
	s.rank,
	s.team,
	s.win,
	s.loss,
	s.draw,
	s.goals,
	s.conceded,
	s.points,
	t.players,
	t.weekly AS weekly_spend,
	t.annual AS annual_spend
FROM standings s
INNER JOIN team_salary t ON s.team = t.team
ORDER BY annual_spend DESC