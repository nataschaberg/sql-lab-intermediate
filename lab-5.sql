USE sakila;

-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
SELECT COUNT(*) AS total_inventory
  FROM inventory
 WHERE film_id = (
                  SELECT film_id
				    FROM film
				   WHERE title = 'Hunchback Impossible'
				 );
                 

-- same query using join:
SELECT COUNT(*) AS total_inventory
  FROM inventory AS i
  JOIN film AS f
    ON f.film_id = i.film_id
 WHERE f.title = 'Hunchback Impossible';
 
 
-- same query using groupy by
SELECT f.film_id, f.title, COUNT(*)
  FROM inventory AS i
  JOIN film AS f
    ON f.film_id = i.film_id
 GROUP BY f.film_id
HAVING f.title = 'Hunchback Impossible';


-- 2. List all films whose length is longer than the average of all the films.
SELECT *
  FROM film
 WHERE length > (
				 SELECT AVG(length)
                   FROM film
                )
 ORDER BY length DESC;
 

-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
SELECT fa.film_id,
	   a.actor_id, a.first_name, a.last_name
  FROM film_actor AS fa
  JOIN actor AS a
    ON a.actor_id = fa.actor_id
 WHERE fa.film_id = (
					 SELECT film_id
					   FROM film
					  WHERE title = 'Alone Trip'
				    );


-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT fc.category_id, f.title
  FROM film_category AS fc
  JOIN film as f
    ON f.film_id = fc.film_id
 WHERE fc.category_id = (
						 SELECT category_id
						   FROM category
						  WHERE name = 'Family'
					    );


-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- using subqueries
SELECT ad.address_id, ad.address, ad.city_id,
	   c.first_name, c.last_name, c.email
  FROM address AS ad
  JOIN customer AS c
    ON c.address_id = ad.address_id
 WHERE ad.city_id IN (
				      SELECT city_id
				        FROM city
					   WHERE country_id = (
									       SELECT country_id
											 FROM country AS c
									        WHERE c.country = 'Canada'
									      )
				     );


-- using joins
SELECT *
  FROM customer AS c
  JOIN address AS ad
    ON ad.address_id = c.address_id
  JOIN city AS ci
    ON ci.city_id = ad.city_id
  JOIN country AS co
	ON co.country_id = ci.country_id
 WHERE co.country = 'Canada';


-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number 
-- of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT f.film_id, f.title,
       fa.actor_id
  FROM film_actor AS fa
  JOIN film as f
    ON f.film_id = fa.film_id
 WHERE fa.actor_id = (
				   SELECT actor_id
				     FROM film_actor
				    GROUP BY actor_id
				    ORDER BY COUNT(*) DESC
					LIMIT 1
                  );


-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie 
-- the customer that has made the largest sum of payments
SELECT DISTINCT f.title,
       r.customer_id
  FROM rental AS r
  JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
  JOIN film AS f
    ON f.film_id = i.film_id
 WHERE r.customer_id = (
						SELECT customer_id
						  FROM payment
						 GROUP BY customer_id
						 ORDER BY SUM(amount) DESC
						 LIMIT 1
					   )
 ORDER BY f.title;
 
 
-- 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average 
-- of the `total_amount` spent by each client.
SELECT customer_id, SUM(amount) AS total_amount_spend
  FROM payment
 GROUP BY customer_id
HAVING total_amount_spend > (
							SELECT AVG(total_amount)
							  FROM (
									SELECT SUM(amount) AS total_amount
									  FROM payment
									 GROUP BY customer_id
									) as t1
							)
ORDER BY total_amount_spend DESC;
                                
                                