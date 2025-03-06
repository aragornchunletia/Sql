/*
identify top 3
dense_rank over partition by department_id order by salary
then join these results in department_name table
*/
with cte as (
select  
      name,
      salary,
      department_id,
      dense_rank() over (PARTITION by department_id order by salary desc) as rnk
from employee
)
SELECT 
      d.department_name,
      cte.name,
      cte.salary
FROM cte
INNER join department d on d.department_id = cte.department_id
where cte.rnk <= 3
order by d.department_name asc, cte.salary desc, cte.name asc
;