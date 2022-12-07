
USE bank;
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
  LEFT JOIN disp AS d
    ON d.client_id = cl.client_id
  LEFT JOIN card AS c
    ON c.disp_id = d.disp_id
 WHERE card_id IS NULL;

SELECT COUNT(*)
  FROM client AS cl
  LEFT JOIN disp AS d
    ON d.client_id = cl.client_id
  LEFT JOIN card AS c
    ON c.disp_id = d.disp_id
 WHERE card_id IS NULL;
 

