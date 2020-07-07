# Pewlett-Hackard-Analysis
Delivering Results: A README.md in the form of a technical report that details your analysis and findings
Technical Analysis Deliverable 1: Number of Retiring Employees by Title. You will create three new tables, one showing number of [titles] retiring, one showing number of employees with each title, and one showing a list of current employees born between Jan. 1, 1952 and Dec. 31, 1955. New tables are exported as CSVs. 
Technical Analysis Deliverable 2: Mentorship Eligibility. A table containing employees who are eligible for the mentorship program You will submit your table and the CSV containing the data (and the CSV containing the data)

# Technical Analysis
In your first paragraph, introduce the problem that you were using data to solve.
Bobby’s manager would like to know how many roles will need to be filled as the “silver tsunami” begins to make an impact. They would also like to identify retirement-ready employees who qualify to mentor the next generation of Pewlett Hackard employees.

In your second paragraph, summarize the steps that you took to solve the problem, as well as the challenges that you encountered along the way. This is an excellent spot to provide examples and descriptions of the code that you used.


In your final paragraph, share the results of your analysis and discuss the data that you’ve generated. Have you identified any limitations to the analysis? What next steps would you recommend?


# Deliverable #1

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
