SELECT * FROM salaries;
ORDER BY to_date DESC;

SELECT emp_no,
	first_name,
last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT From e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
-- INTO emp_info
FROM  employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM managers AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);	 
		
-- Dept_Emp and Departments tables, and current-emp  inner joins 

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name		 
-- INTO dept_info
FROM current_emp as ce
INNER JOIN "Dept_Emp" AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);



-- Challenge Deliverables
-- Delivering Results: A README.md in the form of a technical report that details your analysis and findings
-- Technical Analysis Deliverable 1: Number of Retiring Employees by Title. You will create three new tables, one showing number of [titles] retiring, one showing number of employees with each title, and one showing a list of current employees born between Jan. 1, 1952 and Dec. 31, 1955. New tables are exported as CSVs.
-- Technical Analysis Deliverable 2: Mentorship Eligibility. A table containing employees who are eligible for the mentorship program (and the CSV containing the data)



--Challenge Deliverable 1: Number of Retiring Employees by Title
-- Employee number
-- First and last name
-- Title
-- from_date
-- Salary


Select ce.emp_no, 
ce.first_name, 
ce.last_name, 
s.salary, 
s.from_date, 
t.title
--INTO retiring_employees
FROM current_emp AS ce
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no
INNER Join titles AS t
ON s.from_date = t.from_date
GROUP BY t.ce
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	AND e.hire_date BETWEEN '1985-01-01' AND '1988-12-31';

-- Create table, export it as a CSV and upload it to your GitHub repo.	
	   
-- Query the new table using the SELECT statement.
--SELECT * FROM retiring_employees;	 
	   
-- Create a new table that includes only the most recent title of each employee.
	   
-- Partition the data to show only most recent title per employee
SELECT ______,
 __________,
 _________,
 _______,
 _____
INTO nameyourtable
FROM
 (SELECT ______,
 __________,
 _________,
 _______,
 _____, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM __________
 ) tmp WHERE rn = 1
ORDER BY emp_no;	   
	   
-- Create table, export it as a CSV and upload it to your GitHub repo.	

-- Challenge Deliverable 2: Mentorship Eligibility	   
-- Employee number
-- First and last name
-- Title
-- from_date and to_date
-- To be eligible to participate in the mentorship program, 
--employees will need to have a date of birth that falls between January 1, 1965 and December 31, 1965. 
--You’ll need to use two inner joins to create this new table. 
--Employees Join Titles ( Check for duplicates before creating a CSV
--Once Table 2 is complete, export the data as a CSV and push it to your repository.)
	   
