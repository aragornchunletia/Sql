/*
Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
*/


/*
steps
-> group by age_buckets
->segregate open, send calculate total of both and do a final res 
*/

with cte as (
select 
      sum(
        case 
          when act.activity_type = 'open' then act.time_spent else 0
        end
      ) as open_time,
      sum(
        case 
          when act.activity_type = 'send' then act.time_spent else 0
        end
      ) as send_time,
      ab.age_bucket as age_bucket
from activities act
join age_breakdown ab on ab.user_id = act.user_id
where activity_type = 'open' or activity_type = 'send'
group by ab.age_bucket
)
SELECT age_bucket ,
       round(send_time * 100.0 / (open_time + send_time),2) as send_perc,
       round(open_time * 100.0 / (open_time + send_time),2) as open_perc
FROM cte;