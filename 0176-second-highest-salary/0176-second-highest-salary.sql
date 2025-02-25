
WITH cte AS (
    SELECT e.salary, DENSE_RANK() OVER (ORDER BY e.salary DESC) AS rnk
    FROM employee e
)
SELECT 
    MAX(CASE 
        WHEN c.rnk=2 THEN c.salary 
        ELSE NULL 
    END )AS SecondHighestSalary
FROM cte c
;


