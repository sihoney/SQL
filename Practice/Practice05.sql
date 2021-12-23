--문제01. 
select first_name,
    manager_id,
    commission_pct,
    salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

--문제02.
select employee_id, 
        first_name, 
        salary, 
        to_char(hire_date, 'YYYY-MM-DD day'), 
        replace(phone_number, '.', '-'), 
        department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
order by salary desc;

--문제03.
select ms.manager_id,
        em.first_name,
        avgSal,
        maxSal,
        minSal
from employees em, (select manager_id, 
                        round(avg(salary), 2) avgSal,
                        max(salary) maxSal,
                        min(salary) minSal
                from employees
                where hire_date >= '2005/01/01'
                having avg(salary) >= 5000
                group by manager_id) ms
where em.employee_id = ms.manager_id;

--문제04.
select em.employee_id,
        em.first_name,
        de.department_name,
        ma.first_name
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);

--05.
select rn,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from(select rownum rn,
            employee_id,
            first_name,
            department_name,
            salary,
            hire_date
    from employees em, departments de
    where em.department_id = de.department_id
    and hire_date >= '2005/01/01')
where rn between 11 and 20;

--06.
select first_name || ' ' || last_name as name,
        salary,
        department_name
from employees em, departments de
where em.hire_date = (select max(hire_date) from employees)
and em.department_id = de.department_id;

--07.
select employee_id 사번,
        first_name 이름,
        last_name 성,
        job_title,
        salary 급여,
        (select max(avg_Sal)
        from (select avg(salary) avg_Sal
            from employees
            group by department_id
            )
        ) AVG_SALARY
from employees em, jobs jo
where department_id = (select department_id
                        from(select rownum rn,
                                    department_id,
                                    avgSal
                            from(select department_id, avg(salary) avgSal
                                from employees
                                group by department_id
                                order by avgSal desc)
                            )
                        where rn = 1
                        )
and em.job_id = jo.job_id;
                        
--08. 평균 급여가 가장 높은 부서는?
(select department_id
from(select rownum rn,
            department_id,
            avgSal
    from(select department_id, avg(salary) avgSal
        from employees
        group by department_id
        order by avgSal desc)
    )
where rn = 1
)
--09. 평균 급여가 가장 높은 지역은?
select region_name
from regions
where region_id = (select region_id
                    from(select rownum rn,
                                region_id
                        from(select avg(salary) avgSal, re.region_id
                            from employees em, departments de, locations lo, countries co, regions re
                            where em.department_id = de.department_id
                            and de.location_id = lo.location_id
                            and lo.country_id = co.country_id
                            and co.region_id = re.region_id
                            group by re.region_id
                            order by avgSal desc)
                        )
                    where rn = 1
                    );

--10. 평균 급여가 가장 높은 업무는?
select job_title
from jobs
where job_id = (select job_id
    from(select rownum rn,
                job_id,
                avgSal
        from(select jo.job_id, avg(salary) avgSal
            from jobs jo, employees em
            where jo.job_id = em.job_id
            group by jo.job_id
            order by avgSal desc)
        )
    where rn = 1
    );

