USE sakila;

-- 1 Select the first name, last name, and email address of all the customers who have rented a movie
SELECT c.first_name, c.last_name, c.email
  FROM rental AS r
  JOIN customer AS c
    ON c.customer_id = r.customer_id
 GROUP BY c.customer_id;


-- 2 What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       ROUND(AVG(p.amount), 2) AS avg_payment_per_customer
  FROM payment AS p
  JOIN customer AS c
    ON c.customer_id = p.customer_id
 GROUP BY p.customer_id;
 

-- 3 Select the name and email address of all the customers who have rented the "Action" movies
-- using joins
SELECT first_name, last_name, email
  FROM customer
  JOIN rental
	ON customer.customer_id = rental.customer_id
  JOIN inventory 
	ON rental.inventory_id = inventory.inventory_id
  JOIN film
	ON film.film_id = inventory.film_id
  JOIN film_category 
	ON film_category.film_id = film.film_id
  JOIN category 
	ON category.category_id = film_category.category_id
 WHERE category.name = "Action"
 GROUP BY first_name, last_name, email;
 

-- using sub queries
SELECT c.first_name, c.last_name, c.email
 FROM customer AS c
 JOIN rental as r
   ON r.customer_id = c.customer_id
 JOIN inventory as i
   ON i.inventory_id = r.inventory_id
WHERE film_id IN 
	 (SELECT film_id
	    FROM film_category
	   WHERE category_id = 
             (SELECT category_id
				FROM category 
			   WHERE category.name = "Action"))
GROUP BY c.customer_id;


-- 4 
SELECT *,
       CASE
		    WHEN q1.avg_payment_per_customer < 3 THEN "low"
			WHEN q1.avg_payment_per_customer < 5 THEN "medium"
			ELSE "high"
	   END AS trans_category
  FROM (
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       ROUND(AVG(p.amount), 2) AS avg_payment_per_customer
  FROM payment AS p
  JOIN customer AS c
    ON c.customer_id = p.customer_id
 GROUP BY p.customer_id) as q1;

  
  
  
  
  