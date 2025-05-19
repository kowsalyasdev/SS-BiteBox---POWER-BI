select * from SSBiteBox_Data 


--update SSBiteBox_Data set Item_Fat_Content=
--case when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
--when Item_Fat_Content ='reg' then 'Regular'
--else Item_Fat_Content end

----Total Sales
select cast(sum(Sales)/1000000 AS Decimal(18,2)) AS [Total_Sales_Millions]
from SSBiteBox_Data 

----Avg Sales
select cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales]
from SSBiteBox_Data 

----No of Sales items
select count(*) AS [No_Of_Items] from SSBiteBox_Data 

----Avg Ratings
select cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data

----Total Sales by Fat Content
select Item_Fat_Content,cast(sum(Sales)/1000 AS Decimal(18,2)) AS [Total_Sales_Thousand],
cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales],count(*) AS [No_Of_Items],
cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data
group by Item_Fat_Content
order by [Total_Sales_Thousand] desc

----Total Sales by Item type
select Item_Type,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales],
cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales],count(*) AS [No_Of_Items],
cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data
group by Item_Type
order by [Total_Sales] desc

--Fat Content by outlet for Total sales

select Outlet_Location_Type,
       [Low Fat] as [Low_Fat],
	   [Regular] as [Regular]
from(
select Outlet_Location_Type,Item_Fat_Content,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales]
from SSBiteBox_Data
group by Outlet_Location_Type,Item_Fat_Content ) as sourcetable
pivot(sum([Total_Sales]) for Item_Fat_Content in([Low Fat],[Regular])) as [pivot table]
order by Outlet_Location_Type

--Total sales by Outlet Establishment

select Outlet_Establishment_Year,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales],
cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales],count(*) AS [No_Of_Items],
cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data
group by Outlet_Establishment_Year
order by  [Total_Sales] desc

--Percentage of sales by Outlet Size

select Outlet_Size,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales],
cast((sum(Sales)*100/sum(sum(Sales)) over()) AS Decimal(18,2)) AS [Sales_Percentage]
from SSBiteBox_Data
group by Outlet_Size
order by  [Total_Sales] desc

--sales by outlet location

select Outlet_Location_Type,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales],
cast((sum(Sales)*100/sum(sum(Sales)) over()) AS Decimal(18,2)) AS [Sales_Percentage],
cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales],count(*) AS [No_Of_Items],
cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data
group by Outlet_Location_Type
order by  [Total_Sales] desc

--All metrics by Outlet Type

select Outlet_Type,cast(sum(Sales) AS Decimal(18,2)) AS [Total_Sales],
cast((sum(Sales)*100/sum(sum(Sales)) over()) AS Decimal(18,2)) AS [Sales_Percentage],
cast(Avg(Sales) AS Decimal(18,2)) AS [Avg_Sales],count(*) AS [No_Of_Items],
cast(Avg(Rating) AS Decimal(18,2)) AS [Avg_Rating]
from SSBiteBox_Data
group by Outlet_Type
order by  [Total_Sales] desc


