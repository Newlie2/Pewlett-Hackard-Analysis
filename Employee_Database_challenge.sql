# Deliverable 1: The Number of Retiring Employees by Title 
-- DROP TABLE retirement_titles;

## Retirement Titles Table

SELECT em.emp_no, first_name, last_name, title, from_date, to_date
INTO retirement_titles
FROM employees as em
JOIN titles ti 
ON em.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;

## Unique Titles Table


DROP TABLE unique_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title, from_date, to_date
INTO unique_titles
FROM retirement_titles as re
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

## Retiring Titles Table 

DROP TABLE retiring_titles;

SELECT COUNT (title) ticount, title
INTO retiring_titles
FROM unique_titles 
GROUP BY title 
ORDER BY ticount  DESC;

SELECT * FROM retiring_titles;

# Deliverable 2: The Employees Eligible for the Mentorship Program 

DROP TABLE mentorship_eligibility;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
         last_name,
        first_name,
        dm.from_date,
        dm.to_date, 
		title,
		birth_date
INTO mentorship_eligibility
FROM employees as e
    INNER JOIN dept_emp AS dm
        ON e.emp_no = dm.emp_no
	JOIN titles ti
         ON (ti.emp_no = e.emp_no)	 
WHERE dm.to_date = '9999-01-01' 
AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;


SELECT * FROM mentorship_eligibility;




























