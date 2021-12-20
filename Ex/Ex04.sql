/***********
join
************/
select first_name, department_name
from employees, departments;
/*
두 테이블의 행들의 가능한 모든 쌍이 추출
일반적으로 사용자가 원하는 결과 아님
*/

--equi join
/*양쪽 다 만족하는 경우만 조인
null은 조인안됨*/
select 
    em.first_name, 
    em.department_id,
    de.department_name, 
    de.department_id
from employees em, departments de
where em.department_id = de.department_id;

--outer join
/*join 조건을 만족하지 않는 컬럼이 없는 경우 null를 포함하여 결과를 생성
모든 행이 결과 테이블에 참여
null이 올 수 있는 쪽 조건에 +를 붙인다.*/

--left outer join
/*왼쪽 테이블의 모든 row를 결과 테이블에 나타냄*/

--(1) left outer join & on
select e.department_id, 
    e.first_name, 
    d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

--(2) + 사용
select e.department_id, 
    e.first_name, 
    d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); 

--right outer join

--(1) right outer join & on
select e.department_id,
    e.first_name,
    d.department_id
from employees e right outer join departments d
on e.department_id = d.department_id;

--(2) + 사용
select e.department_id,
    e.first_name,
    d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--full outer join
select e.department_id, e.first_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--self join
select emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name as manager
from employees emp, employees man
where emp.manager_id = man.employee_id;

/************
chapter04 - subquery, rownum
*************/
select first_name,
    salary
from employees
where salary > (select salary 
                from employees 
                where first_name = 'Den');
                
/***단일행 subQuery***/
--subquery의 결과가 한 row인 경우
select first_name,
    salary
from employees
where salary < (select avg(salary) from employees);

--[예제] 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
select first_name,
    salary,
    employee_id
from employees
where salary = (select min(salary) from employees);

--[예제] 평균 급여보다 적게 받는 사람의 이름, 급여를 출력
select first_name, salary 
from employees
where salary < (select avg(salary) from employees);

/***다중행 subQuery***/
--subquery의 결과가 여러 row인 경우
select employee_id, first_name, salary 
from employees
where salary IN (select salary 
                from employees
                where department_id = 110); 
                
--[예제] 각 부서별로 최고 급여를 받는 사람을 출력
select first_name, salary, department_id 
from employees
where (salary, department_id) IN (select max(salary), department_id
                from employees
                group by department_id);
/*다중행 in은 동시에 여러가지 값을 비교할 수 있다.
단 형태가 같아야 한다.*/

--[ ANY(or) ] 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여 출력
select employee_id, first_name, salary
from employees
where salary >any (select salary 
                    from employees
                    where department_id = 110);
                    
--[ ALL(and) ]
select first_name, salary
from employees
where salary > ALL(select salary 
                    from employees
                    where department_id = 110);

--조건절에서 비교 vs 테이블에서 조인 (각 부서별로 최고 급여를 받는 사원을 출력)

--[조건절에서 비교] 각 부서별로 최고 급여를 받는 사원을 출력
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                            from employees
                            group by department_id);
                            
--[테이블에서 조인]
select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary
                    from employees
                    group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;