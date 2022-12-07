
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
 

