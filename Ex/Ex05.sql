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

/**************
chapter04 - 1. SubQuery
***************/

--주의사항
--1. where절의 연산자 오른쪽에 위치, 괄호로 묶어야 함
--2. 가급적 order by를 하지 않는다.
--3. 단일행 subquery오 다중행 subquery 구분하여 연산자 사용!

--subQuery: subQuery의 결과가 여러 row인 경우
--연산자: ANY, ALL, IN...

--[ 다중행 SUBQUERY - IN ] 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력
select employee_id, first_name, salary
from employees
where salary in (select salary
                from employees
                where department_id = 110);
                
--[예제] 각 부서별로 최고 급여를 받는 직원을 출력하시오
select department_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                from employees
                group by department_id);
                
--[예제] 연봉이 2100, 3100, 4100, 5100인 사원의 이름과 연봉을 구하시오
select first_name, salary
from employees
where salary in (2100, 3100, 4100, 5100);
                
select department_id, max(salary)
from employees
group by department_id;
-->다중행 in은 동시에 여러가지 값을 비교할 수 있다. 단 형태가 같아야 한다.

--[ 다중행 - ANY ] 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요
select employee_id, first_name, salary
from employees
where salary >any (select salary
                from employees
                where department_id = 110);

select salary
from employees
where department_id = 110;

--[ 다중행 - ALL ]
select employee_id, first_name, salary
from employees
where salary >ALL (select salary
                    from employees
                    where department_id = 110);
                
--[subQuery - 테이블에서 조인] 각 부서별로 최고 급여를 받는 사원을 출력하세요.
select e.department_id, 
    e.employee_id, 
    e.first_name, 
    e.salary
from employees e, (select department_id, max(salary) salary
                    from employees
                    group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;

--[subQuery -조건절에서 비교] 각 부서별로 최고 급여를 받는 사원을 출력하세요.
select department_id,
    employee_id,
    first_name,
    salary
from employees 
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id);


/*************
chapter04 - 2. rownum
**************/
--질의 결과에 가상으로 부여되는 oracle의 가상의 column(일렬 번호)

--[예제] 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오
select rownum,
    first_name,
    salary
from employees
order by salary desc;
-->예외: 정렬시 rownum이 섞인다.

select rownum,
    first_name,
    salary
from (select first_name,
            salary
        from employees
        order by salary desc);
--> 섞이지 않은 rownum

select rownum,
    first_name,
    salary
from (select first_name,
            salary
        from employees
        order by salary desc)
where rownum >= 5;
--오류: 출력 0, '테이블로부터 한 row을 읽을 때' 항상 rownum = 1 로 생성
-- select절을 이용하여 projection 할 때, rownum 선택이 진행

select rn,
    first_name,
    salary
from (select rownum rn,  --rownum 생성(조건절 해결)
            first_name,
            salary
        from (select first_name,
                    salary
            from employees
            order by salary desc)  --정렬시킨다(order 해결)
    )
where rn >= 11
and rn <= 20;  --rownum 생성후에 where절 실행

--[예제] 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름, 급여, 입사일은?
select rn,
        first_name,
        salary,
        hire_date
from (select rownum rn, 
            first_name, 
            salary,
            hire_date
        from (select first_name,
                    salary,
                    hire_date
                from employees
                order by salary desc)
        )
where rn >= 3 and rn <= 7;
--rownum 생성과 order by 사용은 같은 문에서 안됨
--rownum 생성과 where 조건절 사용도 같은 문에서 안됨
--> rownum를 생성할 경우, 1로 초기화하고 마지막 select projection 단계에서 숫자를 부여하기 때문!