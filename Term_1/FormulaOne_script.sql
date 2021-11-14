--------
-- 		Data was downloaded from: https://www.kaggle.com/rohanrao/formula-1-world-championship-1950-2020
-------
DROP SCHEMA IF EXISTS FormulaOne;
CREATE SCHEMA FormulaOne;
USE FormulaOne;
-- ------------------------

-- Constructors Table
DROP TABLE IF EXISTS constructors;
CREATE TABLE constructors
(constructor_id INTEGER NOT NULL,
name varchar(50),
nationality varchar(50),
primary key(constructor_id));

-- Loading data into constructors table
LOAD DATA INFILE '/tmp/sql_final_data/shah_constructors.csv' 
INTO TABLE constructors
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES (constructor_id,name,nationality);


-- Races Table --------
DROP TABLE IF EXISTS Races;
CREATE TABLE Races 
(race_id INTEGER NOT NULL ,
race_year year,
round INTEGER,
circuit_id INTEGER,
race_name varchar(70),
race_date varchar(20),
race_time varchar(20),
circuit_name varchar(110),
city varchar(50),
country varchar(50),
primary key(race_id));

-- Loading data into race table
LOAD DATA INFILE '/tmp/sql_final_data/shah_races.csv' 
INTO TABLE Races
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES (race_id,race_year,round,circuit_id,race_name,race_date, race_time, circuit_name, city, country);


-- Drivers Table 
DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers 
(driver_standingid INTEGER NOT NULL,
race_id integer,
driver_id integer,
driver_ref varchar(50),
nationality varchar(50),
points double,
position varchar(100),
wins integer,
primary key (driver_standingid));

-- Loading data into drivers table
LOAD DATA INFILE '/tmp/sql_final_data/shah_driver_standings.csv' 
INTO TABLE drivers
FIELDS TERMINATED BY ','
-- optionally enclosed by '"' -- "'"
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES (driver_standingid, race_id, driver_id, driver_ref, nationality, points, position,wins);


-- Creating Status table
DROP TABLE IF EXISTS status;
CREATE TABLE status
(status_id INTEGER NOT NULL,
car_status varchar(100),
primary key (status_id));

-- loading data into status table
LOAD DATA INFILE '/tmp/sql_final_data/shah_status.csv' 
INTO TABLE status
FIELDS TERMINATED BY ','
optionally enclosed by '"'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES (status_id, car_status);

-- Create Results Table 
DROP TABLE IF EXISTS results;
CREATE TABLE results 
(result_id INTEGER NOT NULL,
race_id Integer,
driver_id INTEGER,
constructor_id INTEGER,
grid INTEGER,
position integer,
points decimal(5,2),
laps varchar(30),
millisec INTEGER,
fastest_lap integer,
fastest_laptime time,
fastest_lapspeed decimal(5,2),
status_id INTEGER,
primary key (result_id));

-- Load Data into results table
LOAD DATA INFILE '/tmp/sql_final_data/shah_results.csv' 
INTO TABLE results
FIELDS TERMINATED BY ','
-- optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES (result_id,race_id,driver_id,constructor_id,grid, @a_position, 
points, laps, @a_millisec, @a_fastest_lap, @a_fastest_laptime, @a_fastest_lapspeed, status_id)

-- taking care of the missing values
SET
position = nullif(@a_position, '\N'),
millisec = nullif(@a_millisec, '\N'),
fastest_lap = nullif(@a_fastest_lap, '\N'),
fastest_laptime = nullif(@a_fastest_laptime, '\N'),
fastest_lapspeed = nullif(@a_fastest_lapspeed, '\N');

#####################################

