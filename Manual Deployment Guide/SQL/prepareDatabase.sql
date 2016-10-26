IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandForecast24hrs'))
BEGIN
CREATE TABLE [dbo].[DemandForecast24hrs] (
    [utcTimeStamp] DATETIME   NOT NULL,
    [PTID]      BIGINT     NOT NULL,
    [Forecast]  FLOAT (53) NULL,
    [RunTime]   DATETIME   NOT NULL,
    [Horizon]   BIGINT     NULL,
    CONSTRAINT [PK_DemandForecast24hrs] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC, [RunTime] ASC)
);
END
go


IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandForecast24hrsTemp'))
BEGIN
CREATE TABLE [dbo].[DemandForecast24hrsTemp] (
    [utcTimeStamp] DATETIME   NOT NULL,
    [PTID]      BIGINT     NOT NULL,
    [Forecast]  FLOAT (53) NULL,
    [RunTime]   DATETIME   NOT NULL,
    [Horizon]   BIGINT     NULL,
    CONSTRAINT [PK_DemandForecast24hrsTemp] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC, [RunTime] ASC)
);
END
go


IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandHistory5Minutes'))
BEGIN
CREATE TABLE [dbo].[DemandHistory5Minutes] (
    [utcTimeStamp] DATETIME    NOT NULL,
    [PTID]      BIGINT         NOT NULL,
    [Load]      FLOAT (53)     NULL,
    CONSTRAINT [PK_DemandHistory5Minutes] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC)
);
END
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandHistory5Minutes_EHLog'))
BEGIN
CREATE TABLE [dbo].[DemandHistory5Minutes_EHLog] (
    [utcTimeStamp] DATETIME    NOT NULL,
    [PTID]      BIGINT         NOT NULL,
    [Load]      FLOAT (53)     NULL,
    [EventTime] DATETIME       NOT NULL,
    [Flag]      NVARCHAR (MAX) NULL,
    [Detail]    NVARCHAR (MAX) NULL,
	CONSTRAINT [pk_DemandHistory5Minutes_EHLog] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC, [EventTime] ASC)	
);
END
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandHistory5Minutes_SQLLog'))
BEGIN
CREATE TABLE [dbo].[DemandHistory5Minutes_SQLLog] (
    [utcTimeStamp] DATETIME    NOT NULL,
    [PTID]      BIGINT         NOT NULL,
    [Load]      FLOAT (53)     NULL,
    [EventTime] DATETIME       NOT NULL,
    [Flag]      NVARCHAR (MAX) NULL,
    [Detail]    NVARCHAR (MAX) NULL,
	CONSTRAINT [pk_DemandHistory5Minutes_SQLLog] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC, [EventTime] ASC)	
);
END
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'DemandForecastHourly'))
BEGIN
CREATE TABLE [dbo].[DemandHistoryHourly] (
    [utcTimeStamp]   DATETIME       NOT NULL,
    [PTID]        BIGINT         NOT NULL,
    [HourAvgLoad] REAL           NULL,
    CONSTRAINT [PK_DemandForecastHourly] PRIMARY KEY CLUSTERED ([utcTimeStamp] ASC, [PTID] ASC)
);
END
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'RegionLookup'))
BEGIN
CREATE TABLE [dbo].[RegionLookup] (
    [PTID]      BIGINT         NOT NULL,
    [Name]      NVARCHAR (MAX) NULL,
    [Latitude]  FLOAT (53)     NULL,
    [Longitude] FLOAT (53)     NULL,
	CONSTRAINT [PK_RegionLookup] PRIMARY KEY CLUSTERED ( [PTID] ASC)
);
END
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'WeatherHourly'))
BEGIN
CREATE TABLE [dbo].[WeatherHourly] (
    [utcTimestamp]             DATETIME      not NULL,
    [PTID]                INT           NOT NULL,
    [temperature]         FLOAT (53)    not NULL,
    [forecastflag]                INT  not NULL,
    CONSTRAINT [PK_WeatherHourly] PRIMARY KEY CLUSTERED ([utcTimestamp] ASC, [PTID] ASC)
);
END
go

CREATE TYPE [dbo].[WeatherHourlyType] 
AS TABLE (
    [utcTimestamp]             DATETIME      not NULL,
    [PTID]                INT           NOT NULL,
    [temperature]         FLOAT (53)    not NULL,
    [forecastflag]                int  not NULL
);
go

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'WeatherHourly_SQLLog'))
BEGIN
CREATE TABLE [dbo].[WeatherHourly_SQLLog] (
    [utcTimestamp]             DATETIME      not NULL,
    [PTID]                INT           NOT NULL,
    [temperature]         FLOAT (53)    not NULL,
    [forecastflag]                int   not NULL,
    [EventTime] DATETIME       NOT NULL,
    [Flag]      NVARCHAR (MAX) NULL,
    [Detail]    NVARCHAR (MAX) NULL,
	CONSTRAINT [pk_WeatherHourly_SQLLog] PRIMARY KEY CLUSTERED ([utcTimestamp] ASC, [PTID] ASC, [EventTime] ASC)	
);
END
go


