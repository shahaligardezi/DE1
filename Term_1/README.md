# Data Engineering Project 1:  Formula One (2000-2021) dataset.

This report serves as a complete documentation for the Term Project 1 for Data Engineering 1 course. In order to perform this task, I used the dataset from Kaggle which was about Formula One racing.  Keeping in view the constantly evolving nature of Formula One racing rules, I have examined 20 years of data from 2000 to 2021 instead of 1950-2021 as on Kaggle. 

## Operational Layer

The used dataset contains the following five tables and this is what they broadly describe:
- Results - contains information of different parameters of recorded in a race;
- Constructors - contains information about car sponsoring teams;
- Races - describes race venues, circuits, date & time;
- Drivers - description of participants driving the vehicle and how they performed in different races;
- Status - car status at the end of the race. 

It is a relational dataset which has been linked together to provide the EER diagram has shown below. As the diagram illustrates the results table serves as a central table in the star schema. There are different kind of linkages, such as one to many (between races & results; constructors and results) many to one (between results & status) and many to many (between results and drivers) in this relational dataset. 

![](https://user-images.githubusercontent.com/90857281/141663842-885b0d34-b444-4641-926d-fe72036b1337.png)

Analytics

In order to create an analytics plan, I thought from the perspective of Formula One 
data-analyst team member. I would require a dataset to provide me information about 
•	Constructors with engine failures status by year
•	Drivers performance in a particular Grand Prix
•	Race events in which the highest number of drivers finished the race safely
•	Constructors’ score board

In order to achieve the desired analytics results my plan of action involved 
•	Loading the data into tables in MySQL
•	Creating an ETL pipeline to create a data warehouse called racesinfo_dw
•	Creating an ETL pipeline to create data marts for analysis 
The figure below illustrates the above.
 


Analytical layer: 

In the analytical layer I created a data warehouse with relevant columns to aid to my analysis. This data warehouse was then used to create views.  While creating the data warehouse, I used multiple joins between the tables like Left Join, Right Join and Union (in case of many to many relationships between drivers and results table. The purpose of the analytical layer was to provide one single table which consists of both qualitative and quantitative parameters pertaining to all the stakeholders in each race of the Formula One season. 
 

 


Data Marts: 

Using the created data warehouse in the analytical layer, I created the data marts with the help of views which would help me answer the questions outlined in my analytical plan. The description of views are as follows:

•	View 1: Constructor_engine_troubles:
Displays the constructors with respect engine failure as car status. It also displays the years in which those constructors had engine failure and other details like race event name.  This view will allow the Formula One data analysis team to perform multiple types of analysis such as which constructors had highest engine failures, in a particular year which constructors had engine fires etc. 

•	View 2: Driver_performances:
Displays performance of the driver in every race and includes information about driver’s fastest lap, fastest lap time, fastest speed, time to complete race etc. This view will allow the users see the analyze the performance of their chosen driver in any Grand Prix

•	View 3: Finished_races:
Displays race events and sorts on the basis of highest finished car status. Meaning maximum number of drivers finished race without accidents. This view will allow the users see the analyze the which race circuit is safest for drivers.

•	View 4: Constructor_points:
Displays constructors and their points during the season.

Extra:

As extra step, I performed a test analysis of my View 1, View 2 and View 3 views of the data mart.

•	For View 1, I created a stored procedure called engine_troubles. This function takes two inputs from the user, engine failure type as car_status and race_year and out puts the constructors name and the number of times in the season they had the particular engine failure.


•	For View 2, I created a stored procedure called driver_in_race. This function takes two inputs from the user, driver_name and race_name and outputs a table with the driver’s performance parameters such grid placement, final position in the race, fastest lap, fastest lap time, fastest speed, time to complete race.


•	For View 4, I performed the analysis to record the total points gained by each constructor at the end of race season. For this, I used MAX aggregate function of MySQL to record the total points gained by each constructor.


![image](https://user-images.githubusercontent.com/90857281/141663857-04cdea6e-25f2-4cf5-90c4-626f43909309.png)


