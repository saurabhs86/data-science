/*
    Name: Saurabh Sinha
    DTSC660: Data and Database Management with SQL
    Assignment 6
*/

--------------------------------------------------------------------------------
/*				                   Part 1   		  		                  */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*	The Chosen data set is Food Choices because of the scope of data cleaning work that is required*/
--------------------------------------------------------------------------------

/*  Upon analysis of the food choices table it can be seen that it has lot of columns
	which have inconsistencies, errors, and misrepresentations of data . Columns like 
	calories_day, weight, cuisine, fav_cuisine etc can be seen having data like, 
	'nan','none' etc which are not part of the data dictionary,while column weight etc 
	which idealy should only numeric , can we seen having 'lbs' in few rows.
	Each of which needs to be cleaned up differenlty. Hence felt like there was 
	scope of further cleaning in this data set.                */

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Select Statement      		  		          */
--------------------------------------------------------------------------------

    SELECT * FROM food_choices;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   Backup Table     		  		          */
--------------------------------------------------------------------------------

	CREATE TABLE food_choices_backup AS SELECT * FROM food_choices;
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Duplicate Column      		  		          */
--------------------------------------------------------------------------------

ALTER TABLE food_choices
ADD COLUMN weight_duplicate VARCHAR(255);

UPDATE food_choices
SET	weight_duplicate = weight;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   PART 2           		  		          */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*		              Question 1 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT
	weight
FROM
	food_choices
WHERE
	weight LIKE '%nan%'
	OR weight LIKE '%not answering this.%';-- 3 such entries
--------------------------------------------------------------------------------
/*				          Question 1 - Update query                           */
--------------------------------------------------------------------------------
UPDATE food_choices
SET
	weight = NULL
WHERE
	weight LIKE '%nan%'
	OR weight LIKE '%not answering this.%'
RETURNING
	weight;

UPDATE food_choices
SET
	weight = REPLACE(weight, 'Not sure, ', '')
WHERE
	weight LIKE '%Not sure, 240%'
RETURNING
	weight;

UPDATE food_choices
SET
	weight = REPLACE(weight, 'lbs', '')
RETURNING
	weight;

ALTER TABLE food_choices
ALTER COLUMN weight type INTEGER USING (weight::INTEGER);

--------------------------------------------------------------------------------
/*				        Question 1 - Validation query                         */
--------------------------------------------------------------------------------

SELECT
	weight
FROM
	food_choices
WHERE
	weight::VARCHAR LIKE '%nan%'
	OR weight::VARCHAR LIKE '%not answering this.%'; --after update no such nan , literal etc entries for weight. 
--------------------------------------------------------------------------------
/*				        Question 1 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* As per food choices data dictionary ,the value should be in numbers. 
   Any non answered values should be null, hence those values were updated to null.
   There were few data which had literals lile 'nan','lbs' ,even those were replaced.
   Ultimately changed the data type to an integer
*/
    
--------------------------------------------------------------------------------
/*		              Question 2 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT
	calories_day
FROM
	food_choices
WHERE
	calories_day LIKE '%nan%';
-- 19 rows which have nan . 
--------------------------------------------------------------------------------
/*				          Question 2 - Update query                           */
--------------------------------------------------------------------------------

UPDATE food_choices
SET
	calories_day = '1'
WHERE
	calories_day LIKE '%nan%'
RETURNING
	calories_day;


--------------------------------------------------------------------------------
/*				        Question 2 - Validation query                         */
--------------------------------------------------------------------------------

SELECT
	calories_day
FROM
	food_choices
WHERE
	calories_day LIKE '%nan%';
--no such rows having nan anymore
--------------------------------------------------------------------------------
/*				        Question 2 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*    As per the food choices data dictionary, the allowed vaules for calories_day is:
1 - i dont know how many calories i should consume 
2 - it is not at all important 
3 - it is moderately important 
4 - it is very important
So any 'nan' as such will be categorized under '1' .Updated 19 such rows.
*/
    
--------------------------------------------------------------------------------
/*		              Question 3 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT DISTINCT
	fav_cuisine
FROM
	food_choices
WHERE
	fav_cuisine ILIKE '%mexican%';

--the 'Mexican' cuisine is mentioned in 5 different ways
--------------------------------------------------------------------------------
/*				          Question 3 - Update query                           */
--------------------------------------------------------------------------------
UPDATE food_choices
SET
	fav_cuisine = INITCAP(SUBSTRING(fav_cuisine, 1, 7))
WHERE
	fav_cuisine ILIKE '%mexican%'
RETURNING
	fav_cuisine;

-- updating to 'Mexican'

--------------------------------------------------------------------------------
/*				        Question 3 - Validation query                         */
--------------------------------------------------------------------------------

SELECT DISTINCT
	fav_cuisine
FROM
	food_choices
WHERE
	fav_cuisine ILIKE '%mexican%';
--Now we have only one way to refer to 'Mexican' cuisine in this column 
--------------------------------------------------------------------------------
/*				        Question 3 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*   As we can see in the column fav_cuisine the 'Mexican' cuisine is 
mentioned in 5 different ways. Instead of having it refered in so many ways we can have
a common way to represent it. Hence the update the column with such data. At the end 
only one 'Mexican' cuisine can be seen in the column*/
    
--------------------------------------------------------------------------------
/*		              Question 4 - Indentification query                      */
--------------------------------------------------------------------------------
SELECT DISTINCT
	(type_sports)
FROM
	food_choices
WHERE
	type_sports ILIKE '%none%'
ORDER BY
	type_sports;
-- 8 ways 'none' has been represented in column type_sports
--------------------------------------------------------------------------------
/*				          Question 4 - Update query                           */
--------------------------------------------------------------------------------

UPDATE food_choices
SET
	type_sports = CASE
		WHEN type_sports = 'nan' THEN NULL
		WHEN type_sports IN ('None', 'None.', ' None') THEN NULL
		WHEN type_sports IN ('none', 'none ') THEN NULL
		WHEN type_sports IN (
			'None at the moment',
			'none organized',
			'None right now'
		) THEN NULL
		WHEN type_sports IN (
			'no particular engagement ',
			'No, I don''t play sport.',
			'None right now'
		) THEN NULL
		ELSE type_sports
	END;


--------------------------------------------------------------------------------
/*				        Question 4 - Validation query                         */
--------------------------------------------------------------------------------
SELECT DISTINCT
	type_sports
FROM
	food_choices
WHERE
	type_sports ILIKE '%none%'
ORDER BY
	type_sports;
-- no more 'none' as a type of type_sports
--------------------------------------------------------------------------------
/*				        Question 4 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*There are lot of person who don't play sports and they are represented in different ways.
Instead the query updates them to null where ever 'type_sports' is not valid . Hence different types
of case has been taken into consideration. This makes the column data a bit cleaner.
*/
    
--------------------------------------------------------------------------------
