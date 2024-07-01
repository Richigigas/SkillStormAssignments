RESTORE DATABASE[hr_db]
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr_db.bak';

USE hr_db

-- Exercise 1
SELECT 
	e.employee_id,
	d.department_id,
	e.salary,
	ROUND(ae.avg_salary, 2) AS [avg_salary_expense]
FROM employees e
	JOIN departments d ON e.department_id = d.department_id
	JOIN (
		SELECT department_id,
		AVG(salary) AS [avg_salary]
		FROM employees 
		GROUP BY department_id
	) ae ON e.department_id = ae.department_id
WHERE e.salary > ae.avg_salary
ORDER BY e.department_id ASC, e.salary ASC;
GO