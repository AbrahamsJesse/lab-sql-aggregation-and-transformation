/*Before this starting this lab, you should have learnt about:

- SELECT, FROM, ORDER BY, LIMIT, WHERE, GROUP BY, and HAVING clauses.
- DISTINCT keyword to return only unique values, AS keyword for using aliases.
- Built-in SQL functions such as COUNT, MAX, MIN, AVG, ROUND, DATEDIFF, or DATE_FORMAT.
- CASE statement for conditional logic.*/

 /*Challenge 1

/*1. You need to use SQL built-in functions to gain insights relating to the duration of movies:*/
	/*- 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.*/
    
select MAX(length) as max_duration, MIN(length) as min_duration
from sakila.film;
    
	/*- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
      - *Hint: Look for floor and round functions.**/
      
select  round(AVG(length),0) as Average_duration_minutes, round(AVG(length)/60,0) as Average_duration_hours
from sakila.film;
      
      
/*2. You need to gain insights related to rental dates:
	- 2.1 Calculate the **number of days that the company has been operating**.
      - *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*/
      
      select datediff(max(rental_date), min(rental_date)) as operating_days
      from sakila.rental;
      
      
	/*- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
	- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
      - *Hint: use a conditional expression.*/

SELECT EXTRACT(month FROM rental_date) as month_rental, EXTRACT(day from rental_date) as weekday_rental, dayname(rental_date)
FROM sakila.rental
limit 20;




	
 
      
/*3. You need to ensure that customers can easily access information about the movie collection.
 To achieve this, retrieve the **film titles and their rental duration**. 
 If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
 Sort the results of the film title in ascending order.
    - *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
    - *Hint: Look for the `IFNULL()` function.*/
     
	select title, ifnull (rental_duration, 'not available') as rental_duration
    from sakila.film
    order by title ASC;
    
    
    
   /* ## Challenge 2

1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	- 1.1 The **total number of films** that have been released.*/
    
    select count(title) as total_amount_films
    from sakila.film;
    
	/*- 1.2 The **number of films for each rating**.*/
    select rating, count(title) as number_movies
    from sakila.film
    group by rating;
    
	/*- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
	This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.*/
	select rating, count(title) as number_movies
    from sakila.film
    group by rating
    order by number_movies DESC;
    
    
/*2. Using the `film` table, determine:
   - 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
   Round off the average lengths to two decimal places.
   This will help identify popular movie lengths for each category.*/
   select rating, round(AVG(length),2) as film_mean
   from sakila.film
   group by rating
   order by film_mean DESC;
   
	/*- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films 
    for customers who prefer longer movies.*/
    select rating, round(AVG(length/60),2) as film_mean
   from sakila.film
   group by rating
   order by film_mean DESC;