CREATE VIEW [dbo].[v_DemandHistoryHourly]
	AS (
SELECT a.utcTimeStamp,a.PTID,b.Name,a.HourAvgLoad AS Demand, b.Longitude,b.Latitude
FROM
(SELECT * FROM DemandHistoryHourly WHERE utcTimeStamp>=DATEADD(day, -7, GETDATE())) a
JOIN
RegionLookup b
ON b.PTID=a.PTID
);
go



CREATE VIEW [dbo].[v_24HrsForecastLatest]
	AS (
SELECT utcTimeStamp, PTID, Forecast, RunTime, Horizon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY utcTimeStamp, PTID ORDER BY RunTime DESC) AS RowNum
FROM DemandForecast24hrs
) a
WHERE RowNum=1
);
go


CREATE VIEW [dbo].[v_24hrsForecastPointErrorOngoing]
	AS (
SELECT a.utcTimeStamp,a.PTID,c.Name,b.HourAvgLoad AS Demand, a.Forecast, abs(b.HourAvgLoad-a.Forecast)/b.HourAvgLoad*100 AS APE, (b.HourAvgLoad-a.Forecast) AS Error, c.Longitude,c.Latitude
FROM
(SELECT utcTimeStamp, PTID, Forecast FROM v_24HrsForecastLatest
WHERE utcTimeStamp>=DATEADD(day, -7, GETDATE())) a
left join
(SELECT utcTimeStamp, PTID, HourAvgLoad FROM DemandHistoryHourly 
WHERE utcTimeStamp>=DATEADD(day, -7, GETDATE())) b
ON a.utcTimeStamp=b.utcTimeStamp and a.PTID=b.PTID
left join
RegionLookup c
ON c.PTID=a.PTID
);
go

CREATE VIEW [dbo].[v_WeatherHourly]
	AS (
SELECT a.utcTimestamp as Time, a.PTID, b.Name as Region, b.Longitude, b.Latitude, a.temperature as Temperature, a.Flag FROM
(SELECT utcTimestamp, PTID, temperature, CASE forecastflag WHEN 1 THEN 'true' WHEN 0 THEN 'forecast' End AS Flag from WeatherHourly
WHERE utcTimestamp>=DATEADD(day, -7, GETDATE()) AND utcTimestamp<=DATEADD(day, 1, GETDATE())) a 
join
(SELECT PTID, NAME, Longitude, Latitude FROM RegionLookup) b
on a.PTID=b.PTID
);
go


IF (EXISTS (SELECT * 
                 FROM sys.types 
                 WHERE is_table_type =1 and name='DemandForecastHourlyType'))
	drop type  DemandForecastHourlyType;
go 


CREATE TYPE [dbo].[DemandForecastHourlyType] AS TABLE (
    [utcTimeStamp] DATETIME   NULL,
    [PTID]      BIGINT     NULL,
    [Forecast]  FLOAT (53) NULL);
go

--IF (EXISTS (SELECT * 
--                 FROM sys.types 
--                 WHERE is_table_type =1 and name='DemandForecast5hrsType'))
--	drop type [dbo].[DemandForecast5hrsType] ;
--go 

--REATE TYPE [dbo].[DemandForecast5hrsType] AS TABLE (
--    [utcTimeStamp] DATETIME   NULL,
--    [PTID]      BIGINT     NULL,
--    [Forecast]  FLOAT (53) NULL);
--go

IF (EXISTS (SELECT * 
                 FROM information_schema.routines
                 WHERE ROUTINE_NAME = 'sqlhourldata'))
	drop procedure sqlhourldata;
go

CREATE PROCEDURE sp_aggregatehourly_ongoing
AS
BEGIN
INSERT DemandHistoryHourly(utcTimeStamp, PTID, HourAvgLoad)
select dateadd(hh,datepart(hh,utcTimeStamp), cast(CAST(utcTimeStamp as date) as datetime)) as utcTimeStamp, 
PTID, AVG(Load) as HourAvgLoad
from DemandHistory5Minutes
where dateadd(hh,datepart(hh,utcTimeStamp), cast(CAST(utcTimeStamp as date) as datetime)) in  
(
select distinct(dateadd(hh,datepart(hh,utcTimeStamp), cast(CAST(utcTimeStamp as date) as datetime))) as utcTimeStampHour from DemandHistory5Minutes 
group by (dateadd(hh,datepart(hh,utcTimeStamp), cast(CAST(utcTimeStamp as date) as datetime)))
having count(*) >=121
except
select distinct utcTimeStamp from DemandHistoryHourly
)
group by dateadd(hh,datepart(hh,utcTimeStamp), cast(CAST(utcTimeStamp as date) as datetime)),  PTID
END
GO

