-- Lecture 3 Aggreations-----
USE birdstrike_new;
SELECT aircraft, airline, speed,
    if (speed IS NULL OR speed < 100)
            THEN 'LOW SPEED'
        ELSE 
            'HIGH SPEED'
    END
    AS speed_category   
FROM  prac_birdstrike
ORDER BY speed_category;

-- if statement -----
-- EXCERISE 1 Answer: TABLE
SELECT aircraft, airline, speed, 
    if(speed IS NULL OR speed < 100, 'LOW SPEED', 'HIGH SPEED') AS speed_category  FROM  prac_birdstrike ORDER BY speed_category;

-- COUNT -------

    SELECT COUNT(*) FROM prac_birdstrike;
    SELECT COUNT(reported_date) FROM prac_birdstrike;
    
    SELECT DISTINCT state FROM prac_birdstrike;
    SELECT DISTINCT COUNT(state) FROM prac_birdstrike; -- 
    SELECT count(distinct state) FROM prac_birdstrike;
    
    -- Excercise 2---- Answwr: 3
    SELECT count(distinct aircraft) FROM prac_birdstrike;
    
    -- AVG speed in KNOTS
    SELECT (AVG(speed)*1.852) as avg_kmh FROM prac_birdstrike;
    
    SELECT SUM(cost) FROM prac_birdstrike;
    
    -- ----
    SELECT MAX(reported_date) from prac_birdstrike;
    SELECT MIN(reported_date) FROM prac_birdstrike;
	SELECT DATEDIFF(MAX(reported_date),MIN(reported_date)) from prac_birdstrike;
    
    
    -- EXCERICE 3- Answer-(9)
    SELECT * FROM prac_birdstrike;
    SELECT MIN(speed) from prac_birdstrike Where aircraft LIKE 'H%';
    
    -- GROUP BY 
    
    SELECT MIN(speed), aircraft FROM prac_birdstrike GROUP BY aircraft;
    
    SELECT state, aircraft, SUM(cost) AS sum FROM prac_birdstrike WHERE state !='' GROUP BY state, aircraft ORDER BY sum DESC;
    
    -- SELECT MIN(count(Distinct phase_of_flight)) FROM prac_birdstrike group by phase_of_flight; -- wrong correct answer is below
	/* select 
    from ( select
           from
           group by )
    group by ; */
    
    -- EXCERCIZE 4---- TAXI (2)
    SELECT phase_of_flight, count(*) AS count FROM prac_birdstrike group by phase_of_flight order by count ASC limit 1;
    SELECT phase_of_flight, count(*) AS count FROM prac_birdstrike group by phase_of_flight order by count ASC;
    SELECT phase_of_flight, count(phase_of_flight) AS count FROM prac_birdstrike group by phase_of_flight order by count ASC limit 1;
    
    -- EXCERCISE 5 --------------- 50.0000 (Vermont) | 50.0000 (Idaho)
    SELECT phase_of_flight, ROUND(avg(cost)) as cost From prac_birdstrike GROUP BY Phase_of_flight order by cost DESC limit 1;
    
    SELECT AVG(speed) AS avg_speed, state FROM prac_birdstrike GROUP BY state HAVING ROUND(avg_speed) = 50; -- if we use WHERE it will be incorrect
 -- SHAH WHERE is used for 'old values' which are pre-existing in the table and HAVING is used when we have created one new set outputs and now we will use HAVING to refer to them.
    
	-- SELECT AVG(speed) AS avg_speed, state FROM prac_birdstrike WHERE ROUND(avg_speed) = 50 GROUP BY state;
    
    
    -- EXCERCISE 6 --- IOWA 28625000
     SELECT AVG(speed) AS avg_speed , state FROM prac_birdstrike GROUP BY state HAVING LENGTH(state)<5 AND state !='' ORDER BY avg_speed DESC LIMIT 1;