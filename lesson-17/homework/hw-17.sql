--# 1. You must provide a report of all distributors and their sales by region.  If a distributor did not have any sales for a region, 
--provide a zero-dollar value for that day. Assume there is at least one sale for each region
select * from #RegionSales
SELECT
    r.Region,
	d.Distributor,
    COALESCE(SUM(s.Sales), 0) AS TotalSales
FROM 
    (SELECT DISTINCT Distributor FROM #RegionSales) d     -- 1
CROSS JOIN 
    (SELECT DISTINCT Region FROM #RegionSales) r          -- 2
LEFT JOIN 
    #RegionSales s                                        -- 3
    ON s.Distributor = d.Distributor 
   AND s.Region = r.Region
GROUP BY 
    d.Distributor, r.Region                             -- 4
ORDER BY 
    d.Distributor, r.Region;                            -- 5
	--2. Find managers with at least five direct reports
SELECT e.id, e.name
FROM Employee e
WHERE (
    SELECT COUNT(*)
    FROM Employee p
    WHERE p.managerId = e.id
) >= 5;
--### 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select * from products 
select *from orders
SELECT Product_Name
FROM Products p
WHERE 100 <= (
  SELECT SUM(unit)
  FROM Orders o
  WHERE o.Product_ID = p.Product_ID
 AND MONTH(Order_Date) = 2
 AND YEAR(Order_Date) = 2020);
 --4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
SELECT customerid, vendor, num_orders
FROM (
    SELECT   customerid,   vendor, 
        COUNT(*) AS num_orders,
        ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY COUNT(*) DESC) AS rn
    FROM orders
    GROUP BY customerid, vendor
) AS ranked
WHERE rn = 1
ORDER BY customerid;
--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 
--'This number is not prime'
DECLARE @Check_Prime INT = 91;
SELECT CASE 
         WHEN @Check_Prime > 1 
              AND NOT EXISTS (
                  SELECT 1
                  FROM master..spt_values AS n
                  WHERE n.type = 'P' 
                    AND n.number BETWEEN 2 AND @Check_Prime - 1
                    AND @Check_Prime % n.number = 0)
 THEN 'This number is prime'
 ELSE 'This number is not prime'
       END AS Result;
--### 6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device
--from the given table.
select * from Device
SELECT
    Device_ID,
    COUNT(DISTINCT Locations) AS no_of_location,
    (SELECT TOP 1 Locations
     FROM Device d2
     WHERE d2.Device_ID = d1.Device_ID
     GROUP BY Locations
     ORDER BY COUNT(*) DESC) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d1
GROUP BY Device_ID
ORDER BY Device_ID;
--7. Write a SQL  to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output

SELECT EmpID, EmpName, Salary
FROM (
    SELECT *,
           AVG(Salary) OVER (PARTITION BY Deptid) AS DeptAvg
    FROM Employee
) t
WHERE Salary >= DeptAvg
order by salary desc;
--8You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers
--.  If a ticket has some but not all the winning numbers, you win $10.  If a ticket has all the winning numbers, you win $100.    
--Calculate the total winnings for today’s drawing.
WITH TicketWinnings AS (
    SELECT t.TicketID,
           CASE 
               WHEN COUNT(n.Number) = (SELECT COUNT(*) FROM Numbers) THEN 100
               WHEN COUNT(n.Number) > 0 THEN 10
               ELSE 0
           END AS Winnings
    FROM Tickets t
    LEFT JOIN Numbers n
           ON t.Number = n.Number
    GROUP BY t.TicketID
)
-- Total winnings
SELECT SUM(Winnings) AS TotalWinnings
FROM TicketWinnings;

