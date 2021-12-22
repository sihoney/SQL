/**********************
chapter04 - 2. rownum
***********************/

--[예제] 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--(1) rownum은 테이블 row을 읽을 때 생성돼서 
--마지막 select projection 때 값이 선택되어진다.
select rownum,
    first_name,
    salary
from employees;

--(2)
--정렬시 rownum이 섞이는 것을 볼 수 있다!
select rownum,
    first_name,
    salary
from employees
order by salary desc;

--(3)
--rownum + 이름, 연봉를 정렬한 테이블
select rownum,
    first_name,
    salary
from (
    select first_name,
            salary
    from employees
    order by salary desc
    );
    
--(4) 
--오류: rownum이 생성될 때는 항상 rownum = 1 값이 부여된다!
--모든 rownum이 1일 때 where 조건을 검사하므로 모든 검사가 false!
select rownum,
        first_name,
        salary
from (select first_name,
            salary
        from employees
        order by salary desc)
where rownum >= 5;

--(5) 정답!

--해결해야할 문제
-->> rownum은 where절 통과 후에(마지막에) 값이 부여된다!
---->>그래서 "정렬(order by)"와 "where조건절" 사용이 어려움!

select rn,
        first_name,
        salary
from (select rownum rn,  --rownum 생성(조건절 해결)
            first_name,
            salary
        from (select first_name, --정렬(order 해결)
                    salary
                from employees
                order by salary desc)
        )
where rn >= 11 
and rn <= 20;  --rownum 생성 후에 where절 실행

select rn,
        first_name,
        salary
from(select rownum rn,
        first_name,
        salary
    from (select first_name,
                salary
            from employees
            order by salary desc)
    )
where rn >= 11
and rn <= 20;

--[예제] 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름 급여 입사일은?
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
            where hire_date between '07/01/01' and '07/12/31')
        )
where rn between 3 and 7;

--[예제] 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름 급여 입사일 + 부서명은?
select rn,
        first_name,
        salary, 
        hire_date,
        department_name
from(select rownum rn,
        first_name,
        salary,
        hire_date,
        department_name
    from(select first_name,
                salary,
                hire_date,
                department_name
        from employees em, departments de
        where em.department_id =de.department_id
        and hire_date between '07/01/01' and '07/12/31'
        order by salary desc
        )
    )
where rn between 3 and 7;
