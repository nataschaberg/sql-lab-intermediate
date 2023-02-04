# Lab | SQL Join

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.The database is structured as follows:

![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png)

### Instructions

1. List the number of films per `category`.
2. Display the first and the last names, as well as the address, of each staff member.
3. Display the total amount rung up by each staff member in August 2005.
4. List all films and the number of actors who are listed for each film.
5. Using the `payment` and the `customer` tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.

<br><br>

# Lab | SQL Joins on multiple tables

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

1. Write a query to display for each store its store ID, city, and country.
2. Write a query to display how much business, in dollars, each store brought in.
3. What is the average running time of films by category?
4. Which film categories are longest?
5. Display the most frequently rented movies in descending order.
6. List the top five genres in gross revenue in descending order.
7. Is "Academy Dinosaur" available for rent from Store 1?

<br><br>

# Lab | SQL Self and cross join

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

1. Get all pairs of actors that worked together.
2. Get all pairs of customers that have rented the same film more than 3 times.
3. Get all possible pairs of actors and films.

<br><br>

# Lab | SQL Subqueries

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. Create appropriate joins wherever necessary. 

### Instructions

1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
2. List all films whose length is longer than the average of all the films.
3. Use subqueries to display all actors who appear in the film _Alone Trip_.
4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.


<br><br>

# Lab | SQL Advanced queries

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

1. List each pair of actors that have worked together.
2. For each film, list actor that has acted in more films.

<br><br>

# Lab | SQL Rolling calculations

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

1. Get number of monthly active customers.
2. Active users in the previous month.
3. Percentage change in the number of active customers.
4. Retained customers every month.

<br><br>
# Lab | Aggregation Revisited - Subqueries

### Instructions

Write the SQL queries to answer the following questions:

  - Select the first name, last name, and email address of all the customers who have rented a movie.
  - What is the average payment made by each customer (display the *customer id*, *customer name* (concatenated), and the *average payment made*).
  - Select the *name* and *email* address of all the customers who have rented the "Action" movies.

    - Write the query using multiple join statements
    - Write the query using sub queries with multiple WHERE clause and `IN` condition
    - Verify if the above two queries produce the same results or not

  - Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be `low` and if the amount is between 2 and 4, the label should be `medium`, and if it is more than 4, then it should be `high`.


<br><br>
# Lab | Stored procedures

### Instructions

Write queries, stored procedures to answer the following questions:

- In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented `Action` movies. Convert the query into a simple stored procedure. Use the following query:

  ```sql
    select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
  ```

- Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be `action`, `animation`, `children`, `classics`, etc.

- Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.



<br><br>
# Lab | SQL Iterations

### Instructions

Write queries to answer the following questions:

- Write a query to find what is the total business done by each store.
- Convert the previous query into a stored procedure.
- Convert the previous query into a stored procedure that takes the input for `store_id` and displays the *total sales for that store*.
- Update the previous query. Declare a variable `total_sales_value` of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.
- In the previous query, add another variable `flag`. If the total sales value for the store is over 30.000, then label it as `green_flag`, otherwise label is as `red_flag`. Update the stored procedure that takes an input as the `store_id` and returns total sales value for that store and flag value.
