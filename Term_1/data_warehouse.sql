
Use FormulaOne;

-- Creating Data Warehouses
Drop procedure if exists create_dw;
delimiter //
create procedure create_dw()
begin 

	DROP TABLE IF EXISTS temptable1;
	create table temptable1 AS
	SELECT
	rs.race_id, rs.driver_id,
	d.driver_ref AS Driver_Name, d.nationality,
	rs.constructor_id, rs.grid,rs.position, rs.points,  rs.laps, rs.millisec/1000 AS Time_Sec,
	rs.fastest_lap, rs.fastest_laptime, rs.fastest_lapspeed, rs.status_id
	FROM results rs
	LEFT JOIN drivers d
	ON rs.driver_id = d.driver_id
	UNION 
	SELECT
	rs.race_id, rs.driver_id,
	d.driver_ref AS Driver_Name, d.nationality, 
	rs.constructor_id, rs.grid, rs.position, rs.points,rs.laps, rs.millisec/1000 AS Time_Sec,
	rs.fastest_lap, rs.fastest_laptime, rs.fastest_lapspeed, 
	rs.status_id
	from results rs
	RIGHT JOIN drivers d
	ON rs.driver_id = d.driver_id;

	DROP TABLE IF EXISTS racesinfo_DW;
	create table racesinfo_DW AS
	SELECT
	t.race_id,
	r.race_year,r.race_name, r.circuit_id, r.city,
	t.driver_id, t.Driver_Name, t.nationality,  t.grid, t.constructor_id,
	c.name,
	t.position, t.points, t.laps, t.Time_Sec, t.fastest_lap, t.fastest_laptime, t.fastest_lapspeed,
	s.car_status
	from temptable1 t
	LEFT Join races r
	on t.race_id = r.race_id 
	LEFT JOIN constructors c
	using (constructor_id)
	LEFT JOIN status s
	ON t.status_id = s.status_id;
    
    drop table if exists temptable1;
end //
delimiter ;

call create_dw();

select * from racesinfo_DW;
