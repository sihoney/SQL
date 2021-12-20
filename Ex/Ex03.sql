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