-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 
-- 1. List the names of all left-handed batsmen from England. Order the results alphabetically. (<player name>) 
SELECT player_name FROM players WHERE batting_hand = 'Left_Hand' AND country_name = 'England' ORDER BY player_name;
-- 2. List the names and age (in years, should be integer) as on 2018-12-02 (12th Feb, 2018) of all bowlers
-- with skill “Legbreak googly” who are 28 or more in age. Order the result in decreasing order of their
-- ages. Resolve ties alphabetically. (<player name, player age>)
SELECT player_name, FLOOR(DATEDIFF('2018-12-02', dob) / 365) AS player_age 
FROM players 
WHERE bowling_skill = 'Legbreak googly' AND FLOOR(DATEDIFF('2018-12-02', dob) / 365) >= 28 
ORDER BY player_age DESC, player_name;
-- 3.List the match ids and toss winning team IDs where the toss winner of a match decided to bat first. 
-- Order result in increasing order of match ids.
SELECT match_id, toss_winner 
FROM matches 
WHERE toss_decision = 'bat' 
ORDER BY match_id;
-- 4.In the match with match id 335987, list the over ids and runs scored where at most 7 runs were scored.
-- Order the over ids in decreasing order of runs scored. Resolve ties by listing the over ids in increasing order.
SELECT over_id, runs_scored 
FROM ball_by_ball 
WHERE match_id = 335987 AND runs_scored <= 7 
ORDER BY runs_scored DESC, over_id;
-- 5.List the names of those batsmen who were bowled at least once in alphabetical order of their names.
SELECT DISTINCT p.player_name 
FROM players p 
INNER JOIN ball_out bo ON p.player_id = bo.player_out 
WHERE bo.kind_out = 'bowled' 
ORDER BY p.player_name;
-- 6.List all the match ids along with the names of teams participating (team 1, team 2), 
-- name of the wining team, and win margin where the win margin is at least 60 runs, 
-- in increasing order of win margin. Resolve ties by listing the match ids in increasing order.
SELECT m.match_id, t1.name AS team_1, t2.name AS team_2, wt.name AS winning_team_name, m.win_margin 
FROM matches m 
JOIN teams t1 ON m.team_1 = t1.team_id 
JOIN teams t2 ON m.team_2 = t2.team_id 
JOIN teams wt ON m.match_winner = wt.team_id 
WHERE m.win_margin >= 60 
ORDER BY m.win_margin, m.match_id;
-- 7.List the names of all left handed batsmen below 30 years of age as on 2018-12-02 (12th Feb, 2018) alphabetically.
SELECT player_name 
FROM players 
WHERE batting_hand = 'Left_Hand' AND dob >= '1988-12-02' 
ORDER BY player_name;
-- 8.List the match wise total for the entire series. 
-- The output should be match id, total runs. Return the results in increasing order of match ids.
SELECT match_id, SUM(runs_scored) AS total_runs 
FROM runs_scored 
GROUP BY match_id 
ORDER BY match_id;
-- 9.For each match id, list the maximum runs scored in any over and the bowler bowling in that over. If there is more than one over having maximum runs, 
-- return all of them and order them in increasing order of over id. Order results in increasing order of match ids.
SELECT b.match_id, b.over_id, MAX(b.runs_scored) AS maximum_runs, p.player_name 
FROM ball_by_ball b 
JOIN players p ON b.bowler = p.player_id 
WHERE (b.match_id, b.runs_scored) IN (
    SELECT match_id, MAX(runs_scored) 
    FROM ball_by_ball 
    GROUP BY match_id
) 
GROUP BY b.match_id, b.over_id, p.player_name 
ORDER BY b.match_id, b.over_id;
-- 10. List the names of batsmen and the number of times 
-- they have been “run out” in decreasing order of being “run out”. Resolve ties alphabetically.
SELECT p.player_name, COUNT(*) AS number 
FROM ball_out bo 
JOIN players p ON bo.player_out = p.player_id 
WHERE bo.kind_out = 'run out' 
GROUP BY p.player_name 
ORDER BY number DESC, p.player_name;
-- 11.List the number of times any batsman has got out for any out type. 
-- Return results in decreasing order of the numbers. Resolve ties alphabetically (on the out type name).
SELECT kind_out, COUNT(*) AS number 
FROM ball_out 
GROUP BY kind_out 
ORDER BY number DESC, kind_out;
-- 12.List the team name and the number of times any player 
-- from the team has received man of the match award. Order results alphabetically on the name of the team.
SELECT t.name, COUNT(*) AS number 
FROM matches m 
JOIN teams t ON m.man_of_the_match = t.team_id 
GROUP BY t.name 
ORDER BY t.name;
-- 13.Find the venue where the maximum number of wides have been given. In case of ties, 
-- return the one that comes before in alphabetical ordering. Output should contain only 1 row.
SELECT venue 
FROM (
    SELECT venue, COUNT(*) AS wide_count 
    FROM extra_runs 
    WHERE extra_type = 'wide' 
    GROUP BY venue 
    ORDER BY wide_count DESC, venue
) AS sub_query 
LIMIT 1;
-- 14.Find the venue(s) where the team bowling first has won the match. If there are more than 1 venues, list all of them in order of the number of wins (by the bowling team). Resolve ties alphabetically.
SELECT venue 
FROM (
    SELECT venue, COUNT(*) AS win_count 
    FROM matches 
    WHERE team_batting_first = match_winner 
    GROUP BY venue 
    ORDER BY win_count DESC, venue
) AS sub_query;
-- 15.Find the bowler who has the best average overall. Bowling average is calculated using the following formula:
SELECT p.player_name 
FROM ball_by_ball bbb 
JOIN players p ON bbb.bowler = p.player_id 
GROUP BY bbb.bowler 
ORDER BY SUM(bbb.runs_scored) / COUNT(DISTINCT CONCAT(bbb.match_id, bbb.over_id)) ASC, p.player_name
LIMIT 1;
-- 16.List the players and the corresponding teams where the player played as
-- “CaptainKeeper” and won the match. Order results alphabetically on the player’s name.
SELECT p.player_name, t.name 
FROM match_roles mr 
JOIN players p ON mr.player_id = p.player_id 
JOIN teams t ON mr.team_id = t.team_id 
WHERE mr.role = 'CaptainKeeper' AND mr.match_id = mr.match_winner 
ORDER BY p.player_name;
-- 17.List the names of all players and their runs scored (who have scored at least 50 runs in any match).
-- Order result in decreasing order of runs scored. Resolve ties alphabetically.
SELECT p.player_name, SUM(rs.runs_scored) AS runs_scored 
FROM runs_scored rs 
JOIN players p ON rs.striker = p.player_id 
GROUP BY p.player_name 
HAVING SUM(rs.runs_scored) >= 50 
ORDER BY runs_scored DESC, p.player_name;
-- 18.List the player names who scored a century but their teams lost the match. Order results alphabetically.
SELECT p.player_name 
FROM runs_scored rs 
JOIN players p ON rs.striker = p.player_id 
JOIN matches m ON rs.match_id = m.match_id 
WHERE rs.runs_scored >= 100 AND rs.innings_no = m.match_winner 
ORDER BY p.player_name;
-- 19.List match ids and venues where KKR has lost the game. Order result in increasing order of match ids.
SELECT m.match_id, m.venue 
FROM matches m 
JOIN teams t ON m.match_winner = t.team_id 
WHERE t.name != 'KKR' 
ORDER BY m.match_id;
-- 20.List the names of top 10 players who have the best batting average in season 5. 
-- Batting average can be calculated according to the following formula:
SELECT p.player_name 
FROM ball_by_ball bbb 
JOIN players p ON bbb.striker = p.player_id 
JOIN matches m ON bbb.match_id = m.match_id 
WHERE m.season_id = 5 
GROUP BY bbb.striker 
ORDER BY SUM(bbb.runs_scored) / COUNT(DISTINCT CONCAT(bbb.match_id, bbb.innings_no)) DESC, p.player_name 
LIMIT 10;

