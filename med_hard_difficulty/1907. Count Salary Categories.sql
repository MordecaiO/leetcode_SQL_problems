/*Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

*/
WITH salary_ranges as ( 
    SELECT account_id, income, CASE
    WHEN income < 20000 THEN "Low Salary"
    WHEN income >= 20000 
    AND income <= 50000 THEN "Average Salary"
    WHEN income > 50000 THEN "High Salary"
    END as category FROM Accounts
), 

salary_counts AS (
SELECT category, COUNT(account_id) as accounts_count FROM salary_ranges GROUP BY category
), 

categories (category) AS (
    (SELECT "Low Salary") 
    UNION (SELECT "Average Salary")
    UNION (SELECT "High Salary")
) 

SELECT c.category, 
CASE WHEN sc.accounts_count IS NULL THEN 0
ELSE sc.accounts_count END AS accounts_count
FROM categories c 
LEFT JOIN salary_counts sc ON 
c.category = sc.category 
