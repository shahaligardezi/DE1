Use FormulaOne;

#1 Constructotrs with engine failures by Engine failure type & year

drop view if exists `constructor_engine_troubles`;
create view constructor_engine_troubles as
select race_id, race_year, race_name, constructor_id, name, car_status
from formulaone.racesinfo_dw
where car_status = 'Engine' OR 
car_status =  'Engine fire' OR
car_status = 'Engine misfire'
order by race_year;

select * from constructor_engine_troubles;

Drop procedure if exists engine_troubles;

delimiter //

create procedure engine_troubles(
	in status_car varchar(100),
    IN year_race int
)
begin

	select race_year,name, car_status, count(car_status) as engine_troubles from constructor_engine_troubles 
	where car_status = status_car
    and race_year = year_race
	group by race_year,name, car_status;
    
end //
delimiter ;

call engine_troubles('Engine',2006);
-- ----------------------------------------------------------------------------------------------------------

#2 Driver's performance in a particular Grand Prix sorted by quickest lap.

drop view if exists `driver_performance`;
create view `driver_performance` as
select Driver_name, nationality, race_year, race_name, city, 
grid, position, laps AS laps_completed, Time_sec, fastest_lap, fastest_laptime,
fastest_lapspeed
from formulaone.racesinfo_dw
Where position is not NUll
and fastest_lap is not NUll
and fastest_laptime is not NUll
and fastest_lapspeed is not NUll
order by fastest_laptime ASC;

select * from driver_performance;

Drop procedure if exists driver_in_race;
delimiter //
create procedure driver_in_race(
	in name_driver varchar(100),
    IN name_race varchar(100)
)
begin

	select Driver_name, nationality, race_year, race_name, 
    city, grid, position, laps_completed, Time_sec, fastest_lap, fastest_laptime, fastest_lapspeed
    from driver_performance
	where Driver_name = name_driver
    and race_name = name_race
	group by Driver_name, nationality, race_year, race_name,
    city, grid, position, laps_completed, Time_sec, fastest_lap, fastest_laptime, fastest_lapspeed;
    
end //
delimiter ;

call driver_in_race('hamilton','Australian Grand Prix');
-- ----------------------------------------------------------------------------------------------------------

#3 Which event has had the highest number of finished races?
drop view if exists `finished_races`;
create view `finished_races` as
select race_year, race_name, city, car_status, count(car_status) AS Finished_races_count
from FormulaOne.racesinfo_dw
Where car_status = 'finished'
group by race_year, race_name, city, car_status
order by Finished_races_count Desc;

select * from finished_races;
-- ----------------------------------------------------------------------------------------------------------

#4 Constructor with most points year wise
drop view if exists `constructor_points`;
create view `constructor_points` as
select race_year, name, points
from FormulaOne.racesinfo_dw
group by race_year, name, points
order by race_year;

select * from constructor_points;

select race_year, name, max(points)
from constructor_points 
group by race_year, name 
order by race_year, max(points) desc;
