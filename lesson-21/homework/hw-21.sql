select * from Employees1
--1-- Write a query to assign a row number to each sale based on the SaleDate.
select SaleID,, SaleDate,
 ROW_NUMBER() OVER (ORDER BY SaleDate ) AS RowNum
 FROM ProductSales;
 --2. Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
select ProductName, SUM (SaleAmount * Quantity) AS TotalQ,
  DENSE_RANK() OVER ( ORDER BY SUM (SaleAmount * Quantity)  ) AS dns
  FROM ProductSales
  GROUP BY ProductName
  --3. Write a query to identify the top sale for each customer based on the SaleAmount.
  SELECT   CustomerID, SaleAmount
FROM (
  SELECT   CustomerID, SaleAmount,
         DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rankk
  FROM ProductSales
) t
WHERE rankk = 1;
--4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
SELECT saledate, saleamount,
       LEAD(saleamount) OVER (ORDER BY saledate) AS next_amount
FROM Productsales;
--5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
SELECT saledate, saleamount,
       LAG(saleamount) OVER (ORDER BY saledate) AS prev_amount
FROM Productsales;
--6. Write a query to identify sales amounts that are greater than the previous salesamount
SELECT 
    SaleDate,
    SaleAmount
FROM (
    SELECT 
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevAmount;
--7. Write a query to calculate the difference in sale amount from the previous sale for every product
  select productName,SaleAmount,
  SaleAmount - LAG(SaleAmount)OVER (PARTITION BY productName ORDER BY SaleDate) As Differnce
    FROM ProductSales;
   --8.  Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
 SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS Next_Amount,
    ROUND(
        ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount)
         / NULLIF(SaleAmount, 0)) * 100, 2
    ) AS PercentChange
FROM ProductSales;
--9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount,
    ROUND(
        (SaleAmount / NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0)), 
        2
    ) AS Ratio
FROM ProductSales;
--10. Write a query to calculate the difference in sale amount from the very first sale of that product.
select ProductName,SaleDate,SaleAmount,
   SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS firest
FROM ProductSales;
--11. Write a query to find sales that have been increasing continuously for a product 
--(i.e., each sale amount is greater than the previous sale amount for that product).
SELECT *
FROM (
    SELECT 
        ProductName,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevAmount;

  select * from ProductSales
--12. Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
 SELECT ProductName,SaleDate, SaleAmount,
 SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RunningTotal
 FROM ProductSales
--13. Write a query to calculate the moving average of sales amounts over the last 3 sales.
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg
FROM ProductSales;
--14. Write a query to show the difference between each sale amount and the average sale amount.
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName ) AS MovingAvg,
	SaleAmount - AVG(SaleAmount) OVER (PARTITION BY ProductName) AS diffAmount
	FROM ProductSales;
--15. Find Employees Who Have the Same Salary Rank
select name, salary ,     
RANK() OVER ( ORDER BY salary ) AS rnk
FROM Employees1
where salary=rnk
--16. Identify the Top 2 Highest Salaries in Each Department
SELECT   name, department, Salary
FROM (
  SELECT name,department, Salary,
         DENSE_RANK() OVER (PARTITION BY department ORDER BY Salary DESC) AS rankk
  FROM Employees1
) t
WHERE rankk <= 2;
--17. Find the Lowest-Paid Employee in Each Department
SELECT   name, department, Salary
FROM (
  SELECT name,department, Salary,
         DENSE_RANK() OVER (PARTITION BY department ORDER BY Salary ASC) AS rankk
  FROM Employees1
) t
WHERE rankk=1
--18. Calculate the Running Total of Salaries in Each Department

SELECT 
    department,
    salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS RunningTotal
FROM Employees1;
