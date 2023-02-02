USE sakila;

-- 1 static procedure for customer info - who rented action movies 
DELIMITER //
CREATE PROCEDURE customer_info_film_category_static()
BEGIN
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
END;
// DELIMITER ;

call customer_info_film_category_static();


-- 2

DELIMITER //
CREATE PROCEDURE customer_info_per_film_category_rented(in p_film_category varchar(100))
BEGIN
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
	 WHERE category.name = p_film_category
	 GROUP BY first_name, last_name, email;
END;
// DELIMITER ;

call customer_info_per_film_category_rented("Sci-Fi");

-- 3
-- Write a query to check the number of movies released in each movie category.

DELIMITER //
CREATE PROCEDURE films_in_categories(in p_film_threshold int)
BEGIN
	SELECT cat.category_id, cat.name,
		   cat_count.films_in_category
	  FROM category AS cat
	  JOIN (SELECT category_id, COUNT(*) AS films_in_category
			  FROM film_category
			 GROUP BY category_id) AS cat_count
		ON cat_count.category_id = cat.category_id
	 WHERE cat_count.films_in_category > p_film_threshold;
END;
// DELIMITER ;

call films_in_categories(60);