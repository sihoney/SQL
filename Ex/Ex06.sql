/**********************
chapter03 - subQuery 
***********************/

--[예제] 각 부서별로 최고 급여를 받는 사원을 출력
select department_id, 
    first_name,
    salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                from employees
                                group by department_id);
                                
select department_id, 
    first_name,
    salary
from employees
where salary in (select max(salary)
                from employees
                group by department_id);
                
/*                                
select department_id, max(salary)
from employees
group by department_id;
*/

select department_id,
    first_name,
    salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                from employees
                                group by department_id);
                                
--[예제] any
select employee_id, first_name, salary
from employees
where salary >any (select salary 
                    from employees
                    where employee_id = 110);
                    
--[예제] all
select employee_id, first_name, salary
from employees
where salary >all (select salary 
                    from employees
                    where employee_id = 110);
      
--01. 각 부서별 최고 연봉 출력              
select department_id,
        max(salary)
from employees
group by department_id;

select * 
from employees emp, (select department_id,
                    max(salary) salary
                    from employees
                    group by department_id) ms
where emp.department_id =ms.department_id
and emp.salary = ms.salary;
