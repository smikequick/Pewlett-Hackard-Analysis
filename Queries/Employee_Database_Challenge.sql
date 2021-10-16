---Retrieve employee name and number from table
SELECT emp_no, first_name, last_name
FROM employees;

---Retrieve title and dates from table
SELECT emp_no, title, from_date, to_date
FROM titles;

--Create new table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
FULL OUTER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

---Retrieve employee name, title, and number from table
SELECT emp_no, first_name, last_name, title
FROM retirement_titles;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Retrieve number of titles from unique titles table
SELECT COUNT (u.emp_no), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY COUNT (u.emp_no) DESC;

-- Retrieve emp no, name, and birth date from table
SELECT emp_no, first_name, last_name, birth_date
FROM employees;

-- Retrieve emp no, from and to date from table

SELECT emp_no,from_date, to_date
FROM dept_employees;

-- Retrieve emp no and title from table filtering duplicates

SELECT DISTINCT ON (emp_no) emp_no, title
INTO clean_titles
FROM titles;

-- Joining employees and department employees tables
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
ON e.emp_no = de.emp_no
LEFT JOIN clean_titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date  = ('9999-01-01')
ORDER BY emp_no ASC;

-- Retrieve number of mentorship eligible employees by title
SELECT COUNT (m.emp_no), m.title
INTO mentorship_eligibility_total
FROM mentorship_eligibility as m
GROUP BY m.title
ORDER BY COUNT (m.emp_no) DESC;

-- Retrieve the total number of employees about to retire
SELECT COUNT (*) FROM unique_titles;

-- Retrieve the total number of employees eligible for mentoring
SELECT count (*) from mentorship_eligibility;
