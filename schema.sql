  -- Creating tables for PH-EmployeeDB
  -- CREATE TABLE employees
  CREATE TABLE employees (
   emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Creating tables for PH-EmployeeDB
-- CREATE TABLE departments
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

--CREATE TABLE Dept_manager
CREATE TABLE Dept_manager(
	dept_no VARCHAR (4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) references departments (dept_no),
	FOREIGN KEY (emp_no) references employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)

);

--CREATE TABLE salaries
CREATE TABLE salaries (
 emp_no INT NOT NULL,
 salary INT NOT NULL,
 from_date DATE NOT NULL,
 to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 PRIMARY KEY (emp_no)
	
);

--CREATE TABLE titles
CREATE TABLE titles (
 emp_no INT NOT NULL,
 title VARCHAR (50) NOT NULL,
 from_date DATE NOT NULL,
 to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 PRIMARY KEY (emp_no, from_date)
	
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR (4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) references departments (dept_no),
	FOREIGN KEY (emp_no) references employees (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

--Retirement between 1952-1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
    FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


--------------------------------
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-------------------------------
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
     FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-------------------------------
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--------------------------------
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-------------------------------
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

------------------------------
SELECT * FROM salaries
ORDER BY to_date DESC;
------------------------------
SELECT emp_no,
  first_name,
last_name,
  gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--------------------------------
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

-------------------------------

--inner joins on the current_emp, departments, and dept_emp
      SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);



SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name,
ti.titles,
dm.from_date,
dm.to_date,
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-------------------------SELECT d.dept_name,
     dm.emp_no,
	 dm.first_name,
	 dm.last_name,
     dm.from_date,
     dm.to_date
INTO retirement_titles
GROUP BY dm.to_date;


SELECT employees.emp_no,
employees.first_name, 
employees.last_name,
employees.birth_date,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no;


SELECT * FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

SELECT * FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY birth_date;

SELECT * FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Module Challenge

-- SELECT DISTINCT emp_no, 
-- first_name, 
-- last_name, 
-- birth_date, 
-- title,
-- from_date, 
-- to_date
-- FROM retirement_titles
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- ORDER BY emp_no;

SELECT DISTINCT emp_no, 
first_name, 
last_name, 
title
FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;


--  Unique Titles table 
SELECT DISTINCT emp_no, 
first_name, 
last_name, 
birth_date, 
title,
from_date, 
to_date
FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;


--  Mentorship Eligibility table 
SELECT DISTINCT emp_no, 
first_name, 
last_name, 
birth_date, 
from_date, 
to_date,
title
FROM retirement_titles
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

--  Retiring Titles table 
SELECT COUNT(ce.emp_no), title
FROM unique_titles as ce
GROUP BY title 
ORDER BY title DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM ret_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC;

SELECT * FROM unique_titles


-- SELECT COUNT(title)
-- FROM unique_titles as ce
-- GROUP BY title
-- ORDER BY title DESC;


-- SELECT COUNT(title)
-- FROM unique_titles as ce
-- GROUP BY title
-- ORDER BY title ASC;

-- SELECT COUNT(title)
-- FROM unique_titles as ce
-- GROUP BY title
-- ORDER BY title DESC;

-- SELECT COUNT(title)
-- FROM unique_titles as ce
-- GROUP BY ce.emp_no
-- ORDER BY ce.emp_no DESC;


-- SELECT COUNT(title), ce.emp_no
-- FROM unique_titles as ce
-- GROUP BY ce.emp_no
-- ORDER BY ce.emp_no DESC;


-- SELECT COUNT(ce.emp_no), title
-- FROM unique_titles as ce
-- GROUP BY title 
-- ORDER BY title DESC;

--Create a Unique Titles table
-- SELECT DISTINCT emp_no, 
-- first_name, 
-- last_name, 
-- title
-- INTO unique_titles
-- FROM retirement_titles
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- ORDER BY emp_no;