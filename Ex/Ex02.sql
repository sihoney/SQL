--chapter03. 그룹함수 join
--01. 그룹함수
select avg(salary) from employees;

--count() : 함수에 입력되는 데이터의 총 건수를 반환
select count(*), count(commission_pct) from employees;
/*
* --> null 포함
속성명 --> null제외
*/

select * from employees where salary > 16000;

--sum() : 입력된 데이터의 합계 값을 반환
select count(*), sum(salary) from employees;

--avg() : 평균값을 반환 
--(주의: null값이 있는 경우 빼고 계산, nvl 함수와 같이 사용)
select count(*), sum(salary), avg(salary) from employees;

select count(*), sum(salary), avg(nvl(salary, 0)) from employees;

--max() / min() : 큰 값/작은 값 반환
/*
여러 건의 데이터를 순서대로 정렬 후 값을 구하기 때문에 데이터가 많을 때는 느림
( 주의해서 사용 )
*/
select count(*), max(salary), min(salary) from employees;

--02. GROUP BY 절
select department_id, salary from employees order by department_id asc;

-- => 그룹으로 묶어주고 salary 평균값 구하기

select department_id, avg(salary) from employees 
group by department_id
order by department_id asc;

--자주하는 오류 => "group by에 참여한 컬럼"이나 "그룹함수"만 올 수 있음
select department_id, count(*), sum(salary) 
from employees
group by department_id
order by department_id asc;

--[예제] 연봉 합계가 20000 이상인 부서의 부서 번호, 인원수, 급여합계를 출력
select department_id, sum(department_id), sum(salary)
from employees
where sum(salary) > 20000
group by department_id;
--오류: where 절에는 그룹함수를 쓸 수 없다.

--03. HAVING 절
--having 절에는 그룹합수와 group by에 참여한 컬럼만 사용 가능
select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;

select department_id,count(*), sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100;

--04. CASE ~ END 문/DECODE() 함수
--case ~ end 문
select employee_id, salary,
    case when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
        when job_id = 'SA_REP' then salary + salary * 0.2
        when job_id = 'ST_CLERK' then salary + salary * 0.3
        else salary
    end realSalary
from employees;

--decode 문(case ~ end 비교)
/*
DECODE 함수는 
*/
select employee_id, salary,
decode( job_id, 'AC_ACCOUNT', salary + salary * 01,
                'SA_REP', salary + salary * 0.2,
                'ST_CLERT', salary + salary * 0.3,
        salary) realSalary
from employees;

--decode 문
select employee_id, salary 
decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1, salary) readSalary
from employees;

select employee_id, salary, 
decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                'SA_REP', SALARY + SALARY * 0.2,
                'ST_CLERK', SALARY + SALARY * 0.3,
                SALARY) realSalary
FROM EMPLOYEES;

--[예제]
SELECT FIRST_NAME, JOB_ID,
    CASE WHEN DEPARTMENT_ID BETWEEN 10 AND 50 THEN 'A-TEAM'
        WHEN DEPARTMENT_ID BETWEEN 60 AND 100 THEN 'B-TEAM'
        WHEN DEPARTMENT_ID BETWEEN 110 AND 150 THEN 'C-TEAM'
        ELSE '팀없음' 
    END TEAM
FROM EMPLOYEES;

--05. JOIN ~ ON
--올바른 JOIN 조건을 WHERE 절에 부여 해야 함

--EQUI JOIN : 양쪽 다 만족하는 경우만 조인됨(=>NULL은 제외됨)
SELECT FIRST_NAME, EM.DEPARTMENT_ID,
        DEPARTMENT_NAME, DE.DEPARTMENT_ID
FROM EMPLOYEES EM, DEPARTMENTS DE
WHERE EM.DEPARTMENT_ID = DE.DEPARTMENT_ID;

--[예제] 모든 직원이름, 부서이름, 업무명을 출력하세요
SELECT FIRST_NAME, DEPARTMENT_NAME, JOB_TITLE
FROM EMPLOYEES EM, DEPARTMENTS DE, JOBS
WHERE EM.DEPARTMENT_ID = DE.DEPARTMENT_ID AND EM.JOB_ID = JOBS.JOB_ID;

--OUTER JOIN
/*
JOIN 조건을 만족하는 컬럼이 없는 경우 NULL를 포함하여 결과를 생성
"모든 행이 결과 테이블에 참여"
NULL이 올 수 있는 쪽 조건에 +를 붙인다.

<종류>
LEFT OUTER JOIN: 왼쪽의 모든 튜플은 결과 테이블에 나타남
RIGHT OUTER JOIN: 오른쪽의 모든 튜플은 결과 테이블에 나타남
FULL OUTER JOIN: 양쪽 모두 결과 테이블에 참여
*/

--LEFT OUTER  JOIN : 왼쪽 테이블의 모든 ROW를 결과 테이블에 나타냄
SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

--RIGHT OUTER JOIN : 오른쪽 테이블의 모든 ROW를 결과 테이블에 나타냄
SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID; 

--FULL OUTER JOIN
SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
/*
SELECT E.DEPARTMENT_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
*/

--SELF JOIN
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.MANAGER_ID, MAN.FIRST_NAME AS MANAGER
FROM EMPLOYEES EMP, EMPLOYEES MAN
WHERE EMP.MANAGER_ID = MAN.EMPLOYEE_ID;