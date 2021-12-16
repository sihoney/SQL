--01.
select first_name || ' ' || last_name 이름, salary 월급, phone_number 전화번호, hire_date 입사일 
from employees
order by hire_date; 

--02.
select job_title, max_salary
from jobs
order by max_salary desc;

--03.
select first_name, manager_id, commission_pct, salary
from employees
where manager_id is not null and
commission_pct is null and
salary > 3000;

--04.
select job_title, max_salary 
from jobs
where max_salary >= 10000 
order by max_salary desc;

--05.
select first_name, salary, nvl(commission_pct, 0)
from employees
where salary between 10000 and 14000 
order by salary desc;

--06.
select first_name, salary, to_char(hire_date, 'YYYY-MM'), department_id
from employees
where department_id in (10, 90, 100);

--07.
select first_name, salary
from employees
where first_name like '%S%' or first_name like '%s%';

--08.
select * from departments
order by length(department_name) desc;

--09.
select upper(country_name) from countries order by country_name;

--10.
select first_name, salary, replace(phone_number, '.', '-'), hire_date
from employees
where hire_date < '03/12/31';