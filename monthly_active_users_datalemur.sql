/*
count the times when a user has done any of the event in each month
group by user_id and MONTH
do a self join on user_id 
where current_month and previous_month
*/

with cte as (
select
      user_id,
      EXTRACT(month from event_date) as month,
      sum(
      CASE
      when event_type in ('sign-in' , 'like' , 'comment') then 1 else 0
      END
      ) as event_count
from user_actions
where extract (year from event_date) = 2022 and EXTRACT(month from event_date) in (6,7)
GROUP by user_id , EXTRACT(month from event_date)
)
SELECT
      curr.month,
      count(DISTINCT(curr.user_id)) as monthly_active_user
FROM cte curr
join cte prev on prev.user_id = curr.user_id
where prev.month = 6 and curr.month = 7
group by curr.month;