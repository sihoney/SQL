--CHAPTER 02. 기본 SELECT문과 단일행 함수
--01. SELECT / FROM
select * from employees;

select first_name, phone_number, hire_date, salary 
from employees;

select first_name, last_name, salary, phone_number, email, hire_date
from employees;

----출력할 때 별명 사용하기
-- as 생략 가능
select first_name as 이름, phone_number as 전화번호, hire_date as 입사일, salary as 급여
from employees;

select employee_id as 사원번호,
    first_name as 이름,
    last_name as 성,
    salary as 급여,
    phone_number as 전화번호,
    email as 이메일,
    hire_date as 입사일
from employees;

SELECT EMPLOYEE_ID AS "empNo",
    first_name as "f-name",
    salary as "연 봉"
from employees;

----연결 연산자
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES;

SELECT FIRST_NAME || LAST_NAME FROM EMPLOYEES;

SELECT FIRST_NAME || ' ' || LAST_NAME FROM EMPLOYEES;

SELECT FIRST_NAME || ' HIRE DATE IS ' || HIRE_DATE FROM EMPLOYEES;

---- 산술 연산자
SELECT FIRST_NAME, SALARY FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, SALARY * 1.2 FROM EMPLOYEES;

SELECT JOB_ID*12 FROM EMPLOYEES;
/*
*Cause:    The specified number was invalid.
JOB_ID는 문자
*/

---- 예제 
SELECT FIRST_NAME || '-' || LAST_NAME AS 성명,
    SALARY AS 급여,
    SALARY * 12 AS 연봉,
    SALARY * 12 + 5000 AS 연봉2,
    PHONE_NUMBER AS 전화번호
FROM EMPLOYEES;

--02. WHERE절
---- 비교 연산자
SELECT FIRST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID = 10;

SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY >= 15000;

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE > '07/01/01';

select * from employees where first_name = 'Lex';

---- 조건이 2개 이상일 때
select first_name, salary from employees where salary >= 14000
and salary <= 17000;

select first_name, salary from employees where salary <= 14000 or salary <= 17000;

select first_name, hire_date from employees where hire_date>= '04/01/01' and hire_date <='05/12/31';

---- between 연산자
-- 느린 연산자에 속함
select first_name, salary from employees where salary between 14000 and 17000;

---- IN 연산자
select first_name, last_name, salary from employees where first_name IN ('Neena', 'Lex', 'John');

select first_name, salary  from employees 
where salary IN (2100, 4100, 5100);

---- LIKE 연산자
-- % : 임의의 길이의 문자열(공백문자 가능)
-- _ : 한 글자 길이
select first_name, last_name, salary from employees where first_name like 'L%';

select first_name, salary from employees where first_name like '%am%';

select first_name, salary from employees where first_name like '_a%';

select first_name from employees where first_name like '__a_';

---- NULL
--null을 포함한 산술식은 null
select first_name, salary, commission_pct, salary*commission_pct from employees 
where salary between 13000 and 15000;

---- is null/is not null
select first_name, salary, commission_pct from employees
where commission_pct is null; 

select first_name, commission_pct from employees 
where commission_pct is not null;

select first_name, manager_id, commission_pct from employees where manager_id is null and commission_pct is null;

--03. ORDER BY 절
--기본값 오름차순, 정렬조건이 복수일때는 ,로 구분
select first_name, salary from employees order by salary desc;
select first_name, salary from employees where salary >= 9000 order by salary desc;

--[예제]
select department_id, salary, first_name from employees order by department_id;

select first_name, salary from employees where salary >= 10000 order by salary desc;

select department_id, salary, first_name from employees order by department_id, salary desc;

select * from employees where salary = 2500 order by salary asc, first_name asc ;

--04. 단일행 함수
--문자함수의 종류
--CONCAT(s1, s2)
select CONCAT(first_name, last_name), salary from employees where salary > 10000 order by salary;
select concat(first_name, ' 님 환영') from employees where salary > 13000;

--INITCAP(s) : 첫글자만 대문자로 변경
select initcap(concat('precious ', first_name)) "initcap-test", salary from employees where salary > 10000;

--LOWER(s) : 소문자로 변경
SELECT LOWER(FIRST_NAME || ' ' || LAST_NAME) FROM EMPLOYEES;

