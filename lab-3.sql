/*
Get all pairs of actors that worked together.
Get all pairs of customers that have rented the same film more than 3 times.
Get all possible pairs of actors and films.
*/

USE sakila;
-- 1
SELECT *
  FROM film_actor AS fa1
  JOIN film_actor AS fa2
    ON fa2.film_id = fa1.film_id
   AND fa2.actor_id <> fa1.actor_id;
   
-- 2
-- step 1: get all customers which have rented a the same movie more than 1 time
SELECT i.film_id, r.customer_id, COUNT(*) AS times_rented
  FROM rental as r
  JOIN inventory as i
    ON i.inventory_id = r.inventory_id
 GROUP BY i.film_id, r.customer_id
HAVING times_rented > 1
 ORDER BY times_rented DESC;

-- step 2: bring together in one query
SELECT *
  FROM (
		SELECT i.film_id,
               r.customer_id,
               COUNT(*) AS times_rented
		  FROM rental as r
		  JOIN inventory as i
			ON i.inventory_id = r.inventory_id
		 GROUP BY i.film_id, r.customer_id
		HAVING times_rented > 1
	    ) as q1
  JOIN (
	    SELECT i.film_id, 
			   r.customer_id,
               COUNT(*) AS times_rented
		  FROM rental as r
		  JOIN inventory as i
			ON i.inventory_id = r.inventory_id
		 GROUP BY i.film_id, r.customer_id
		HAVING times_rented > 1
       ) as q2
    ON q2.film_id = q1.film_id
   AND q2.customer_id < q1.customer_id;

-- 3
SELECT f.film_id, f.title,
	   a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS full_name
  FROM film AS f
 CROSS JOIN actor AS a
 ORDER BY f.film_id, full_name;
  
