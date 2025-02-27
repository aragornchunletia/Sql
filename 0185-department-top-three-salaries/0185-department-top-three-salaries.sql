# Write your MySQL query statement below
/*
wt first find the top of all depatmnets
then join the above table to the department name 
serve the reusltant table
*/

with cte as (
    select 
        e.name as Employee,
        e.salary,
        e.departmentId,
        dense_rank() over(partition by e.departmentId order by e.salary desc) as rnk,
        d.name as Department
    from Employee e
    join Department d  on d.id = e.departmentId
)
select Department , Employee , salary  from cte 
where cte.rnk < 4;

