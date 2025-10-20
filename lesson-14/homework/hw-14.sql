--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
SELECT
LEFT (Name,CHARINDEX (',',Name)-1) AS Name,
SUBSTRING (Name,CHARINDEX(',',Name )+1,LEN (Name) )AS Surname
from TestMultipleColumns;
--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT Strs
FROM TestPercent
WHERE CHARINDEX('%', Strs) > 0;
--Split a string based on dot(.).(Splitter)
SELECT Id, value
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');
--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots
SELECT id, vals 
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) >= 2;
--Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT LEN(texts)-LEN(REPLACE(texts, ' ', '')) Totalspace
FROM CountSpaces;
--Write a SQL query that finds out employees who earn more than their managers.(Employee)
select * from Employee
SELECT e.Name AS Empname, m.Name AS ManagerName
FROM Employee e
inner JOIN Employee m ON e.ManagerId=M.Id
WHERE e.Salary > m.Salary;
--Find the employees who have been with the company for more than 10 years, but less than 15 years.Display their Employee ID,
--First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT Employee_ID, First_Name, Last_Name, Hire_Date,
DATEDIFF (YEAR,Hire_Date,GETDATE()) AS Yearsofservice
FROM Employees
WHERE DATEDIFF (YEAR,Hire_Date,GETDATE()) BETWEEN 11 AND 14
--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
 SELECT w1.Id
 FROM Weather w1
 JOIN Weather w2
 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
 WHERE w1.Temperature > w2.Temperature;
 --Write an SQL query that reports the first login date for each player.(Activity)
 SELECT player_id, MIN (event_date) AS firstlogindate
 FROM Activity
 GROUP BY player_id
 --Your task is to return the third item from that list.(fruits)
 SELECT * FROM fruits
 SELECT value AS third_item
FROM Fruits
CROSS APPLY (
    SELECT value,
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM STRING_SPLIT(fruit_list, ',')
) x
WHERE rn = 3;
--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
SELECT Employee_ID,
DATEDIFF(YEAR, hire_date, GETDATE()) AS YEARSOFEMP,
CASE 
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) <1 THEN  'New Hire'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 1 AND 5  THEN 'Junior'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 5 AND 10  THEN 'Mid-Level'
WHEN DATEDIFF(YEAR, hire_date, GETDATE())BETWEEN 10 AND 20  THEN 'Senior'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) >20 THEN 'Veteran'
END AS Employement_Stage
FROM Employees;
--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
---cannot find the solution
--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)  
select * from MultipleVals
SELECT 
    Id,
    -- 1. Vergulga qadar birinchi so‘zni topamiz
    LEFT(Vals, CHARINDEX(',', Vals) - 1) AS FirstWord,
    -- 2. Verguldan keyin ikkinchi so‘zni topamiz
    LTRIM(SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, LEN(Vals))) AS SecondWord,
    
    -- 3. Harflarni almashtirib yangi satr yaratamiz
    STUFF(
        STUFF(Vals, 1, 1, SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1)), 
        CHARINDEX(',', Vals) + 1, 
        1, 
        LEFT(Vals, 1)
    ) AS SwappedString
FROM MultipleVals;
--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < LEN(@str)
)
SELECT 
    SUBSTRING(@str, n, 1) AS Character
FROM Numbers
OPTION (MAXRECURSION 0);
--Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT 
    player_id,
    device_id
FROM Activity a
WHERE event_date = (
    SELECT MIN(event_date)
    FROM Activity
    WHERE player_id = a.player_id
);
--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
---CANNOT FIND SOLUTION

