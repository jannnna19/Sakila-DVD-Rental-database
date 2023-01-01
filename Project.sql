query1
FROM SET1 
Q1

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.

WITH T1 AS
  (SELECT (F.title) AS "Film Title",
          (C.name) AS "Category Type",
          R.rental_date
   FROM film F
   JOIN film_category FC ON F.film_id =FC.film_id
   JOIN category C ON C.category_id = FC.category_id
   JOIN inventory I ON I.film_id = F.film_id
   JOIN rental R ON I.inventory_id = R.inventory_id)
  (SELECT DISTINCT "Film Title",
                   "Category Type",
                   COUNT(rental_date) OVER(PARTITION BY "Film Title") AS rental_count
   FROM T1
   WHERE "Category Type" IN ('Animation',
                             'Children',
                             'Classics',
                             'Comedy',
                             'Family',
                             'Music') )
ORDER BY 2;


query2
FROM SET2 
Q1

Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.

SELECT DATE_PART('month', R.rental_date) AS month_rental,
       DATE_PART('year', R.rental_date) AS year_rental,
       store.store_id,
       Count(R.rental_id) AS rental_counts
FROM rental R
JOIN staff ON R.staff_id = staff.staff_id
JOIN store ON staff.store_id =store.store_id
GROUP BY 1,
         2,
         3
ORDER BY 4 DESC;



query3
FROM MY OWN

find a list of  movies, types, and description where the movie length was more than 60 minutes

SELECT DISTINCT f.title,
                f.description,
                f.length,
                c.name AS film_type
FROM film_category
JOIN category c ON film_category.category_id =c.category_id
JOIN film f ON film_category.film_id = f.film_id
WHERE f.length > 60
ORDER BY f.length ASC;


query4
FROM MY OWN 
find each actor who has made the maximum number of movies with a PG-13 rating

SELECT a.actor_id,
       a.first_name||' '||a.last_name AS Actor_Name,
       f.rating,
       count(*) movie_count
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.rating = 'PG-13'
GROUP BY 1,
         2,
         3
ORDER BY 2,
         3 DESC