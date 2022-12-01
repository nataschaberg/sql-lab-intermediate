USE sakila;

-- 1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id,
	   c.city,
       co.country
  FROM store AS s
  JOIN address AS a
    ON a.address_id = s.address_id
  JOIN city AS c
    ON c.city_id = a.city_id
  JOIN country AS co
    ON co.country_id = c.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id,
	   round(SUM(p.amount)) AS total_dollar_amount_per_store
  FROM staff AS st
  JOIN payment AS p
    ON p.staff_id = st.staff_id
  JOIN store as s
    ON s.store_id = st.store_id
 GROUP BY s.store_id;
 
-- 3 What is the average running time of films by category?
SELECT c.category_id, c.name,
	   AVG(f.length) AS avg_length_per_category
  FROM film AS f
  JOIN film_category AS fc
    ON fc.film_id = f.film_id
  JOIN category AS c
    ON c.category_id = fc.category_id
 GROUP BY category_id;
 
-- 4 Which film categories are longest?
SELECT c.category_id, c.name,
	   MAX(f.length) AS max_length_per_category
  FROM film AS f
  JOIN film_category AS fc
    ON fc.film_id = f.film_id
  JOIN category AS c
    ON c.category_id = fc.category_id
 GROUP BY category_id
 ORDER BY max_length_per_category DESC;
 
 -- 5 Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(*) AS times_rented
  FROM rental AS r
  JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
  JOIN film AS f
    ON f.film_id = i.film_id
 GROUP BY f.title
 ORDER BY times_rented DESC; 

-- 6 List the top five genres in gross revenue in descending order.
SELECT c.name,
       SUM(p.amount) AS sum_per_category
  FROM payment AS p
  JOIN rental AS r
    ON r.rental_id = p.rental_id
  JOIN inventory as i
    ON i.inventory_id = r.inventory_id
  JOIN film AS f
    ON f.film_id = i.film_id
  JOIN film_category AS fc
    ON fc.film_id = f.film_id
  JOIN category as c
    ON c.category_id = fc.category_id
 GROUP BY c.name
 ORDER BY sum_per_category DESC
 LIMIT 5;

-- 7 Is "Academy Dinosaur" available for rent from Store 1?
SELECT i.store_id, COUNT(*) AS copies_available
  FROM inventory AS i
  JOIN film AS f
    ON f.film_id = i.film_id
 WHERE f.title = 'Academy Dinosaur'
 GROUP BY i.store_id






