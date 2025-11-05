--1--
select saleID, Product, Quantity,SaleDate
from #Sales s
where exists (
select 1
from #Sales 
where s.SaleID=SaleID
and Quantity >=1
 AND MONTH(SaleDate) = 3
AND YEAR(SaleDate) = 2024);
--2--Find the product with the highest total sales revenue using a subquery.
SELECT TOP 1 
 SaleID,
(SELECT SUM(Quantity * Price)
FROM #Sales AS s2
WHERE s2.SaleID = s.SaleID) AS TotalSalesRevenue
FROM #Sales AS s
ORDER BY TotalSalesRevenue DESC;
--3--Find the second highest sale amount using a subquery
SELECT MAX(Quantity * Price) AS SecondHighestSaleAmount
FROM #Sales
WHERE (Quantity * Price) < (
SELECT MAX(Quantity * Price)
FROM #Sales
);  
--4-- Find the total quantity of products sold per month using a subquery
SELECT 
    MONTH(SaleDate) AS Monthly,
    (SELECT SUM(s2.Quantity)
     FROM #Sales AS s2
     WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)) AS TotalQuantity
FROM #Sales AS s1
GROUP BY MONTH(SaleDate);
--5--Find customers who bought same products as another customer using EXISTS
SELECT DISTINCT s1.CustomerName
FROM  #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
); 
--6--
select * from (
SELECT Name, Fruit
FROM  Fruits) as sourcetable
PIVOT 
( 
COUNT(Fruit) 
FOR Fruit IN ([Apple],[Orange],[Banana]) 
) AS PivotTable 
--7--
WITH FamilyCTE AS (
    SELECT ParentID, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentID, c.ChildID
    FROM Family f
    JOIN FamilyCTE c ON f.ChildID = c.ParentID)
SELECT DISTINCT ParentID, ChildID
FROM FamilyCTE
ORDER BY ParentID, ChildID;
--8--
SELECT *
FROM #Orders t
WHERE t.DeliveryState = 'TX'
  AND EXISTS (
 SELECT 1
FROM #Orders c
WHERE c.CustomerID = t.CustomerID
AND c.DeliveryState = 'CA' );
--9-- Insert the names of residents if they are missing
select * from #residents
SELECT fullName
FROM #residents AS r
WHERE NOT EXISTS (
    SELECT 1
    FROM #residents AS rs
    WHERE r.resID = rs.resID
);