CREATE PROCEDURE sp_aggregatehourly_onetime
AS
BEGIN
insert into DemandHistoryHourly 
select concat(convert(date, utcTimeStamp, 112), ' ', DATEPART(HOUR, utcTimeStamp),':00:00'), ptid, avg(load) 
from DemandHistory5Minutes 
group by concat(convert(date, utcTimeStamp, 112), ' ', DATEPART(HOUR, utcTimeStamp),':00:00'), ptid; 
END
GO

CREATE PROCEDURE sp_Data_simulator_5Minutes_getdata ( @dt datetime)
AS
SET NOCOUNT ON;
BEGIN	
	--declare @dt datetime = '2016-02-28 10:20:00'
	select 
		(case when convert(varchar(5),@dt,110) ='02-29' then
				dateadd(day, 1, dateadd(year, 1, utcTimeStamp))
				else dateadd(year, 1, utcTimeStamp) end) as utcTimeStamp, ptid, load 
	from DemandHistory5Minutes A
	where convert(date, utcTimeStamp, 112) = convert(date, dateadd(year, -1, @dt), 112);
END;
GO

CREATE PROCEDURE sp_Data_simulator_weather_getdata ( @dt datetime)
AS
SET NOCOUNT ON;
BEGIN	
	--declare @dt datetime = '2016-02-28 10:20:00'
	select 
		(case when convert(varchar(5),@dt,110) ='02-29' then
				dateadd(day, 1, dateadd(year, 1, utcTimeStamp))
				else dateadd(year, 1, utcTimeStamp) end) as utcTimeStamp, ptid, temperature 
	from WeatherHourly A
	where convert(date,utcTimeStamp,112) = convert(date, dateadd(year, -1, @dt), 112) ;
END;
GO

CREATE PROCEDURE sp_Data_simulator_weather_forecast ( @dt datetime, @ptid int)
AS
SET NOCOUNT ON;
BEGIN   
                --declare @dt datetime = '2016-02-28 10:20:00'
                MERGE WeatherHourly AS target
                                USING (SELECT (case when convert(varchar(5),@dt,110) ='02-29' then dateadd(day, 1, dateadd(year, 1, utcTimeStamp)) else dateadd(year, 1, utcTimeStamp) end) as utcTimestamp, 
                                                                                                ptid, round(temperature*(RAND(CHECKSUM(NEWID()))*(105.99-94.99)+94.99)/100,1) as temperature, 
                                                          (case when dateadd(year, 1, utcTimeStamp) = dateadd(hour, -1, @dt) then 1 else 0 end) as forecastflag 
                                                    from WeatherHourly 
                                                                where utcTimeStamp >= dateadd(year, -1, dateadd(hour, -1, @dt)) and utcTimeStamp <= dateadd(hour, 24, dateadd(year, -1, @dt)) and ptid=@ptid) AS source
                                ON (target.ptid = source.ptid and target.utcTimestamp=source.utcTimestamp)
                                WHEN MATCHED THEN 
                                                UPDATE SET temperature= source.temperature, forecastflag= source.forecastflag
                                WHEN NOT MATCHED THEN
                                                INSERT (utcTimestamp, ptid, temperature, forecastflag)
                                                VALUES (source.utcTimestamp, source.ptid, source.temperature, source.forecastflag);    
END;
GO

insert into RegionLookup values(61752,'WEST',42.882002,-78.823471);
insert into RegionLookup values(61753,'GENESE',43.196166,-77.018967);
insert into RegionLookup values(61754,'CENTRL',42.443728,-76.758041);
insert into RegionLookup values(61755,'NORTH',44.671583,-73.515701);
insert into RegionLookup values(61756,'MHK VL',43.836508,-75.466461);
insert into RegionLookup values(61757,'CAPITL',43.09998,-73.795853);
insert into RegionLookup values(61758,'HUD VL',41.772336,-73.97541);
insert into RegionLookup values(61759,'MILLWD',41.258711,-73.797569);
insert into RegionLookup values(61760,'DUNWOD',41.075469,-73.818684);
insert into RegionLookup values(61761,'N.Y.C.',40.78834,-73.951378);
insert into RegionLookup values(61762,'LONGIL',40.776382,-73.227997);






