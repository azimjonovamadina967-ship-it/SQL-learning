-----1--------
SELECT  p.Firstname, p.Lastname, a.City,  a.State
FROM Person p
LEFT JOIN Address a ON p.PersonID=a.PersonID;
----2----
SELECT e.Name AS Employee
FROM Employee e
JOIN Employee m
ON e.ManagerID = m.ID
WHERE e.Salary > m.Salary;
---3----
SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(*) > 1;
----4-----
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);
SELECT * FROM Person
-----5------
SELECT g.ParentName
FROM girls g
LEFT JOIN boys b ON g.ParentName=b.ParentName
WHERE b.ParentName IS NULL
----6---
USE TSQL2012;
GO
SELECT custid,
    SUM(freight) AS TotalAmount, ---amount column is not available in your given schema
    MIN(freight) AS LeastWeight   ---weight column is not available in your given schema
FROM Sales.Orders
WHERE freight > 50
GROUP BY custid;
-------7-----------
SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item
ORDER BY 
    CASE 
        WHEN c1.Item IS NOT NULL THEN 1 ELSE 2 
    END,
    COALESCE(c1.Item, c2.Item);
	----8-----
SELECT c.Name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id=o.customerID
WHERE o.customerID IS NULL
-----9-----
SELECT
  s.student_id,
  s.student_name,
  sub.subject_name,
  COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON s.student_id = e.student_id
 AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;









