---Create database for RailwayTicketing

create database Railway

use Railway

---Create a structure or schema for our data as a container

Create table Railway_ticketing
(Transaction_ID	varchar(max),Date_of_Purchase varchar(max),Time_of_Purchase varchar(max),
Purchase_Type varchar(max),Payment_Method varchar(max),Railcard varchar(max),Ticket_Class varchar(max),
Ticket_Type varchar(max),Price varchar(max),Departure_Station varchar(max),Arrival_Destination varchar(max),
Date_of_Journey varchar(max),Departure_Time varchar(max),Arrival_Time varchar(max),
Actual_Arrival_Time varchar(max),Journey_Status varchar(max),Reason_for_Delay varchar(max),
Refund_Request varchar(max))

select *from Railway_ticketing

---Let's insert the data in this container

---Path of my file-"C:\Users\Public\Railway Project"
bulk insert Railway_ticketing
from 'C:\Users\Public\Railway Project\Railway_ticketing.csv'
with (fieldterminator=',',rowterminator='\n',firstrow=2,maxerrors=40)


select *from Railway_ticketing
--Checking the data_types
select column_name, data_type
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'Railway_ticketing'
 
--Position we are keeping as it is 
--Transaction ID-varchar is fine	
--Date of Purchase- Date	
--Time of Purchase-	Time
--Purchase Type	-varchar is fine
--Payment Method -	varchar is fine
--Railcard -varchar	
--Ticket Class-varchar
--Ticket Type-varchar	
--Price	-Decimal
--Departure Station	-VARCHAR
--Arrival Destination-varchar	
--Date of Journey-Date
--Departure Time,Arrival Time,Actual Arrival Time-Time
--Journey Status-varchar	
--Reason for Delay-varchar
--Refund Request-varchar

alter table Railway_ticketing
alter column Price decimal (10,2)

--there must be some non numeric values

select *from Railway_ticketing
where ISNUMERIC(Price)=0

--This function will check the non-numeric values which are restricting to change the datatype

alter table Railway_ticketing
alter column Date_of_Purchase date

select *from Railway_ticketing
where ISNUMERIC(Date_of_Purchase)=0

SELECT DISTINCT [Date_of_Purchase]
FROM Railway_ticketing;

---Checking date format
	SELECT ISDATE([Date_of_Purchase]) 
FROM Railway_ticketing;
--Handle multiple date formats and invalid values:
SELECT
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 103) IS NOT NULL
            THEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 103)
        WHEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 101) IS NOT NULL
            THEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 101)
        WHEN TRY_PARSE([Date_of_Purchase] AS DATE USING 'en-US') IS NOT NULL
            THEN TRY_PARSE([Date_of_Purchase] AS DATE USING 'en-US')
        ELSE NULL
    END AS [Date_Of_Purchase]
FROM
    Railway_ticketing;
select *from Railway_ticketing
-Update date data type column in table

UPDATE Railway_ticketing
SET [Date_of_Purchase] = CASE
        WHEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 103) IS NOT NULL
            THEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 103)
        WHEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 101) IS NOT NULL
            THEN TRY_CONVERT(DATE, REPLACE(REPLACE([Date_of_Purchase], '*', ''), ' ', ''), 101)
        WHEN TRY_PARSE([Date_of_Purchase] AS DATE USING 'en-US') IS NOT NULL
            THEN TRY_PARSE([Date_of_Purchase] AS DATE USING 'en-US')
        -- Add more WHEN clauses for other date formats
        ELSE NULL
    END;


alter table Railway_ticketing
alter column Time_of_Purchase time
---sucess
alter table Railway_ticketing
alter column Departure_Time time
--Anomaly
--Converting the Departure_Time into Time datatype
SELECT
    CASE
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 109) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 109)
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 108) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 108)
        -- Add more WHEN clauses for other time formats
        ELSE NULL
    END AS [Departure_Time]
FROM
    Railway_ticketing;

--Update the Table
UPDATE Railway_ticketing
SET [Departure_Time] = 
    CASE
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 109) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 109)
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 108) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Departure_time], '*', ''), ' ', ''), 108)
        -- Add more WHEN clauses for other time formats
        ELSE NULL
    END;


