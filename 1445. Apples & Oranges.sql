/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date, fruit) is the primary key for this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write an SQL query to report the difference between the number of apples and oranges sold each day.

Return the result table ordered by sale_date.

The query result format is in the following example.

 

Example 1:

Input: 
Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
| 2020-05-01 | apples     | 10          |
| 2020-05-01 | oranges    | 8           |
| 2020-05-02 | apples     | 15          |
| 2020-05-02 | oranges    | 15          |
| 2020-05-03 | apples     | 20          |
| 2020-05-03 | oranges    | 0           |
| 2020-05-04 | apples     | 15          |
| 2020-05-04 | oranges    | 16          |
+------------+------------+-------------+
Output: 
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+
*/

WITH total_apples_sold AS 
  ( SELECT sale_date, sold_num, fruit
    FROM sales 
    WHERE fruit = "apples"
    GROUP BY sale_date
  ) 
  , total_oranges_sold AS
  ( SELECT  sale_date, sold_num, fruit
    FROM sales 
    WHERE fruit = "oranges"
    GROUP BY sale_date
  ) 

  SELECT sales.sale_date, 
   (total_apples_sold.sold_num - total_oranges_sold.sold_num) AS diff
  FROM sales 
  LEFT JOIN total_apples_sold ON sales.sale_date = total_apples_sold.sale_date
  LEFT JOIN total_oranges_sold ON sales.sale_date = total_oranges_sold.sale_date
  GROUP BY sale_date
