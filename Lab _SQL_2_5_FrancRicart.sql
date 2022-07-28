/*
Instructions
1. Select all the actors with the first name ‘Scarlett’.
2. How many films (movies) are available for rent and how many films have been rented?
3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
4. What's the average movie duration expressed in format (hours, minutes)?
5. How many distinct (different) actors' last names are there?
6. Since how many days has the company been operating (check DATEDIFF() function)?
7. Show rental info with additional columns month and weekday. Get 20 results.
8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
9. Get release years.
10. Get all films with ARMAGEDDON in the title.
11. Get all films which title ends with APOLLO.
12. Get 10 the longest films.
13. How many films include Behind the Scenes content?
*/
USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor
WHERE first_name = "Scarlett";

-- 2. How many films (movies) are available for rent and how many films have been rented?

SELECT count(*) as Total_rented_films FROM sakila.film
Where rental_duration <> 0;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT MAX(length) as max_duration, MIN(length) as min_duration FROM sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?

SELECT left(sec_to_time(AVG(length)*60*60),6) as average_movie_duration FROM sakila.film;

-- 5. How many distinct (different) actors' last names are there?
SELECT count(distinct last_name) FROM sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(CURDATE(),'2006/02/15') AS days_on_business;
-- SELECT * FROM sakila.inventory: we find the earliest date here, apparently

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT * , date_format(convert(rental_date,date), "%M" ) as "Rental_date_month", date_format(convert(rental_date,date), "%W" ) as "Rental_date_weekday" FROM sakila.rental
LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, CASE
WHEN date_format(rental_date,'%W') in ('Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday') then 'workday'
WHEN date_format(rental_date,'%W') in ('Saturday', 'Sunday') then 'weekend'
END AS week_day
from sakila.rental;

-- '%W' makes ref. to the day of the week, in order to call it. I we wanted to use the abbreviated form (Sun to Sat) we have used %a.

-- 9. Get release years.
SELECT release_year FROM sakila.film;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT title FROM sakila.film
WHERE title like 'Armageddon%';

-- 11. Get all films which title ends with APOLLO.
SELECT title FROM sakila.film
WHERE title REGEXP 'APOLLO$';

-- It could also be: 
-- select * from film
-- where title like "%APOLLO";

-- 12. Get 10 the longest films.
SELECT film_id, title, length FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?
select count(film_id) from film
where special_features like "%Behind the scenes%";
