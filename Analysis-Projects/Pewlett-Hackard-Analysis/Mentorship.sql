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