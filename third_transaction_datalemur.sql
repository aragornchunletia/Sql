/*
Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

transactions Table:
Column Name	->Type
user_id	->integer
spend	->decimal
transaction_date ->timestamp
*/

/*
Solution for the above question
*/

with cte as (
select user_id , spend , transaction_date,
       row_number() over (partition by user_id order by transaction_date) as row_num
from transactions
)
SELECT user_id , spend , transaction_date
FROM cte
where row_num = 3;