-- 6) Differentiate between DDL and DML commands with examples.

-- DDL (Data Definition Language)
-- * Defines structure of database objects.
-- * Commands: CREATE, ALTER, DROP, TRUNCATE
-- * Affects schema, not data.
-- * Auto-commit (cannot be rolled back).

-- EXAMPLE:

use house;

-- CREATE:
create table Students (
    ID int,
    Name varchar(50)
);
-- ALTER:
alter table Students change ID Student_ID varchar(40);

-- DROP:
drop table Students;

-- TRUNCATE:
truncate table Students;



-- DML (Data Manipulation Language)
-- * Manipulates data inside tables.
-- * Commands: INSERT, UPDATE, DELETE, SELECT.
-- * Affects data, not schema.
-- * Not auto-commit (can ROLLBACK/COMMIT).

-- EXAMPLE:

-- INSERT:
insert into Students(Student_ID,name)value
(1,"Saravanan"),
(2,"Kiruba"),
(3,"Sanjay");

-- UPDATE:
update Students
set name = "Kirubakaran"
where Student_ID = 2;

-- DELETE:
delete from Students
where Student_ID = 3;

-- SELECT:
select * from Students;

-- ==============================================================================================================================================

-- 7) Write a query to fetch the second highest salary from an employee table.

CREATE TABLE employee (
    Id INT,
    name VARCHAR(40),
    salary INT
);

insert into employee(id,name,salary)value
(1,"arun",34000),
(2,"ramu",50000),
(3,"albert",38000),
(4,"priya",14000),
(5,"harthika",78000),
(6,"jakku",39000),
(6,"vennila",82000);

select * from employee;

SELECT 
    MAX(salary) AS SecondHighestSalary
FROM
    Employee
WHERE
    salary < (SELECT 
            MAX(salary)
        FROM
            Employee);

-- =============================================================================================================================================

-- 8) Explain the difference between INNER JOIN and LEFT JOIN with an example.

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT
);

INSERT INTO Employees (EmployeeID, Name, DepartmentID) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 103),
(4, 'David', NULL);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'HR'),
(102, 'IT'),
(104, 'Finance');


-- INNER JOIN:
-- * Returns only the rows that have matching values in both tables.
-- * Excludes non-matching rows.

-- EXAMPLE:

SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;


-- LEFT JOIN:
-- * Returns all rows from the left table, and matching rows from the right table.
-- * If no match is found, returns NULL for right table columns.

-- EXAMPLE:

SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID;

-- =============================================================================================================================================

-- 9) What is a Trigger in MySQL? Give a use case.

-- TRIGGER:
-- * A trigger is a set of SQL statements that automatically executes (or “fires”) when a specified event occurs on a table.
-- * INSERT, UPDATE, or DELETE
-- * BEFORE or AFTER

CREATE TABLE EmployeeAudit (
    EmployeeID INT,
    Name VARCHAR(50),
    ActionTime DATETIME,
    ActionType VARCHAR(20)
);

DELIMITER $$

CREATE TRIGGER after_employee_insert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Name, ActionTime, ActionType)
    VALUES (NEW.EmployeeID, NEW.Name, NOW(), 'INSERT');
END$$

DELIMITER ;

-- =============================================================================================================================================

-- 10) Why is Normalization important? Explain with an example.


-- NORMALIZATION:
-- Normalization is the process of organizing a database to reduce redundancy and improve data integrity by dividing data into multiple related tables.

-- IMPORTANCE OF NORMALIZATION:
-- * Reduces Data Redundancy – Avoids storing the same data multiple times.
-- * Prevents Update Anomalies – Changes need to be made in only one place.
-- * Ensures Data Consistency – Data is accurate and reliable.
-- * Improves Query Performance – Smaller, well-structured tables are easier to manage.
-- * Simplifies Maintenance – Easier to add, delete, or modify data.

-- EXAMPLE:

-- Students Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

