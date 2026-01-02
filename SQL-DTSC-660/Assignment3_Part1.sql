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

select trans_date,(code_size::numeric/transactions) as difficulty from bitcoin;

--------------------------------------------------------------------------------
/*				                  Query 2   	    	  		              */
--------------------------------------------------------------------------------

select trans_date,median_transaction_fee * transactions as daily_cost from bitcoin where median_transaction_fee > 0.5 ;


--------------------------------------------------------------------------------
/*				                  Query 3   	    	  		              */
--------------------------------------------------------------------------------

select trans_date,(sent_in_usd::numeric/ transactions) as avg_transaction from bitcoin where transactions > 400000 ;

--------------------------------------------------------------------------------
/*				                  Query 4   	    	  		              */
--------------------------------------------------------------------------------

select CAST(avg(price_usd) as money ) avg_price ,CAST(sum(sent_in_usd) as money) total_transaction_amount from bitcoin where trans_date > '2015-04-30' and trans_date < '2015-06-01';


--------------------------------------------------------------------------------
/*				                  Query 5   	    	  		              */
--------------------------------------------------------------------------------

select min(market_cap) low_cap ,max(market_cap) high_cap,round(min(price_usd),2) low_price_usd,round(max(price_usd),2) high_price_usd  from bitcoin ;

--------------------------------------------------------------------------------
/*				                  Query 6   	    	  		              */
--------------------------------------------------------------------------------

select  min(median_transaction_fee) lowest_fee ,max(median_transaction_fee) highest_fee,round(avg(transaction_fees),5) avg_fee  from bitcoin where trans_date > '2017-08-09' and trans_date < '2019-08-11';

--------------------------------------------------------------------------------
/*				                  Query 7   	    	  		              */
--------------------------------------------------------------------------------

select  avg(transactions ) avg_transactions  ,avg(sent_by_address) avg_sent_addresses   from bitcoin where transactions > 350000 ;

--------------------------------------------------------------------------------
/*				                  Query 8   	    	  		              */
--------------------------------------------------------------------------------

select  round(avg(google_trends)) avg_google_trends ,sum(tweets) total_tweets  from bitcoin;

--------------------------------------------------------------------------------
/*				                  Query 9   	    	  		              */
--------------------------------------------------------------------------------

select  round(min(confirmation_time ),3) min_confirmation_time ,round(max(confirmation_time),3) max_confirmation_time,round(avg(confirmation_time),3) avg_confirmation_time from bitcoin;

--------------------------------------------------------------------------------
/*				                  Query 10   	    	  		              */
--------------------------------------------------------------------------------

select  round(avg(price_usd),2) avg_price_usd,round(avg(mining_profitability),2) avg_mining_profitability,round(avg(transaction_fees),2) avg_transaction_fees   from bitcoin where trans_date > '2020-02-29' and trans_date < '2020-12-01';

