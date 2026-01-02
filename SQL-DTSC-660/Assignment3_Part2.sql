/*
    Name: <Full Name>
    DTSC660: Data and Database Management with SQL
    Assignment 3

Place your SQL code where indicated below. 
DO NOT remove the  Query number headers as CodeGrade uses this for grading!!
*/

--------------------------------------------------------------------------------
/*				                  Query 1   	    	  		              */
--------------------------------------------------------------------------------

select category, sum(revenue) total_revenue from customer_spending where sale_year='2016' group by category order by category;

--------------------------------------------------------------------------------
/*				                  Query 2   	    	  		              */
--------------------------------------------------------------------------------

select sub_category, round(avg(unit_price),2)  avg_unit_price, round(avg(unit_cost),2) as avg_unit_cost,round(avg(unit_price) -avg(unit_cost),2) margin  from customer_spending where sale_year='2015' group by sub_category order by sub_category;

--------------------------------------------------------------------------------
/*				                  Query 3   	    	  		              */
--------------------------------------------------------------------------------

select sale_year, count(gender) total_female_buyers from customer_spending where category='Clothing' and gender='F'  group by sale_year;

--------------------------------------------------------------------------------
/*				                  Query 4   	    	  		              */
--------------------------------------------------------------------------------

select age,sub_category,round(avg(quantity)) avg_quantity ,round(avg(cost),2) avg_cost from customer_spending group by age,sub_category order by age desc, sub_category asc ;


--------------------------------------------------------------------------------
/*				                  Query 5   	    	  		              */
--------------------------------------------------------------------------------

select country from customer_spending where age >17 and age <26 group by country having count(*) >900;
--------------------------------------------------------------------------------
/*				                  Query 6   	    	  		              */
--------------------------------------------------------------------------------

select sale_year,category,sum(revenue) total_revenue, sum(cost) total_cost,sum(revenue)-sum(cost) as profit from customer_spending group by sale_year,category having sum(revenue) > sum(cost) order by profit desc;

--------------------------------------------------------------------------------
/*				                  Query 7   	    	  		              */
--------------------------------------------------------------------------------

select age,round(avg(unit_price * quantity),2) avg_spending from customer_spending where gender='M' group by age order by avg_spending desc ;

--------------------------------------------------------------------------------
/*				                  Query 8   	    	  		              */
--------------------------------------------------------------------------------

select gender, category,max(unit_cost) high_cost,min(unit_cost) low_cost,avg(unit_cost) avg_cost from customer_spending group by gender, category order by gender, category;

--------------------------------------------------------------------------------
/*				                  Query 9   	    	  		              */
--------------------------------------------------------------------------------

select category, country,min(age) youngest_customer,max(age) oldest_customer,round(avg(age),1) avg_customer_age from customer_spending where sale_year=2016 group by category, country order by category,avg(age) ;

--------------------------------------------------------------------------------
/*				                  Query 10   	    	  		              */
--------------------------------------------------------------------------------

select country,round(avg(revenue),2) high_sales from customer_spending group by country order by high_sales desc limit 1;
