-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE TABLE player (player_id serial PRIMARY KEY, player_name text);

CREATE TABLE matches (winner int REFERENCES player(player_id), loser int REFERENCES player(player_id));

--create a view to see total matches of a player
CREATE OR REPLACE VIEW games_view AS SELECT player.player_id, player.player_name, COUNT(matches.*) as games FROM player LEFT JOIN matches ON player.player_id = matches.winner OR player.player_id = matches.loser GROUP BY player.player_id;

CREATE VIEW standing AS SELECT player_id, player_name, COUNT(matches.winner) as wins, (SELECT games FROM games_view WHERE games_view.player_id = player.player_id) FROM player LEFT JOIN matches ON player.player_id = matches.winner GROUP BY player.player_id, player.player_name ORDER BY wins DESC;