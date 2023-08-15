/*Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.
Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.*/


# Write your MySQL query statement below
select distinct num as ConsecutiveNums from (
  select n1.id , n1.num, n2.num as 2nd_num, n3.num as 3rd_num , 
case when n1.num = n2.num AND n2.num = n3.num then true else false end as consec
from logs n1
left join logs n2 on n1.id = (n2.id + 1) 
left join logs n3 on n2.id = (n3.id +1)
) logs_cte
where consec = true