INSERT INTO Student (StudentID, StudentName)
VALUES 
(101, 'Alice'),
(102, 'Bob');

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Instructor VARCHAR(50)
);

INSERT INTO Courses (CourseID, CourseName, Instructor)
VALUES
(201, 'Math', 'Mr. Smith'),
(202, 'Physics', 'Ms. Jones');

-- Enrollment Table
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

                             
-- =============================================================================================================================================
                                                 -- PART_C           10 MARK --
-- =============================================================================================================================================


CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR'),
(4, 'Finance');

CREATE TABLE Employe (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Employe (emp_id, emp_name, dept_id, salary, hire_date) VALUES
(101, 'John', 1, 50000, '2018-05-12'),
(102, 'Amit', 2, 65000, '2017-03-20'),
(103, 'Sara', 2, 72000, '2019-08-15'),
(104, 'Lina', 3, 48000, '2020-01-10'),
(105, 'Raj', 4, 55000, '2016-09-25'),
(106, 'Emma', 1, 60000, '2015-11-02');

CREATE TABLE Attendance (
    att_id INT PRIMARY KEY,
    emp_id INT,
    att_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES Employe(emp_id)
);

INSERT INTO Attendance (att_id, emp_id, att_date, status) VALUES
(1, 101, '2025-09-01', 'Present'),
(2, 102, '2025-09-01', 'Absent'),
(3, 103, '2025-09-01', 'Present'),
(4, 104, '2025-09-01', 'Present'),
(5, 105, '2025-09-01', 'Present'),
(6, 106, '2025-09-01', 'Present');

SELECT * FROM Department;
SELECT * FROM Employe;
SELECT * FROM Attendance;

-- a) Write a DDL command to create the departments table with dept_id as Primary Key and dept_name as NOT NULL.
CREATE TABLE departmentss (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- b) Insert two sample records into the departments table (e.g., Sales, IT).
INSERT INTO departmentss (dept_id, dept_name) VALUES
(1, 'Sales'),
(2, 'IT');

-- c) Write a query to display the employee name and department name using a JOIN between employees and departments.
SELECT e.emp_name, d.dept_name
FROM employe e
JOIN department d ON e.dept_id = d.dept_id;

-- d) Write a query to find the highest salary using an aggregate function.
SELECT MAX(salary) AS highest_salary
FROM employe;

-- e) Write a subquery to fetch the employees who earn more than the average salary.
SELECT emp_name, salary
FROM employe
WHERE salary > (SELECT AVG(salary) FROM employe);

-- f) Create a view named emp_salary_view to display emp_name, dept_name, salary.
CREATE VIEW emp_salary_view AS
SELECT e.emp_name, d.dept_name, e.salary
FROM employe e
JOIN departmentss d ON e.dept_id = d.dept_id;

-- g) Write a stored procedure named GetDeptEmployees that accepts a dept_id and returns all employee names in that department.
DELIMITER $$

CREATE PROCEDURE GetDeptEmploye(IN p_dept_id INT)
BEGIN
    SELECT emp_name
    FROM employe
    WHERE dept_id = p_dept_id;
END$$

DELIMITER ;

CALL GetDeptEmploye(1);

-- h) Write a user-defined function YearWorked(hire_date) that calculates the number of years an employee has worked in the company.
DELIMITER $$

CREATE FUNCTION YearWorked(hire_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, hire_date, CURDATE());
END$$

DELIMITER ;

SELECT emp_name, YearWorked(hire_date) AS years_worked
FROM employe;


-- i) Create a trigger that automatically inserts a record into attendance table with status = 'Present' whenever a new employee is added.
DELIMITER $$

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employe
FOR EACH ROW
BEGIN
    INSERT INTO attendance (emp_id, att_date, status)
    VALUES (NEW.emp_id, CURDATE(), 'Present');
END$$

DELIMITER ;

-- j) Write a query using string function to display employee names in uppercase.
SELECT UPPER(emp_name) AS emp_name_upper
FROM employe;






