--Puzzle 1: --In this puzzle you have to extract the month from the dt column and then append zero single digit month if any.
--Please check out sample input and expected output.
select * from dates
SELECT dt, FORMAT(dt, 'dd') AS MonthNumber
FROM dates;
--2In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals
--columns for each Id and RId. For more details please see the sample input and expected output.
select * from MyTabel
SELECT Id AS Distinct_Ids,
       RId,
       SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT Id,
           RId,
           MAX(vals) AS MaxVal
    FROM mytabel
    GROUP BY Id, RId
) AS t
GROUP BY Id, RId
ORDER BY Id, RId;
--Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.
SELECT *
FROM TestFixLengths
WHERE LEN(vals) BETWEEN 6 AND 10;
--Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value.
--Please check out sample input and expected output.
select * from TestMaximum
SELECT t1.Id, t1.Item, t1.Vals
FROM testmaximum t1
WHERE t1.Vals = (
    SELECT MAX(t2.Vals)
    FROM testmaximum t2
    WHERE t2.Id = t1.Id
);
--Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only. 
--Please check out sample input and expected output.
 select id, sum(maxval) as SumOfMax
 from (select id,detailednumber,max(vals) as maxval from SumOfMax group by id,detailednumber) as t
 group by id;

 --Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then 
 --show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output.
 SELECT 
    a,
    b,
    CASE 
        WHEN a - b <> 0 THEN a - b
        ELSE ''
    END AS Difference
FROM TheZeroPuzzle ;
--7. What is the total revenue generated from all sales?  
select sum (quantitySold * unitprice) as revenue
from sales
--8. What is the average unit price of products?  
select product,avg(unitprice) as avgprc
from sales
group by product
--9. How many sales transactions were recorded?  
SELECT COUNT(*) AS TotalSales
FROM Sales;
--10. What is the highest number of units sold in a single transaction?  
SELECT  MAX(QuantitySold) AS HighestUnits
FROM Sales;
--11. How many products were sold in each category?  
select count (product) as num,category
from sales
group by category
--12. What is the total revenue for each region?  
select sum (quantitySold * unitprice) as revenue,region
from sales
group by region
--13. Which product generated the highest total revenue?  
select top 1 product,sum (quantitySold * unitprice) as revenue
from sales
group by product
order by revenue desc
--14. Compute the running total of revenue ordered by sale date.  
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) 
        OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales;
--15. How much does each category contribute to total sales revenue?  
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    ROUND(
        SUM(QuantitySold * UnitPrice) * 100.0 / 
        SUM(SUM(QuantitySold * UnitPrice)) OVER (), 2
    ) AS PercentOfTotal
FROM Sales
GROUP BY Category;
--17. Show all sales along with the corresponding customer names  
CREATE VIEW namesales AS
SELECT s.*, c.customername
FROM sales s
JOIN customers c
ON s.customerid = c.customerid

SELECT * FROM namesales;
--18. List customers who have not made any purchases  
SELECT c.customerid, c.customername
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.customerid = c.customerid
);

--19. Compute total revenue generated from each customer  
SELECT 
    c.customerid,
    c.customername,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c
    ON s.customerid = c.customerid
GROUP BY c.customerid, c.customername;
---20. Find the customer who has contributed the most revenue  
SELECT TOP 1
    c.customerid,
    c.customername,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c
    ON s.customerid = c.customerid
GROUP BY c.customerid, c.customername
ORDER BY TotalRevenue DESC;
--21. Calculate the total sales per customer
SELECT 
    c.customerid,
    c.customername,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalSales
FROM Sales s
JOIN Customers c
    ON s.customerid = c.customerid
GROUP BY c.customerid, c.customername
ORDER BY TotalSales DESC;
