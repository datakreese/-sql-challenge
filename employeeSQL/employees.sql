CREATE DATABASE sql_challenge;

CREATE TABLE employees(emp_no INT NOT NULL,
					   emp_title_id VARCHAR(20) NOT NULL,
					   birth_date DATE,
					   first_name VARCHAR(20),
					   last_name VARCHAR(20),
					   sex CHAR,
					   hire_date DATE
);

CREATE TABLE salaries(emp_no INT NOT NULL,
					 salary INT);
					 
CREATE TABLE departments(dept_no VARCHAR(20) NOT NULL,
						 dept_name VARCHAR(20)
);

CREATE TABLE dept_emp(emp_no INT NOT NULL,
					  dept_no VARCHAR(20) NOT NULL
);

CREATE TABLE dept_manager(dept_no VARCHAR(20),
						  emp_no INT NOT NULL
);

CREATE TABLE title(title_id VARCHAR(20) NOT NULL,
				   title VARCHAR(20)
);

--import all csv files, establish keys via import menu.

--ANALYSIS
--#1 Find the emp #, name, sex, and salary of everyone

SELECT * FROM employees;
SELECT * FROM salaries;

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no;

--#2 Find the employees that were hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--#3 Show the managers for each department and their employee #

SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM departments;

SELECT e.last_name, e.first_name, m.dept_no, m.emp_no, d.dept_name 
FROM dept_manager m
RIGHT JOIN departments d ON d.dept_no = m.dept_no
INNER JOIN employees e ON e.emp_no = m.emp_no;

--#4 List the department of each employee with their #, name, and dept name.

SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM departments;

SELECT m.emp_no, e.last_name, e.first_name, d.dept_name, m.dept_no   
FROM dept_emp m
RIGHT JOIN departments d ON d.dept_no = m.dept_no
INNER JOIN employees e ON e.emp_no = m.emp_no;

--#5 Find the employees named "Hercules" that also have a last name starting with B

SELECT first_name, last_name, sex
FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%';

--#6 Display only the employees in the sales departments.

SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM departments;

SELECT d.dept_name, e.first_name, e.last_name, e.emp_no
FROM dept_emp m
INNER JOIN employees e ON e.emp_no = m.emp_no
INNER JOIN departments d ON d.dept_no = m.dept_no 
WHERE d.dept_name IN (
    SELECT dept_name
    FROM departments
    WHERE dept_name = 'Sales');

--#7 Display only the employees in the sales and dev departments.

SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM departments;

SELECT d.dept_name, e.first_name, e.last_name, e.emp_no
FROM dept_emp m
INNER JOIN employees e ON e.emp_no = m.emp_no
INNER JOIN departments d ON d.dept_no = m.dept_no 
WHERE d.dept_name IN (
    SELECT dept_name
    FROM departments
    WHERE dept_name = 'Sales' OR dept_name = 'Development');

--#8 Count the unique last names 
--insert a column that will store the count of each last name, descending order.

SELECT last_name, COUNT(last_name) AS count_result
FROM employees
GROUP BY last_name
ORDER BY count_result DESC;

--done