alter table Railway_ticketing
alter column Arrival_Time time
--sucess
alter table Railway_ticketing
alter column Actual_Arrival_Time time

---Convertion of 'Actual_Arrival_Time'
SELECT
    CASE
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 109) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 109)
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 108) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 108)
        ELSE NULL
    END AS [Actual_Arrival_Time]
FROM
    Railway_ticketing;

--Update the table

UPDATE Railway_ticketing
SET [Actual_Arrival_Time] = CASE
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 109) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 109)
        WHEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 108) IS NOT NULL
            THEN TRY_CONVERT(TIME, REPLACE(REPLACE([Actual_Arrival_Time], '*', ''), ' ', ''), 108)
        -- Add more WHEN clauses for other time formats
        ELSE NULL
    END ;

--Checking Duplicate

select distinct count(*) from Railway_ticketing

with dupl_rows as(select *,row_number() over(partition by Transaction_ID order by Transaction_ID) as row_num
from Railway_ticketing)
select * from dupl_rows
where row_num=1

---Checking duplicate
with dupl_rows as(select *,row_number() over(partition by Transaction_ID order by Transaction_ID) as row_num
from Railway_ticketing)
select * from dupl_rows
where row_num>1

--No duplicates Found


----Changing price data type into numeric

SELECT Price,CASE WHEN Price LIKE '%[@#$%&*)^_+=-u]%' OR Price LIKE '%[_]%' THEN REPLACE(REPLACE(Price,
SUBSTRING(Price, PATINDEX('%[~!@#*&^ú$A()_+^-]%', Price), 1),''),'--','' )ELSE Price END
FROM Railway_ticketing
WHEREISNUMERIC(Price) = 0;

--Patindex-It gives the number

SELECT Price, CASE
        WHEN Price LIKE '31&^%' THEN REPLACE(REPLACE(Price, '&^', ''), '%', '')
        WHEN Price LIKE '4ú%' THEN REPLACE(Price, 'ú', '')
        WHEN Price LIKE '3--%' THEN REPLACE(Price, '--', '')
		 WHEN Price LIKE '3$%' THEN REPLACE(Price, '$', '')
        WHEN Price LIKE '16A%' THEN REPLACE(Price, 'A', '')
        ELSE Price
    END
FROM Railway_ticketing
WHERE ISNUMERIC(Price) = 0;

update Railway_ticketing set Price = CASE WHEN Price LIKE '%[@#$%&*)^_+^=-u]%' OR Price LIKE '%[_]%' THEN REPLACE(REPLACE(Price,
SUBSTRING(Price, PATINDEX('%[~!@#*&^ú$A()_+^-]%', Price), 1),''),'--','' )ELSE Price END

alter table Railway_ticketing
alter column Price decimal (10,2)

select Price from Railway_ticketing
where ISNUMERIC(Price)=0

select Date_of_Purchase from Railway_ticketing
where ISNUMERIC(Date_of_Purchase)=0

select *from Railway_ticketing
-------Changing Departure_Time data type into Time


--1>Identify Peak Purchase Times and Their Impact on Delays
SELECT
    DATEPART(HOUR, [Time_of_Purchase]) AS Purchase_Hour,
    COUNT(*) AS Tickets_Purchased,
    AVG(DATEDIFF(MINUTE, [Actual_Arrival_Time], [Arrival_Time])) AS Avg_Delay_Minutes
FROM
    Railway_ticketing
GROUP BY
    DATEPART(HOUR, [Time_of_Purchase])
ORDER BY
    Purchase_Hour;
--Insights--this query identifies the peak purchase times by hour and calculates the average delay in minutes for each hour. 
--It provides insights into how ticket purchases correlate with delays in the railway system.

--2.Analyze Journey Patterns of Frequent Travelers

	select *from Railway_ticketing
--------------------------
--2>
SELECT
    [Departure_Station],
    [Arrival_Destination],
    [Date_of_Journey] ,
    COUNT(*) AS PurchaseCount
