USE bank;
-- 2.08 - 1

SELECT *,
	   DENSE_RANK() OVER(ORDER BY A4) as rank_num_inhabitants
 FROM district
ORDER BY rank_num_inhabitants;

SELECT *,
	   DENSE_RANK() OVER(PARTITION BY A3 ORDER BY A4) as rank_num_inhabitants
 FROM district
ORDER BY A3;

SELECT *,
	   DENSE_RANK() OVER(ORDER BY A9) AS rn_num_cities
  FROM district;
  
SELECT *,
	   DENSE_RANK() OVER(PARTITION BY A3 ORDER BY A9) AS rn_num_cities
  FROM district;

SELECT *,
       DENSE_RANK() OVER(ORDER BY A10) AS rn_urban_inh,
       DENSE_RANK() OVER(ORDER BY A11) AS rn_avg_salary,
       DENSE_RANK() OVER(ORDER BY A12) AS rn_unempl_rate
  FROM district;

SELECT *,
       DENSE_RANK() OVER(PARTITION BY A3 ORDER BY A10) AS rn_urban_inh,
       DENSE_RANK() OVER(PARTITION BY A3 ORDER BY A11) AS rn_avg_salary,
       DENSE_RANK() OVER(PARTITION BY A3 ORDER BY A12) AS rn_unempl_rate
  FROM district;
  
-- 2.08 - 2
-- Use the transactions table in the bank database to find the Top 20 account_ids based on the amount.

SELECT *,
       RANK() OVER(ORDER BY amount DESC) AS rn
  FROM trans
 LIMIT 20;

SELECT *,
       DENSE_RANK() OVER(ORDER BY amount DESC) AS rn
  FROM trans
 LIMIT 20;
 
-- 2.08 - 3
-- Get a rank of districts ordered by the number of customers.
SELECT d.A1,
       RANK() OVER(ORDER BY COUNT(*) DESC) as rn_clients_per_district
  FROM district as d
  JOIN client as c
    ON c.district_id = d.A1
 GROUP BY d.A1;

-- Get a rank of regions ordered by the number of customers.
-- Get the total amount borrowed by the district together with the average loan in that district.
-- Get the number of accounts opened by district and year.

-- 3.01 - 1
-- Get the number of clients by district, returning district name.

SELECT d.A1 AS district_id, d.A2 AS disctict_name,
       c.clients_per_district
  FROM district AS d
  JOIN (SELECT district_id, COUNT(*) AS clients_per_district
          FROM client
		 GROUP BY district_id) AS c
	ON c.district_id = d.A1
 ORDER BY c.clients_per_district DESC;
 
-- 3.02 - 1
-- Use the below query and list district_name, client_id and account_id for those clients who are owner of the account. Order the results by district_name:

SELECT da.A2,
	   c.client_id,
       d.account_id
  FROM bank.disp d
  JOIN bank.client c
    ON d.client_id = c.client_id
  JOIN bank.district da
    ON da.A1 = c.district_id
 WHERE d.type = 'OWNER'
 ORDER BY da.A2;

-- 3.02 - 2
-- List districts together with total amount borrowed and average loan amount.

SELECT c.district_id,
	   ROUND(SUM(l.amount),2) AS total_per_district,
       ROUND(AVG(l.amount),2) AS avg_per_district
  FROM loan AS l
  JOIN disp AS d
    ON d.account_id = l.account_id
  JOIN client AS c
    ON c.client_id = d.client_id
 GROUP BY c.district_id
 ORDER BY total_per_district DESC;
 
-- 3.02 - 3
-- Create a temporary table district_overview in the bank database which lists districts together with total amount borrowed and average loan amount.

CREATE TEMPORARY TABLE IF NOT EXISTS 
       district_overwiev AS 
       (SELECT c.district_id,
		       ROUND(SUM(l.amount),2) AS total_per_district,
			   ROUND(AVG(l.amount),2) AS avg_per_district
		  FROM loan AS l
		  JOIN disp AS d
			ON d.account_id = l.account_id
		  JOIN client AS c
			ON c.client_id = d.client_id
		 GROUP BY c.district_id
		 ORDER BY total_per_district DESC);

SELECT *
  FROM district_overwiev;
  
-- 3.02 - 4
-- Still working in the bank database, list the clients with no credit card.

SELECT *
  FROM client AS cl
  JOIN disp AS d
    ON d.client_id = cl.client_id
  LEFT JOIN card AS c
    ON c.disp_id = d.disp_id
 WHERE card_id IS NULL;

SELECT COUNT(*)
  FROM client AS cl
  JOIN disp AS d
    ON d.client_id = cl.client_id
  LEFT JOIN card AS c
    ON c.disp_id = d.disp_id
 WHERE card_id IS NULL;
 

-- 3.05 - 1
-- Find out the average number of transactions by account. Get those accounts that have more transactions than the average.



 

