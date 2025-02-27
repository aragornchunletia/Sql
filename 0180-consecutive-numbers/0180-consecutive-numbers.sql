# Write your MySQL query statement bel
with cte as (
select  num , 
        lead(num) over (order by id) as next,
        lag(num) over (order by id) prev
from Logs
)
select distinct(cte.num) as ConsecutiveNums
from cte
where cte.num = cte.prev and cte.prev = cte.next
;