FROM
    Railway_ticketing
GROUP BY
    [Departure_Station],
    [Arrival_Destination],
    [Date_of_Journey]
HAVING
    COUNT(*) > 3;


	--INSIGHTS-- this query identifies combinations of departure stations, arrival destinations, 
	--and journey dates where there have been more than three occurrences. 
	--These frequent patterns can provide insights into popular routes or travel preferences.

--3>Revenue Loss Due to Delays with Refund Requests: 
--This query calculates the total revenue loss due to delayed journeys 
--for which a refund request was made.
SELECT
    SUM(Price) AS TotalRevenueLoss
FROM
    Railway_ticketing
WHERE
    Journey_Status = 'Delayed'
    AND Refund_Request = 'Yes';

--4>Impact of Railcards on Ticket Prices and Journey Delays: 
--This query analyzes the average ticket price and delay rate for journeys purchased with
--and without railcards.

SELECT
    Railcard,
    AVG(Price) AS AvgTicketPrice,
    SUM(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) AS DelayedJourneys
FROM
    Railway_ticketing
GROUP BY
    Railcard;
--INSHIGTS--This query calculates the total revenue loss from delayed journeys where passengers have requested refunds.
--Identifying the revenue loss due to delays and refunds, 
--railway operators can focus on improving punctuality and customer satisfaction.

5>	Journey Performance by Departure and Arrival Stations:
--This query evaluates the performance of journeys
--by calculating the average delay time for each pair of departure and arrival stations.


SELECT
    Departure_Station,
    Arrival_Destination,
    AVG(CASE WHEN Journey_Status = 'Delayed' THEN DATEDIFF(MINUTE, Departure_Time, Arrival_Time) ELSE 0 END) AS AvgDelayTimeMinutes
FROM Railway_ticketing
GROUP BY
    Departure_Station,
    Arrival_Destination;

--Insights:
--The query provides insights into average delay times for specific routes.
--For each combination of departure and arrival stations, you can see the average delay experienced by passengers.
--Railway operators can use this information to identify problem areas, allocate resources, and improve service quality.

6>Revenue and Delay Analysis by Railcard and Station
--This query combines revenue analysis with delay statistics, providing insights into journeys' 
--performance and revenue impact involving different railcards and stations.


SELECT
    Railcard,
    Departure_Station,
    Arrival_Destination,
    AVG(Price) AS AvgTicketPrice,
    SUM(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) AS DelayedJourneys
FROM Railway_ticketing
GROUP BY
    Railcard,
    Departure_Station,
    Arrival_Destination;

--Insights:

--The query provides information about average ticket prices and the number of delayed journeys for specific routes.
--For each combination of railcard and stations, we can see the average ticket price and the impact of delays.
--Railway operators can use this data to optimize pricing strategies and address delays on popular routes.


7>Journey Delay Impact Analysis by Hour of Day
--This query analyzes how delays vary across different hours of the day, 
--calculating the average delay in minutes for each hour and identifying the peak 
--hours for delays.

SELECT
    DATEPART(HOUR, Departure_Time) AS HourOfDay,
    AVG(CASE WHEN Journey_Status = 'Delayed' THEN DATEDIFF(MINUTE, Departure_Time, Arrival_Time) ELSE 0 END) AS AvgDelayMinutes
FROM Railway_ticketing
GROUP BY DATEPART(HOUR, Departure_Time)
ORDER BY HourOfDay;


--Insights(7)-1>By examining the average delay times for each hour, 
--we can identify peak hours when delays are most common.
--2>Resource Allocation:
--Knowing peak delay hours helps allocate resources effectively.
--Rail operators can schedule additional staff, maintenance, or inspections during these times to minimize disruptions.
--3>Service Improvements:
--If certain hours consistently experience delays, rail companies can investigate the root causes.
--Addressing infrastructure issues, improving signaling systems, or adjusting schedules can lead to better performance.
--4>Customer Communication:
--Passengers can be informed about expected delays during peak hours.
--Real-time alerts or alternative travel options can enhance customer experience


