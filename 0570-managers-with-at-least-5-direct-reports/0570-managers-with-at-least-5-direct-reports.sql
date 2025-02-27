# Write your MySQL query statement below
/*with manager_count as (
    select managerId , count(managerId) as team_size
    from employee
    group by managerId
)
select employee.name 
from employee
join manager_count 
on employee.id = manager_count.managerId
where team_size > 4
;
*/

select e1.name 
from employee e1
join (
    select managerId, count(*) as team_size
    from employee e
    group by e.managerId
    having count(*) > 4
) e2
on e1.id = e2.managerId
; 

