--문제01 
select employee_id, 
    first_name, 
    last_name, 
    department_name
from employees em, departments de
where em.department_id = de.department_id 
order by department_name, employee_id desc;

--문제02
select employee_id, 
    first_name, 
    salary, 
    department_name, 
    job_title, 
    job_title
from employees e, departments d, jobs
where e.department_id = d.department_id
and e.job_id = jobs.job_id
order by employee_id;

--문제02-2
select employee_id, 
    first_name, 
    salary, 
    department_name, 
    job_title, 
    job_title
from employees e, departments d, jobs
where e.department_id = d.department_id(+)
and e.job_id = jobs.job_id
order by employee_id;

--문제03
select d.location_id, 
    city, 
    department_name
from departments d, locations l
where d.location_id = l.location_id;

--문제03-2
select d.location_id, 
    city, 
    department_name
from departments d, locations l
where d.location_id(+) = l.location_id;

--문제04
select region_name, country_name
from regions, countries
where regions.region_id = countries.region_id;

--문제05 
select em.employee_id, 
    em.first_name, 
    em.hire_date, 
    ma.first_name, 
    ma.hire_date
from employees em, employees ma
where em.manager_id = ma.employee_id
and em.hire_date < ma.hire_date;

--문제06
select lo.country_id, 
    city, 
    lo.location_id, 
    department_name, 
    de.department_id
from locations lo, countries co, departments de
where lo.location_id = de.location_id
and co.country_id = lo.country_id
order by department_id;

--문제07
select e.employee_id, 
    first_name, 
    j.job_id, 
    start_date, 
    end_date
from employees e, job_history j
where e.employee_id = j.employee_id
and j.job_id = 'AC_ACCOUNT';

--문제08
select de.department_id,
    department_name, 
    first_name, 
    city,
    country_name,
    region_name
from departments de, employees ma, 
    locations lo, 
    countries co, 
    regions re
where de.manager_id = ma.employee_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
order by department_id;

--문제09 => 106
select em.employee_id, 
    em.first_name, 
    de.department_name, 
    ma.first_name
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);