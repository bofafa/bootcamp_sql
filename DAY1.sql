use sys;

CREATE DATABASE BOOTCAMP_2408;
use BOOTCAMP_2408;

-- comment (double-dash SQL use upper cap 
-- Database - >tables
   -- one database may have many tables
   -- one table (simalar to excel sheel) may have rows
   -- one row contains one for more columns
   
-- Database: column defintions: VATCHAR (Similar to Jave String), INT / INTEGER (java int)
-- DECIMAL(13,2) 11 digits for interger, 2 degitis for decimal places
-- boolean (true/false): database normally we use VATCHAR(1) -> Y/N   *** 好少係database 用boolean 
CREATE TABLE  STAFFS (
ID INTEGER, -- 0,1,2,3,4,5,....
STAFF_NAME VARCHAR (20), 
GENDER VARCHAR(1),
SALARY DECIMAL(11,2),
STAFF_EMAIL VARCHAR (50),
DEPT_CODE VARCHAR (2) -- IT, HR, MK(Marketing),.....
);

DROP TABLE STAFFS;

SELECT * FROM STAFFS; -- TABLE 

-- INSERT DATA
-- SYNTAX: INSERT INTO "TABLE_NAME" VALUES
-- Column name sequence has to be same as the value sequence
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, STAFF_EMAIL, DEPT_CODE) 
    VALUES (1, 'JOHN WONG', 'M', 20000.5, 'johnwong@gmail.com','IT');
    
    INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, STAFF_EMAIL, DEPT_CODE) 
    VALUES (2, 'PETER LAU', 'M', 31000.0, 'peterlau@gmail.com','HR');

-- remove data
DELETE FROM STAFFS;  -- Remove all data . need to tell it where to delete 

-- table contain null  value
    INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
    VALUES (3, 'JENNY LAU', 'F', 25000.0,'MK');

-- SELECT by Condition (where)
SELECT * FROM STAFFS WHERE GENDER = 'M';
-- Where DEPT_CODE = 'IT'
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT';
-- AND, OR
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' OR  DEPT_CODE = 'MK';
SELECT * FROM STAFFS WHERE DEPT_CODE IN ('IT', 'MK');
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND  DEPT_CODE = 'MK';
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND  GENDER = 'M';
-- SUPPORT BRACKETS
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' OR DEPT_CODE = 'MK' AND GENDER= 'F'; -- AND go first, then or
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND (SALARY>19000 OR GENDER ='F');
-- SELECT SPECIFIC COLUMS
-- SYNTAX : select "column_name1", "column_name2" ...... from "table_name"
-- SELECT (WHAT you want to see in the result set) -> columns
-- WHERE (how to retrieve the data -> ROWS
SELECT STAFF_NAME, DEPT_CODE FROM STAFFS WHERE GENDER ='M';

-- AS, Change column name in result set (not the physical table)
SELECT STAFF_NAME AS NAME, DEPT_CODE AS DEPARTMENT_CODE  FROM STAFFS WHERE GENDER ='M';

-- ADD, add columnn in physical table
ALTER TABLE STAFFS ADD EMPLOYMENT_DATE DATE ;

-- After adding column, the column values before null for all rows
SELECT * FROM STAFFS; -- TABLE 

-- UPDATE field values
UPDATE STAFFS SET EMPLOYMENT_DATE= STR_TO_DATE('2014-08-01','%Y-%m-%d') WHERE ID = 1;
UPDATE STAFFS SET EMPLOYMENT_DATE = STR_TO_DATE('2014-08-05', '%Y-%m-%d') WHERE ID = 2;
UPDATE STAFFS SET EMPLOYMENT_DATE = STR_TO_DATE('2014-08-09', '%Y-%m-%d') WHERE ID = 3;

-- CALULATE PRBATION END DATE
SELECT DATE_ADD(EMPLOYMENT_DATE, INTERVAL 3 MONTH) AS PROBATION_END_DATE
, S.STAFF_NAME
, S.ID
, S.EMPLOYMENT_DATE
 FROM STAFFS S;

-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') AS PROBATION_END_DATE , S.STAFF_NAME , S.ID , S.EMPLOYMENT_DATE  FROM  STAFFS ' at line 1


-- mySQL (not working)
SELECT S.STAFF_NAME + '!!!!!' , CONCAT(S.STAFF_NAME, '!!!!!')
FROM STAFFS S;

SELECT S.STAFF_NAME + '!!!!!!'
, CONCAT(S.STAFF_NAME, '!!!!!!', '??????')
, CONCAT_WS( ' ', S.STAFF_NAME, S.GENDER)
FROM STAFFS S
WHERE S.DEPT_CODE = 'IT'; -- DETERMINE THE NUMBER OF ROWS

-- MATH OPERATIONS (+, -, X , %)
-- 15 FIELDS (3 ROWS X COLUMNS)
SELECT SALARY + 10000, SALARY, 1200-200* 1.1, 1,'HELLO'
FROM STAFFS;

SELECT 10 % 3 FROM STAFFS WHERE DEPT_CODE IN ('MK','HR');

-- BETWEEN AND
SELECT * FROM STAFFS
WHERE EMPLOYMENT_DATE BETWEEN STR_TO_DATE('2014-01-01','%Y-%m-%d') AND STR_TO_DATE('2014-12-31','%Y-%m-%d');

-- modify physical column defintion
-- From VARCHAR (20) TO (30) -> Extend colun length
ALTER TABLE STAFFS MODIFY STAFF_NAME VARCHAR(30);

INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, STAFF_EMAIL, DEPT_CODE) 
    VALUES (4, 'VICENT ABCDEFGHIJK ABCDEFG123445', 'M', 150000.5, 'vicent12345@gmail.com','IT');
    
