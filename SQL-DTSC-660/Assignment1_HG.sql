--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE holy_grounds;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect holy_grounds;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------


CREATE TABLE coffee_inventory(
sku VARCHAR(50) , 
name VARCHAR(255) ,
roast_type VARCHAR(100)  ,
lbs_on_hand  NUMERIC(10,2)  ,
organic BOOLEAN  ,
price_per_lb NUMERIC(10,2)
);



CREATE TABLE sales_transactions(
receipt_id BIGSERIAL , 
sale_amount  NUMERIC(10,2)  ,
sale_type VARCHAR(10)  ,
transaction_date timestamptz
);


CREATE TABLE stores(
store_id SERIAL , 
store_manager  VARCHAR(255)  ,
store_phone  VARCHAR(14)   ,
store_address VARCHAR(255)  ,
city VARCHAR(100)  ,
zip CHAR(5),
state CHAR(2) 
);