/*
    Name: Saurabh Sinha
    DTSC660: Data and Database Managment with SQL
    Assignment 7
*/

--------------------------------------------------------------------------------
/*				                 Query 1          		  		          */
--------------------------------------------------------------------------------
--identify departments whose total salary exceeds the overall average total salary across all departments. 

WITH dept_salaries AS ( --CTE1
		SELECT
			d.department_id,
			d.department_name,
			SUM(e.salary) AS total_salary
		FROM
			employees e
			JOIN departments d ON e.department_id = d.department_id
		GROUP BY
			d.department_id,d.department_name
	),
	avg_salary AS ( --CTE2
		SELECT
			AVG(ds.total_salary) AS avg_dept_salary
		FROM
			dept_salaries ds
	)
SELECT
	department_name,
	total_salary
FROM
	dept_salaries dss
	CROSS JOIN avg_salary a
WHERE
	dss.total_salary > a.avg_dept_salary;
--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------
--identify the employee(s) who worked the most hours on each project. 
--If more than one employee worked the same number of maximum hours, include them all

WITH max_hours AS (
		SELECT
			project_id,
			MAX(hours_worked) AS max_worked
		FROM
			employee_projects ep
		GROUP BY
			ep.project_id
	)
SELECT
	p.project_name,
	mh.max_worked max_hours_worked,
	e.name employee
FROM
	employees e
	JOIN employee_projects ep ON ep.employee_id = e.employee_id
	JOIN projects p ON p.project_id = ep.project_id 
	JOIN max_hours mh ON mh.project_id = p.project_id AND mh.max_worked = ep.hours_worked;

--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------
--return the names of employees who directly report to ‘'Alex Johnson'.

WITH manager_id_cte AS (
		SELECT
			em.employee_id manager_id
		FROM
			employees em
		WHERE
			em."name" = 'Alex Johnson'
	)
SELECT
	m.name manager_name,
	e.name employee_name
FROM
	employees e
	JOIN manager_id_cte mic ON e.manager_id = mic.manager_id
	JOIN employees m ON e.manager_id=m.employee_id;
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------
--find departments where at least three different employees have worked on two or more unique projects.

WITH emp_proj_counts AS ( --CTE1
		SELECT
			ep.employee_id,
			d.department_id,
			COUNT(DISTINCT (project_id)) project_count
		FROM
			employee_projects ep
			JOIN employees e ON e.employee_id = ep.employee_id
			JOIN departments d ON e.department_id = d.department_id
		GROUP BY
			ep.employee_id,
			d.department_id
	),
	qualified_employees AS ( --CTE2
		SELECT
			epc.department_id,
			COUNT(epc.employee_id) qualified_employee_count
		FROM
			emp_proj_counts epc
		WHERE
			epc.project_count > 1
		GROUP BY
			epc.department_id
	)
SELECT
	d.department_name,
	qe.qualified_employee_count
FROM
	qualified_employees qe
	JOIN departments d ON d.department_id = qe.department_id
	AND qe.qualified_employee_count > 2;
--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------
--compare each employee’s salary to their manager’s, 
--then filter to include only those with managers earning more than $100,000.

WITH salary_diff AS (
		SELECT
			e.name employee_name,
			e.salary employee_salary,
			em.name manager_name,
			em.salary manager_salary,
			e.salary - em.salary salary_difference
		FROM
			employees e
			JOIN employees em ON e.manager_id = em.employee_id
	)
SELECT
	*
FROM
	salary_diff
WHERE
	manager_salary > 100000;