-- From Varchair (30) to varhar(20) - narrowing
-- if exisition data length> new column lengthk dbms will reject
ALTER TABLE STAFFS MODIFY STAFF_NAME VARCHAR(20);

UPDATE STAFFS SET STAFF_EMAIL = 'vicent@hotmail.com' WHERE ID=4;

-- LIKE
SELECT *
FROM STAFFS
WHERE DEPT_CODE ='IT'
AND STAFF_EMAIL LIKE '%@gmail.com';

    INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
    VALUES (5, 'JOHN LAU', 'M', 20500.0,'MK');
    
    SELECT * 
    FROM STAFFS
    WHERE STAFF_NAME LIKE 'JOHN%';

 SELECT * 
    FROM STAFFS
    WHERE STAFF_NAME LIKE '%@%' OR STAFF_EMAIL IS NULL;
    
-- AGGREGATION FUNCTIONS + WHERE
    SELECT SUM(SALARY)
    FROM STAFFS;
    
   SELECT SUM(SALARY)
    FROM STAFFS
    WHERE DEPT_CODE ='IT';
    
    -- SUM()-> SUM UP ALL THE VALUSE OF A COLUMN
    -- COUNT () -> COUNT THE NUMBER OF ROWS
    -- you can not put STAFF_NAME here, you should know the reason
    -- as long as you have one affregation function, the result must be single row
    SELECT SUM(SALARY), COUNT(1), COUNT(*), COUNT(ID), MAX(SALARY), MIN(SALARY), MAX(ID), AVG(SALARY) -- STAFF_NAME 
    FROM STAFFS
    WHERE DEPT_CODE ='IT';
    
    SELECT 1 AS ONE FROM STAFFS WHERE DEPT_CODE= 'IT';
    
-- AGGREGATION FUNCTIONS + GROUP BY
-- 1. exclude the employee in marketing
-- 2. group by
-- 3. select AGG functions
SELECT DEPT_CODE, AVG(SALARY) AS DEPT_AVERAGE_SALARY, COUNT(1) AS NUMBER_OF_DEPT_EMPLOYEES
, MAX(SALARY) DEPT_MAX_SALARY
FROM STAFFS
WHERE DEPT_CODE <>'MK' -- Exclude marketing  <> == != // boolean
GROUP BY DEPT_CODE;
