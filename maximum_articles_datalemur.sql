with cte as (
select 
      item_type,
      sum(square_footage) as total_area,
      count(*) as article_count
from inventory
group by item_type
),
prime_items as (
select 
      item_type,
      floor(500000/(select total_area from cte where item_type = 'prime_eligible')) as package_count,
      floor(500000/(select total_area from cte where item_type = 'prime_eligible')) * article_count as item_count
from cte
where item_type = 'prime_eligible'
),
non_prime as (
select 
      item_type,
      500000 - (select package_count from prime_items)*(select total_area from cte where item_type = 'prime_eligible') as remaining_area
from cte 
where item_type = 'not_prime'
)
select item_type,item_count
from prime_items
union
select 
      item_type,
      floor(remaining_area/(select total_area from cte where item_type = 'not_prime'))*(select article_count from cte where item_type = 'not_prime') as item_count
from non_prime
order by item_type desc
;