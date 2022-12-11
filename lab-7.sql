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


-- Retained customers every month.

