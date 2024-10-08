CREATE DATABASE BOOTCAMP_EX4;
use BOOTCAMP_EX4;

DROP TABLE MATCHES;
DROP TABLE PLAYERS;
DROP TABLE WINNERS;

CREATE TABLE PLAYERS (
PLAYER_ID INTEGER NOT NULL UNIQUE,
GROUP_ID INTEGER NOT NULL
);

CREATE TABLE MATCHES (
MATCH_ID INTEGER NOT NULL UNIQUE,
FIRST_PLAYER INTEGER NOT NULL,
SECOND_PLAYER INTEGER NOT NULL,
FIRST_SCORE INTEGER NOT NULL,
SECOND_SCORE INTEGER NOT NULL
);


-- PLAYERS DATA --
INSERT INTO PLAYERS VALUE (20, 2);
INSERT INTO PLAYERS VALUE (30, 1);
INSERT INTO PLAYERS VALUE (40, 3);
INSERT INTO PLAYERS VALUE (45, 1);
INSERT INTO PLAYERS VALUE (50, 2);
INSERT INTO PLAYERS VALUE (65, 1);


-- MATCHES DATA --
INSERT INTO MATCHES VALUE (1, 30,45,10,12);
INSERT INTO MATCHES VALUE (2, 20,50,5,5);
INSERT INTO MATCHES VALUE (13, 65,45,10,10);
INSERT INTO MATCHES VALUE (5, 30,65,3,15);
INSERT INTO MATCHES VALUE (42, 45,65,8,4);

SELECT * FROM MATCHES;
SELECT * FROM PLAYERS;
SELECT * FROM MatchWinners;
SELECT * FROM WINNERS;

DROP TABLE MATCHES;
DROP TABLE PLAYERS;
DROP TABLE WINNERS;


-- Step 1: Find winners for each match
WITH MatchWinners AS (
  SELECT 
    MATCH_ID,
    CASE 
      WHEN FIRST_SCORE > SECOND_SCORE THEN FIRST_PLAYER
      WHEN FIRST_SCORE < SECOND_SCORE THEN SECOND_PLAYER
      ELSE LEAST(FIRST_PLAYER, SECOND_PLAYER)
    END AS WINNER_ID
  FROM MATCHES
  
)
SELECT * FROM MatchWinners;


-- Step 2: Find the winners by group
SELECT 
    p.GROUP_ID,
    mw.WINNER_ID
FROM MatchWinners mw
JOIN PLAYERS p
ON mw.WINNER_ID = p.PLAYER_ID
GROUP BY p.GROUP_ID, mw.WINNER_ID;

-- Step 3: Create the WINNERS table
CREATE TABLE WINNERS (
  GROUP_ID INTEGER,
  WINNER_ID INTEGER
);

-- Step 4: Insert data into the WINNERS table
INSERT INTO WINNERS (GROUP_ID, WINNER_ID)
SELECT 
    p.GROUP_ID,
    mw.WINNER_ID
FROM MatchWinners mw
JOIN PLAYERS p
ON mw.WINNER_ID = p.PLAYER_ID
GROUP BY p.GROUP_ID, mw.WINNER_ID;
