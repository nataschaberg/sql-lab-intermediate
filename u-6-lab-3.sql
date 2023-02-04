USE sakila;

-- 1 Write a query to find what is the total business done by each store.
SELECT s.store_id, SUM(p.amount)
  FROM store AS s
  JOIN staff AS st
    ON st.store_id = s.store_id
  JOIN payment AS p
    ON p.staff_id = st.staff_id
 GROUP BY s.store_id; 


-- 2 Convert the previous query into a stored procedure.
DELIMITER //
CREATE PROCEDURE turnover_all_stores ()
BEGIN
  SELECT s.store_id, SUM(p.amount) AS turnover_total
	FROM store AS s
    JOIN staff AS st
      ON st.store_id = s.store_id
    JOIN payment AS p
      ON p.staff_id = st.staff_id
   GROUP BY s.store_id;
END;
//
DELIMITER ;

CALL turnover_all_stores();

-- 3 Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
DELIMITER //
CREATE PROCEDURE turnover_per_store (in p_store_id int)
BEGIN
  SELECT s.store_id, SUM(p.amount) AS turnover_total
	FROM store AS s
    JOIN staff AS st
      ON st.store_id = s.store_id
    JOIN payment AS p
      ON p.staff_id = st.staff_id
   WHERE s.store_id = p_store_id
   GROUP BY s.store_id;
END;
//
DELIMITER ;

CALL turnover_per_store(1);
CALL turnover_per_store(2);

-- 4 Update the previous query. Declare a variable total_sales_value of float type, that will store the 
-- returned result (of the total sales amount for the store). Call the stored procedure and print the results.

DELIMITER //
CREATE PROCEDURE turnover_per_store_ret (in p_store_id int, out p_turnover_store float)
BEGIN
  SELECT SUM(p.amount) into p_turnover_store
	FROM store AS s
    JOIN staff AS st
      ON st.store_id = s.store_id
    JOIN payment AS p
      ON p.staff_id = st.staff_id
   WHERE s.store_id = p_store_id
   GROUP BY s.store_id;
END;
//
DELIMITER ;

CALL turnover_per_store_ret(1, @turnover_store_1);
SELECT @turnover_store_1;

CALL turnover_per_store_ret(2, @turnover_store_2);
SELECT @turnover_store_2;


-- 5 In the previous query, add another variable flag. If the total sales value for the store is over 30.000, 
-- then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input 
-- as the store_id and returns total sales value for that store and flag value.


DELIMITER //
CREATE PROCEDURE turnover_per_store_flag (in p_store_id int, out p_turnover_store float, out p_turnover_label varchar(50))
BEGIN
  SELECT SUM(p.amount) into p_turnover_store
	FROM store AS s
    JOIN staff AS st
      ON st.store_id = s.store_id
    JOIN payment AS p
      ON p.staff_id = st.staff_id
   WHERE s.store_id = p_store_id
   GROUP BY s.store_id;
   
   IF p_turnover_store > 30000 THEN
	SET p_turnover_label = 'green_flag';
   ELSE
	SET p_turnover_label = 'red_flag';
   END IF;
END;
//
DELIMITER ;

CALL turnover_per_store_flag(1, @turnover_store_1, @turnover_flag_store_1);
SELECT @turnover_store_1, @turnover_flag_store_1;

CALL turnover_per_store_flag(2, @turnover_store_2, @turnover_flag_store_2);
SELECT @turnover_store_2, @turnover_flag_store_2;
