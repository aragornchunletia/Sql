# Write your MySQL query statement below
/*
needed is a fraction of players that logged on consecutive days when they logged in 
first time
steps:
-> partition by player id 
-> count the number of partition which have min(date) and min(date) + 1 / total_number of partitions
*/

select
round(sum(consec_day) / count(distinct(player_id)),2) as fraction
from( select player_id ,
datediff(event_date, min(event_date) over (partition by player_id)) = 1 as consec_day
from activity) as next_table
;

/*
WITH next_table AS (
    SELECT 
        player_id, 
        DATE_ADD(MIN(event_date), INTERVAL 1 DAY) AS consec_day
    FROM 
        activity
    GROUP BY 
        player_id
)

select round(count(*) / (select count(Distinct(player_id)) from activity),2) as fraction
from activity
inner join next_table on
next_table.player_id = activity.player_id and activity.event_date = next_table.consec_day
;
*/

