----Puzzle 1: Finding Distinct Values

CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');
--first way
SELECT DISTINCT
  CASE WHEN col1 <= col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 <= col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
ORDER BY col1, col2;
--second way
SELECT DISTINCT
  LEAST(col1, col2) AS col1,
  GREATEST(col1, col2) AS col2
FROM InputTbl
ORDER BY col1, col2;


--Puzzle 2: Removing Rows with All Zeroes

CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
	DELETE FROM TestMultipleZero
WHERE A = 0 AND B = 0 AND C = 0 AND D = 0;
SELECT * FROM TestMultipleZero

--Puzzle 3: Find those with odd ids

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
	   SELECT * FROM section1
	   WHERE id %2 <> 0;

 --Puzzle 4: Person with the smallest id (use the table in puzzle 3)
 SELECT TOP 1* FROM section1 
 ORDER BY ID ASC;

 --Puzzle 5: Person with the highest id (use the table in puzzle 3)
 SELECT TOP 1* FROM section1 
 ORDER BY ID DESC;

 --Puzzle 6: People whose name starts with b (use the table in puzzle 3)
 SELECT * FROM section1
 WHERE name LIKE 'A%';

 --Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
 CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');
SELECT * FROM ProductCodes
 WHERE Code LIKE '%\_%' ESCAPE '\';



