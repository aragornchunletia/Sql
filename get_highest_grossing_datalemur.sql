/*
Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

product_spend Table:
Column Name	Type
category	string
product	string
user_id	integer
spend	decimal
transaction_date	timestamp
*/

/*
total spend for each product in the category
rank the total by category
filter by YEAR
group by category and product
get results with rank <= 2
*/

with cte as (
select  
      category , 
      product ,
      sum(spend) as total_spend,
      dense_rank() over(PARTITION BY category ORDER by sum(spend) desc) as rnk
from product_spend
where EXTRACT(year from transaction_date) = 2022
group by category , product
)
select  
      category,
      product,
      total_spend
from cte
where rnk <= 2
;