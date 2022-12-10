USE sakila;

-- 1. List each pair of actors that have worked together.
SELECT fa1.film_id, fa1.actor_id, fa2.actor_id
  FROM film_actor AS fa1
  JOIN film_actor AS fa2
    ON fa2.film_id = fa1.film_id
   AND fa2.actor_id <> fa1.actor_id;


-- 2. For each film, list actor that has acted in more films (in coparisson to other actors from same film)

  WITH cte_fpa as (
SELECT fa.film_id, fa.actor_id,
	   q1.films_per_actor,
	   DENSE_RANK() OVER(PARTITION BY fa.film_id ORDER BY q1.films_per_actor DESC) AS rn
  FROM film_actor AS fa
  JOIN (SELECT actor_id, COUNT(*) AS films_per_actor
		  FROM film_actor
		 GROUP BY actor_id) as q1
	ON q1.actor_id = fa.actor_id
 ORDER BY film_id) 
SELECT f.title,
	   cte_fpa.*
  FROM cte_fpa
  JOIN film AS f
    ON f.film_id = cte_fpa.film_id
 WHERE cte_fpa.rn = 1;
 







