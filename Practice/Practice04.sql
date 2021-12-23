--01.
select count(salary)
from employees
where salary < (select avg(salary)
                from employees);
 
--02.
select employee_id, first_name, salary, (select avg(salary) from employees), (select max(salary) from employees)
from employees
where salary >= (select avg(salary) from employees)
and salary <= (select max(salary) from employees)
order by salary;

select  employee_id, first_name, salary, (select avg(salary) from employees) avg, (select max(salary) from employees) max
from employees
where salary >=all (select avg(salary) from employees)
and salary <=all (select max(salary) from employees)
order by salary;
                
--03.
select LOCATION_ID ,
    STREET_ADDRESS ,
    POSTAL_CODE ,
    CITY ,
    STATE_PROVINCE ,
    COUNTRY_ID 
from locations
where location_id = (select location_id 
                    from departments
                    where departments.department_id = (select department_id 
                                                        from employees
                                                        where first_name = 'Steven' 
                                                        and last_name = 'King')
                    );
                                                        

--04.
select employee_id, first_name, salary
from employees
where salary <any (select salary
                from employees
                where job_id = 'ST_MAN')
order by salary desc;

--05.
--조건절 비교
select employee_id, first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                from employees
                                group by department_id)
order by salary desc;

--테이블 조인 !!!!!!!!!!!!!!
select employee_id, first_name, em.salary, em.department_id
from employees em, (select department_id, max(salary) salary
                    from employees
                    group by department_id) ms
where em.department_id = ms.department_id
and em.salary = ms.salary;

--06.
select job_title, j.salary
from jobs, (select job_id, sum(salary) salary
            from employees
            group by job_id) j
where jobs.job_id = j.job_id
order by j.salary desc;

--07. 
select employee_id, first_name, e.salary
from employees e, (select department_id, avg(salary) salary
                from employees
                group by department_id) a
where e.department_id = a.department_id
and e.salary > a.salary;

--08.
select rn,
        employee_id,
        first_name,
        salary,
        hire_date
from(select rownum rn,
            employee_id,
            first_name,
            salary,
            hire_date
    from(select employee_id,
                first_name,
                salary,
                hire_date
        from employees
        order by hire_date)
    )
where rn between 11 and 15;
