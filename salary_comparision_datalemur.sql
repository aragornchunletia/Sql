with overall_avg as (
SELECT 
    ROUND(AVG(amount), 2) AS mean_salary,
    TO_CHAR(payment_date, 'MM-YYYY') AS payment_date
FROM salary
WHERE EXTRACT(YEAR FROM payment_date) = 2024 
AND EXTRACT(MONTH FROM payment_date) = 3
GROUP BY payment_date
),
dept_avg as (
select 
      e.department_id,
      round(avg(s.amount),2) as dept_mean,
      ovg.mean_salary as overall_avg,
      ovg.payment_date as payment_date
from salary s
inner join employee e on e.employee_id = s.employee_id
cross join overall_avg as ovg
where EXTRACT(year FROM s.payment_date) = 2024 and EXTRACT (MONTH FROM s.payment_date) = 3
group by e.department_id,ovg.mean_salary,ovg.payment_date
)
select 
      department_id,
      payment_date,
      CASE
          when dept_mean < overall_avg then 'lower'
          when dept_mean > overall_avg then 'higher'
          else 'same'
      END
from dept_avg
;