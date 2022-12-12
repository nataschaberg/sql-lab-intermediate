USE sakila;

-- Get number of monthly active customers.
CREATE OR REPLACE VIEW monthly_active_customers AS
SELECT ren_year, ren_month, COUNT(*) as monthly_active_users
  FROM (SELECT DISTINCT YEAR(rental_date) AS ren_year, MONTH(rental_date) AS ren_month,
	           customer_id
         FROM rental
        ORDER BY ren_year DESC, ren_month DESC) as q
 GROUP BY ren_year, ren_month;

SELECT * 
 FROM monthly_active_customers;


-- Active users in the previous month.
SELECT *,
	   LEAD(monthly_active_users) OVER() AS previous_month_active_users
  FROM monthly_active_customers;
  

-- Percentage change in the number of active customers
SELECT *,
	   ROUND((monthly_active_users - previous_month_active_users) / previous_month_active_users * 100, 2)  AS diff_in_percent
  FROM (SELECT *,
	           LEAD(monthly_active_users) OVER() AS previous_month_active_users
          FROM monthly_active_customers) AS q;


-- Retained customers every month
-- step 1: get disctinct users with activity per month
CREATE OR REPLACE VIEW distinct_customers AS
SELECT DISTINCT customer_id,
               YEAR(rental_date) AS activity_year,
               MONTH(rental_date) AS activity_month
  FROM rental
 ORDER BY activity_year DESC, activity_month DESC;

SELECT *
  FROM distinct_customers;

-- step 2: self join to find recurrent customers
CREATE OR REPLACE VIEW recurrent_customers AS 
SELECT d1.customer_id, d1.activity_year, d1.activity_month,
	   d2.activity_month AS previous_month
  FROM distinct_customers AS d1
  JOIN distinct_customers AS d2
    ON d2.activity_year = d1.activity_year
   AND d2.activity_month = d1.activity_month-1
   AND d2.customer_id = d1.customer_id
 ORDER BY d1.customer_id DESC, d1.activity_year DESC, d1.activity_month DESC; 
    
SELECT *
  FROM recurrent_customers
 ORDER BY activity_year DESC, activity_month DESC;

CREATE OR REPLACE VIEW total_recurrent_customers AS
SELECT activity_year, activity_month, COUNT(customer_id) AS recurrent_user
  FROM recurrent_customers
 GROUP BY activity_year, activity_month;

SELECT *
  FROM total_recurrent_customers;
 
-- monthly recurrent users side by side
SELECT *,
	   LAG(recurrent_user) OVER() AS previous_month_recurring_user
  FROM total_recurrent_customers;

