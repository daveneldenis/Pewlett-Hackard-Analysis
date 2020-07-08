# Pewlett-Hackard-Analysis
Delivering Results:
Technical Analysis Deliverable 1: Number of Retiring Employees by Title. You will create three new tables, one showing number of [titles] retiring, one showing number of employees with each title, and one showing a list of current employees born between Jan. 1, 1952 and Dec. 31, 1955. New tables are exported as CSVs. Please see attachments. 1. retirement_info 2. retirement_employees 3. retirement_count 
Technical Analysis Deliverable 2: Mentorship Eligibility. A table containing employees who are eligible for the mentorship program You will submit your table and the CSV containing the data (and the CSV containing the data) Please see attachments. 1. mentorship_elig 2. mentorship.sql

# Technical Analysis

We identified the the following roles that will need to be filled: 4692 Engineers, 15,600 Senior  Engineers, 2 Managers, 501 Asst Engineers, 3837 Staff members, 14,735 senior staff members, and 2013 Technique Leaders. We identified the mentorship eligible employees identified in the corresponding csv file.

In your second paragraph, summarize the steps that you took to solve the problem, as well as the challenges that you encountered along the way. This is an excellent spot to provide examples and descriptions of the code that you used.
Please see the code listed below that was used to partition the data to show the recent title per employee.  Also found in the retirement.sql file. The code to identify the employees that are mentorship eligible is shown below and can be seen at Mentorship.sql. I spent time viewing tables and realized my original data was not downloaded correctly so I had to import all the tabkles twice. I aslo notice the importance of syntax. There was some original issues with version control of the pgAdmin for Mac users. Overall this was a great exercise to test my coding skills in SQL and set up the structure of the data collection with QDB.

The final analysis determined that HR needs to begin the hiring process in preparation for the many employees that will be retiring. We've identified that the loss of these employees will be detriimental to the business if not replaced strategically. We ned to determine if any of these job functions are actually needed and the quantity that is needed. I would like to obtain data to figure out what job functions are necessary and whether or not this is an oportunity to divert funds to the mentorship program.


count	title
4692	Engineer
15600	Senior Engineer
2	Manager
501	Assistant Engineer
3837	Staff
14735	Senior Staff
2013	Technique Leader


# Deliverable #1
Code for deliverable:
-- Partition the data to show only most recent title per employee
SELECT emp_no,
 first_name,
 last_name,
 salary,
 from_date, 
 title
INTO retiring_emp
FROM
 (SELECT ri.emp_no, 
ri.first_name, 
ri.last_name, 
sa.salary, 
ti.from_date, 
ti.title, ROW_NUMBER() OVER
 (PARTITION BY (ri.emp_no)
 	ORDER BY ti.from_date DESC) rn
	FROM retirement_info AS ri
	INNER JOIN salaries AS sa
	ON ri.emp_no = sa.emp_no
	INNER Join "Titles" AS ti
	ON sa.emp_no = ti.emp_no
 ) tmp WHERE rn = 1
ORDER BY emp_no;	  



# Deliverable #2

Code for deliverable:
--Mentorship_Eligibility

SELECT emp_no,
 first_name,
 last_name,
 from_date,
 to_date,
 title
INTO mentorship_elig
FROM
 (SELECT e.emp_no, 
e.first_name, 
e.last_name,  
ti.from_date, 
ti.to_date,
ti.title, ROW_NUMBER() OVER
 (PARTITION BY (e.emp_no)
 	ORDER BY ti.to_date DESC) rn
 	FROM employees AS e
	INNER JOIN "Titles" AS ti
	ON e.emp_no = ti.emp_no
	WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 ) tmp WHERE rn = 1
	ORDER BY emp_no;	   


--Retirement Count using Group BY
Select count(emp_no), title 
INTO retirement_count
From retiring_emp
GROUP BY title;
