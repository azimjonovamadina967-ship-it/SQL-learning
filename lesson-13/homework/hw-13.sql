--Easy Tasks 1-8
------1----------
SELECT   CONCAT  (employee_id, '-', first_name, ' ', last_name) AS FullName
FROM Employees ;
-----2--------  
SELECT First_Name, REPLACE(PHONE_NUMBER, '124', '999') AS Result
FROM Employees;
--3---
SELECT FIRST_NAME, LEN  (FIRST_NAME) AS Namelength
FROM Employees
WHERE LEFT (FIRST_NAME,1) IN ('A', 'J', 'M')
ORDER BY FIRST_NAME;
-----4-----
SELECT * FROM Employees
SELECT  Manager_ID, 
 SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Manager_ID;
---5----
SELECT Year1,
GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;
------6-----
SELECT id, description
from cinema
where id %2=1 
AND description <> 'boring';
-----7----
select * from SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;
--8---
SELECT ID,
COALESCE (SSN,PASSPORTID,ITIN ) AS FirstAvailablePhone
FROM Person;
--Medium Tasks 1-5
SELECT
  LEFT(FullName, CHARINDEX(' ', FullName + ' ') - 1) AS FirstName,            ----------splitting fullname
  LTRIM(RTRIM(PARSENAME(REPLACE(FullName, ' ', '.'), 2))) AS MiddleName,
  RIGHT(FullName, CHARINDEX(' ', REVERSE(FullName) + ' ') - 1) AS LastName
FROM Students;
---------2-------
SELECT  CustomerID, OrderID,DeliveryState,Amount
FROM Orders
WHERE DeliveryState = 'TX'
 AND CustomerID IN (
 SELECT CustomerID    
 FROM Orders
 WHERE DeliveryState = 'CA'
    );
--3--  
SELECT STRING_AGG(String, ',') AS FullQuery
FROM DMLTable;
----4-----
SELECT CONCAT(First_name, ' ', Last_name) AS FullName
FROM Employees
WHERE CONCAT(First_name, ' ', Last_name) LIKE '%A%A%A%';
-----5-------
select department_id, 
count(*) as totolemploes, 
sum(case 
        when DATEDIFF(YEAR, Hire_Date, GETDATE()) > 3 then 1 
        else 0 
        end ) * 100.0/count(*) as persentover3year
from Employees 
group by department_id 
---difficult tasks 1-4----
SELECT * FROM Students
SELECT
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotal
FROM Students;
----2----
SELECT  Birthday,
STRING_AGG(StudentName, ', ') AS StudentNames,COUNT(*) AS StudentCount
FROM Student
GROUP BY  Birthday
HAVING COUNT(*) > 1;
----3----
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
----4----
DECLARE @str VARCHAR(50) = 'tf56sd#%OqH';
  ;WITH cte AS (
    -- birinchi belgini olamiz
    SELECT 1 AS pos, SUBSTRING(@str, 1, 1) AS ch
    UNION ALL
    -- qolgan belgilarni birma-bir olamiz
    SELECT pos + 1, SUBSTRING(@str, pos + 1, 1)
    FROM cte
    WHERE pos < LEN(@str)
)
SELECT
    -- katta harflar
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS UpperCaseLetters,
    -- kichik harflar
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS LowerCaseLetters,
    -- raqamlar
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
    -- boshqa belgilar
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS OtherCharacters
FROM cte
OPTION (MAXRECURSION 100);  -- satr uzunligi 100 belgigacha bo‘lsin 
