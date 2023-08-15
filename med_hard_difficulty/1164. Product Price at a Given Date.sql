
/*Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

The query result format is in the following example.*/

WITH pre_max_date AS (
  SELECT product_id, MAX(change_date) AS change_date FROM Products 
  WHERE change_date <= "2019-08-16"
  GROUP BY product_id
),

 no_price_changes AS (
  SELECT product_id, 10 AS price FROM Products 
  WHERE product_id NOT IN (SELECT product_id FROM pre_max_date)
)

SELECT p.product_id, new_price AS price FROM Products p
INNER JOIN pre_max_date pre 
ON p.product_id = pre.product_id 
AND p.change_date = pre.change_date
UNION SELECT product_id, price FROM no_price_changes
