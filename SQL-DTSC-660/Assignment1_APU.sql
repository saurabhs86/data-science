--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------
CREATE DATABASE auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------

CREATE TABLE customers(
cust_id SERIAL , 
first_name VARCHAR(100) ,
last_name VARCHAR(100)  ,
phone_number VARCHAR(14)  ,
email VARCHAR(100)  ,
street_address VARCHAR(255)  ,
city VARCHAR(100)  ,
zip CHAR(5),
state CHAR(2) 
);

CREATE TABLE employees(
employee_id SERIAL , 
first_name VARCHAR(100) ,
last_name VARCHAR(100)  ,
phone_number VARCHAR(14)  ,
email VARCHAR(100)  ,
street_address VARCHAR(255)  ,
city VARCHAR(100)  ,
zip CHAR(5),
state CHAR(2) ,
hire_date DATE,
salary NUMERIC(10,2),
probation BOOLEAN
);

CREATE TABLE parts_inventory(
part_number VARCHAR(50) ,
manufacturer VARCHAR(100),
quantity INTEGER,
price NUMERIC(10,2)
);


