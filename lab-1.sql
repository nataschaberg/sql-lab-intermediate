USE sakila;

-- 1
SELECT c.name AS category_name,
	   COUNT(*) as films_per_category
  FROM film_category AS fm
  JOIN category AS c
    ON c.category_id = fm.category_id
 GROUP BY fm.category_id;

-- 2
SELECT s.first_name, s.last_name,
	   a.address
  FROM staff AS s
  JOIN address AS a
    ON a.address_id = s.address_id;

-- 3
SELECT staff_id, SUM(amount) AS rental_total
  FROM payment
 WHERE SUBSTRING(payment_date, 1, 7) = '2005-08'
 GROUP BY staff_id;

/*
SELECT r.staff_id,
       SUM(f.rental_rate) AS rental_rate_sum
  FROM rental AS r
  JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
  JOIN film as f
	ON f.film_id = i.film_id
 WHERE SUBSTRING(r.rental_date, 1, 7) = '2005-08'
 GROUP BY r.staff_id;
*/

-- 4
SELECT f.title,
	   COUNT(*) AS actors_count
  FROM film_actor AS fa
  JOIN film AS f
	ON f.film_id = fa.film_id
 GROUP BY fa.film_id;

-- 5
SELECT c.last_name, c.first_name, 
       SUM(p.amount) AS total_amount
  FROM payment AS p
  JOIN customer AS c
    ON c.customer_id = p.customer_id
 GROUP BY p.customer_id
 ORDER BY last_name;
 
 
 
 