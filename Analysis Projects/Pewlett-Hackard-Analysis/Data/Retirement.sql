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
