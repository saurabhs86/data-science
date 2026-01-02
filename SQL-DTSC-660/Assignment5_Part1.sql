/*
    Name: Saurabh Sinha
    DTSC660: Data AND Database Managment with SQL
    Assignment 5- PART 1
*/

--------------------------------------------------------------------------------
/*				                 Query 1            		  		          */
--------------------------------------------------------------------------------
--find all customers who have at least one loan AND one deposit account. 
--Include the cust_id, account_number, AND loan_number IN your results AND 
--organize the results by cust_id. 
--Note: Some customers may appear multiple times due to HAVING multiple loans or deposit accounts 
--AND that is ok. Your solution must include a JOIN.

SELECT
	c.cust_id,
	d.account_number,
	b.loan_number
FROM
	borrower b
	INNER JOIN depositor d USING (cust_id)
	INNER JOIN customer AS c USING (cust_id)
ORDER BY
	cust_id;

--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------
--returns the cust_id AND customer_name of customers who hold at least one loan with the bank,
--but do not have any deposit accounts. Organize your output by cust_id. 
--Your solution must use a subquery AND a SET operator.

SELECT
	cust_id,
	customer_name
FROM
	customer
WHERE
	customer.cust_id IN (
		SELECT
			b.cust_id
		FROM
			borrower b
		EXCEPT
		SELECT
			d.cust_id
		FROM
			depositor d
	)
ORDER BY
	cust_id;
--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------
-- identifies all customers who have a deposit account IN the same city IN which they live.
-- The results should include the cust_id, customer_city, branch_name, branch_city, AND account_number.
--Note: The city of a deposit account is the city WHERE its branch is located. 
--Your solution must use a JOIN..

SELECT
	customer.cust_id,
	customer.customer_city,
	branch.branch_name,
	branch.branch_city,
	depositor.account_number
FROM
	customer
	JOIN depositor ON depositor.cust_id = customer.cust_id
	JOIN account ON account.account_number = depositor.account_number
	JOIN branch ON account.branch_name = branch.branch_name
WHERE
	customer.customer_city = branch.branch_city;
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------
--retrieve a list of branch_names for every branch that has at least one customer living IN the city ‘Manhattan’
--AND whose average loan amount is greater than $5,000. 
--Branch names should not be duplicated. Organize your results alphabetically. 
--Your solution must include a JOIN.

SELECT DISTINCT
	l.branch_name
FROM
	branch b
	JOIN loan l ON l.branch_name = b.branch_name
	JOIN borrower bo ON bo.loan_number = l.loan_number
	JOIN customer c ON bo.cust_id = c.cust_id
WHERE
	l.amount > '5000'
	AND c.customer_city = 'Manhattan'
ORDER BY
	l.branch_name;
--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------

-- obtain the cust_id AND customer_name for all customers residing at the same customer_street address 
--AND IN the same customer_city AS customer '12345'. 
--Exclude customer '12345' IN the results AND organize the results by cust_id. 
--Avoid hardcoding the address for customer '12345' AS their information might change. 
--Your solution must include a subquery AND SET operator.

SELECT
	customer.cust_id,
	customer.customer_name
FROM
	customer
WHERE
	customer.customer_street = (
		SELECT
			c.customer_street
		FROM
			customer c
		WHERE
			c.cust_id = '12345'
	)
	AND customer.customer_city = (
		SELECT
			cs.customer_city
		FROM
			customer cs
		WHERE
			cs.cust_id = '12345'
	)
EXCEPT
SELECT
	ci.cust_id,
	ci.customer_name
FROM
	customer ci
WHERE
	ci.cust_id = '12345'
ORDER BY
	cust_id;
--------------------------------------------------------------------------------
/*				                  Query 6           		  		          */
--------------------------------------------------------------------------------

--Write a query to return each cust_id AND customer_name who has a deposit account at every branch located IN Brooklyn. 
--Do not hardcode the number of branches or the branch names- if the names or numbers of branches change, the query should still be valid. 
--Your solution must include a subquery.    

SELECT
	c.cust_id,
	c.customer_name
FROM
	depositor d
	JOIN customer c ON d.cust_id = c.cust_id
	JOIN account a ON a.account_number = d.account_number
	JOIN branch b ON b.branch_name = a.branch_name
GROUP BY
	c.cust_id
HAVING
	COUNT(DISTINCT a.branch_name) = (
		SELECT
			COUNT(branch_name)
		FROM
			branch
		WHERE
			branch_city = 'Brooklyn'
	);
--------------------------------------------------------------------------------
/*				                  Query 7           		  		          */
--------------------------------------------------------------------------------

--retrieve the loan_number, customer_name, AND branch_name of customers who have a loan at the Yonkahs Bankahs branch
--AND whose loan amount exceeds the average loan amount for that branch. 
--Your solution must include a JOIN AND a subquery.

SELECT
	l.loan_number,
	c.customer_name,
	l.branch_name
FROM
	loan l
	JOIN borrower b ON l.loan_number = b.loan_number
	JOIN customer c ON c.cust_id = b.cust_id
WHERE
	branch_name = 'Yonkahs Bankahs'
	AND amount::NUMERIC > (
		SELECT
			AVG(amount::NUMERIC)
		FROM
			loan
		WHERE
			branch_name = 'Yonkahs Bankahs'
		GROUP BY
			branch_name
	)
  ;