--UPPER(s) : 대문자로 변경
SELECT UPPER(FIRST_NAME || ' ' || LAST_NAME) FROM EMPLOYEES;

--LPAD(컬럼명, 자리수, 채울문자) : 문자열의 왼쪽 채움(길이: N, 채움문자: S2)
SELECT FIRST_NAME, LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '*') FROM EMPLOYEES;

--SUBSTR(컬럼명, 시작위치, 글자수)
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 3), SUBSTR(FIRST_NAME, -3, 2) FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100;

--REPLACE(컬럼명, 문자1, 문자2)
-- : 컬럼명에서 문자1을 문자2로 바꾸는 함수
SELECT FIRST_NAME, REPLACE(FIRST_NAME, 'a', '*') FROM EMPLOYEES WHERE DEPARTMENT_ID =100;

select first_name, 
    replace(first_name, 'a', '*'),
    replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;

--LTRIM(S, C)/RTRIM(S, C) : 문자열 왼쪽/오른쪽 C 문자열 제거
select ltrim(concat('precious employee ', first_name), 'precious') "initcap-test", salary from employees where salary > 10000;

--CHR(N) / ASCII(S) : ASCII값이 N인 문자 반환 / ASCII 값 반환
SELECT FIRST_NAME, CHR(ASCII(FIRST_NAME)) FROM EMPLOYEES WHERE SALARY > 10000; 

--TRANSLATE(S, FROM, TO) : S에서 FROM 문자열의 각 문자를 TO문자열의 각 문자로 변환

--INSTR(S1, S2, M, N) : 문자열 검색, S1의 M번째부터 S2 문자열이 나타나는 N번째 위치 반환

--LENGTH(S) : 문자열 길이 반환
select first_name, length(first_name) "first name's length" from employees where salary < 5000;

-- 숫자함수
--ROUND(숫자, 출력을 원하는 자리수) : 주어진 숫자의 반올림을 하는 함수
select round(132.456, 4) "r4",
        round(123.456, 3) "r3",
        round(123.456, 2) "r2", 
        round(123.456, 0) "r0", 
        round(123.456, -1) "r-1",
        round(123.456, -2) "r-2",
        round(123.456, -3) "r-3"
from dual;

--abs(n) : 절대값
select abs(-1000) from dual; 

--mod(m, n) : 나머지
select mod(10, 3) from dual;

--trunc(m, n) : 소수점 아래 n자리 미만 버림
select trunc(4.567, 2) from dual;

--sign(n) : 부호 (1, 0, -1)
select sign(-10) from dual;

--날짜 함수
-- SYSDATE() : 현재 날짜와 시간을 출력해주는 함수
select sysdate from dual;
select sysdate from employees;

--MONTH.BETWEEN(D1, D2) : D1날짜와 D2날짜의 개월수를 출력하는 함수
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 110;

--변환함수
--TO_CHAR(숫자, '출력모양') : 숫자형 -> 문자형으로 변환
SELECT TO_CHAR(9876, '99999') FROM DUAL;

SELECT TO_CHAR(9876, '099999') FROM DUAL;

SELECT TO_CHAR(9876, '$99999') FROM DUAL;

SELECT TO_CHAR(9876, '9999.99') FROM DUAL;

SELECT FIRST_NAME, TO_CHAR(SALARY * 12, '999,999.99') "SAL"
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 110;

--TO_CHAR(날짜, '출력모양') : 날짜 -> 문자형으로 변환
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--일반함수 > NVL(컬럼명, NULL일때 값) / NVL2(컬럼명, NULL이아닐때 값, NULL일 때 값)
/*
NVL(조사할 컬럼, NULL일 경우 치환할 값)
NVL2(조사할 컬럼, NULL이 아닐 때 치환할 값, NULL일때 치환할 값)
*/
SELECT COMMISSION_PCT, NVL(COMMISSION_PCT, 0) FROM EMPLOYEES;

SELECT COMMISSION_PCT, NVL2(COMMISSION_PCT, 100, 0) FROM EMPLOYEES;

SELECT COMMISSION_PCT, NVL(COMMISSION_PCT, 0.7) FROM EMPLOYEES;