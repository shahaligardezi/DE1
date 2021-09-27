Create Schema birdstrike_new;
USE birdstrike_new;

Create table prac_birdstrike
(ID INTEGER NOT NULL, Aircraft VARCHAR(32), Flight_date DATE NOT NULL, Damage VARCHAR(16) NOT NULL,
Airline VARCHAR(255) NOT NULL, State VARCHAR(255), Phase_of_flight VARCHAR(32), Reported_date DATE, Bird_size VARCHAR(16),
Cost INTEGER NOT NULL, Speed INTEGER,PRIMARY KEY(id));


-- Adding feet above the ground because I forgot to add---
ALTER TABLE prac_birdstrike 
ADD feet_above_ground integer;

SELECT * FROM prac_birdstrike;

SHOW VARIABLES LIKE "secure_file_priv";

Set global local_infile ='on';
show variables like "local_infile";

-- DROP TABLE  prac_birdstrike; -- I dropped it so that i can reload (after adding above_the_ground
LOAD DATA INFILE '/tmp/birdstrikes_small.csv' 
INTO TABLE prac_birdstrike 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, aircraft, flight_date, damage, airline, state, phase_of_flight, @v_reported_date, bird_size, cost, @v_speed) -- There should be feet above the groun instead of speed ASK
SET
reported_date = nullif(@v_reported_date, ''),
speed = nullif(@v_speed, '');

TRUNCATE TABLE prac_birdstrike;

show tables;
describe prac_birdstrike;


Select * From prac_birdstrike;

-- --------------- LECTURE 2 Practice ------------------------
Create table prac_employee (id integer not null, employee_name varchar(255) not null, primary key (id));

INSERT INTO prac_employee (id,employee_name) VALUES(1,'Student1');
Select * from prac_employee;

INSERT INTO prac_employee (id,employee_name) VALUES(1,'ALI');
INSERT INTO prac_employee (id,employee_name) VALUES(2,'Burair');
INSERT INTO prac_employee (id,employee_name) VALUES(3, 'Hamza'); 


UPDATE prac_employee Set employee_name= 'SHAH ALI' where id ='1';
UPDATE prac_employee SET employee_name = 'Syed ALI' where id = '3';

UPDATE prac_employee SET id= '6' WHERE id ='Burair';
Select * from prac_employee;

DELETE FROM prac_employee WHERE id = '3';

TRUNCATE prac_employee;
Select * from prac_employee;


-- understood the creat user part, but didnt perform it
Select *, speed/2 From prac_birdstrike;

SELECT * FROM prac_birdstrike WHERE id='1';

SELECT *, speed/2 AS Aadhi_speed FROM prac_birdstrike;

SELECT * FROM prac_birdstrike LIMIT 10;
SELECT * FROM prac_birdstrike LIMIT 10,1;

-- EXCERCISE 2
SELECT * FROM prac_birdstrike;

SELECT state from prac_birdstrike LIMIT 144,1; -- TENNESSEE

-- Ordering data ----------
SELECT state, cost FROM prac_birdstrike order by cost;
SELECT state, cost FROM prac_birdstrike order by state, cost ASC;

SELECT state, cost FROM prac_birdstrike WHERE state != '' order by state, cost ASC;

SELECT state, cost FROM prac_birdstrike order by state, cost DESC;
-- ----------------------------------------------------------------

-- --------- EXCERCIZE 3--------------------------
Select * From prac_birdstrike;

SELECT  flight_date FROM prac_birdstrike ORDER BY flight_date DESC;
-- -------------------------------------

SELECT DISTINCT damage FROM prac_birdstrike;
SELECT DISTINCT airline, damage FROM prac_birdstrike;

-- ------ EXCERCISE 4-------------------------

SELECT DISTINCT cost FROM prac_birdstrike order by cost DESC limit 49,1;

SELECT * FROM prac_birdstrike where state = 'Alabama';
-- SELECT * FROM prac_birdstrike where state like 'Ala%';
SELECT DISTINCT state FROM prac_birdstrike WHERE state LIKE 'A%';
SELECT DISTINCT state FROM prac_birdstrike WHERE state LIKE 'Ala%';

SELECT DISTINCT state FROM prac_birdstrike WHERE state LIKE 'No% _a%';

SELECT DISTINCT state FROM prac_birdstrike WHERE state NOT LIKE 'A%'order by state;

SELECT * FROM prac_birdstrike where state = 'Alabama' and bird_size= 'small';
SELECT * FROM prac_birdstrike where state = 'Alabama' OR state = 'Missouri' order by state;

-- IS NOT NULL section
SELECT DISTINCT * FROM prac_birdstrike WHERE state IS NOT NULL AND state != '' ORDER BY state; -- writing both IS NOT NULL & NOT EQUAL To is used to tell the PC that we DONT want any gaps/missing value in our data table

-- IN Command------
SELECT * FROM prac_birdstrike WHERE state IN ('Alabama', 'NEW YORK', 'Missouri','Alaska');

-- Character length----
SELECT DISTINCT(state) FROM prac_birdstrike WHERE LENGTH(state) = 5;

-- Filtering with INT----
SELECT * FROM prac_birdstrike WHERE speed = 350;

SELECT * FROM prac_birdstrike WHERE speed >= 20000;

SELECT ROUND(SQRT(speed/2) * 10) AS synthetic_speed FROM prac_birdstrike;

SELECT * FROM prac_birdstrike where cost BETWEEN 20 AND 40;

-- --- EXCERCIZE 5 -------
SELECT state FROM prac_birdstrike WHERE (state IS NOT NULL AND state != '') AND (bird_size IS NOT NULL AND state != '') LIMIT 1,1;

-- FILTERING WITH DATE ---
SELECT * FROM prac_birdstrike WHERE flight_date = "2000-01-02";

SELECT * FROM prac_birdstrike WHERE flight_date >= '2000-01-01' AND flight_date <= '2000-01-03';

SELECT * FROM prac_birdstrike WHERE flight_date BETWEEN "2000-01-01" AND "2000-01-03";

-- EXCERCISE 6 --------

SELECT flight_date, state  FROM prac_birdstrike where state = 'Colorado' AND (weekofyear(flight_date) = '52');
SELECT CURDATE();
SELECT DATEDIFF(CURDATE(), (SELECT flight_date FROM prac_birdstrike where state = 'Colorado' AND weekofyear(flight_date) = '52'));
