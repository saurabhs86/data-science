/*
    Name: Saurabh Sinha
    DTSC660: Data and Database Managment with SQL
    Assignment 5- PART 2
*/

--------------------------------------------------------------------------------
/*				                 Query 8            		  		          */
--------------------------------------------------------------------------------
-- returns a list of course_ids FROM the course table for courses that do not have any prerequisites 
--listed in the prereq table. This should be sorted FROM smallest to largest. 
--Your solution must use a SET operator.

SELECT
	course_id
FROM
	course
EXCEPT
SELECT
	course_id
FROM
	prereq
ORDER BY
	course_id;

--------------------------------------------------------------------------------
/*				                  Query 9           		  		          */
--------------------------------------------------------------------------------
--return an alphabetical list of dept_names FROM the department table showing all departments 
--that are assigned to at least one instructor in the instructor table. 
--You must use a SET operator in your solution.

SELECT DISTINCT
	(instructor.dept_name)
FROM
	instructor
INTERSECT
SELECT
	department.dept_name
FROM
	department
ORDER BY
	dept_name;

--------------------------------------------------------------------------------
/*				                  Query 10           		  		          */
--------------------------------------------------------------------------------
--returns an alphabetical list of dept_names for every department that satisfies at least one of the following conditions: 
--The department has a budget less than $100,000
--The department has at least one instructor whose salary is greater than $50,000
--The department has at least one student whose total credits are equal to the lowest total credits taken by any student. 

SELECT DISTINCT
	(department.dept_name)
FROM
	department
WHERE
	budget < 100000
UNION
SELECT DISTINCT
	(instructor.dept_name)
FROM
	instructor
WHERE
	instructor.salary > 50000
UNION
SELECT DISTINCT
	(student.dept_name)
FROM
	student
WHERE
	tot_cred = (
		SELECT
			MIN(tot_cred)
		FROM
			student
	)
ORDER BY
	dept_name;
--------------------------------------------------------------------------------
/*				                  Query 11           		  		          */
--------------------------------------------------------------------------------
--returns the course_id and title of courses and their prerequisites. 
--Your output should name the returned columns: course_id, course_name, prereq_id, prereq_name (in that order). 
--Only include courses that have prerequisites in the results. 
--Organize your results by course_id, then prereq_id (both ascending). Your solution must use a JOIN.

SELECT
	c.course_id,
	c.title course_name,
	p.prereq_id,
	cp.title prereq_name
FROM
	course c
	JOIN prereq p ON p.course_id = c.course_id
	JOIN course cp ON cp.course_id = p.prereq_id
ORDER BY
	c.course_id,
	p.prereq_id;

--------------------------------------------------------------------------------
/*				                  Query 12           		  		          */
--------------------------------------------------------------------------------

--find the id of each student who has never taken a course at the university. 
--Your solution must use an OUTER JOIN- do not use any subqueries or set operations.    
SELECT DISTINCT
	s.id
FROM
	student s
	LEFT OUTER JOIN takes t ON t.id = s.id
WHERE
	t.id IS NULL;

  