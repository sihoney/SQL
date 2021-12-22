/************************
chapter05 - DCL, DDL, DML
*************************/

/**************************** 
01. DCL - "계정관리" 
Data Control Language, 데이터 제어어 -> User 관리

>>sys 계정
- 수퍼 사용자
- 모든 문제를 처리할 수 있는 권한

>>system 계정
- 데이터베이스를 유지보수 관리할 때 사용
- 계정 관리(생성, 삭제, 비번 권한 등)

>>주의
- 일반적으로 DBA의 일
- 사용자를 생성하려면 CREATE USER 권한 필요
- 생성된 사용자가 LOGIN하려면 CREATE SESSION 권한 필요
- 일반적으로 CONNECT, RESOURCE의 ROLE을 부여하면 일반 사용자 역할을 할 수 있음

>>role: 하나 이상의 권한으로 이루어진 집합
    >>resource: 기본적인 객체를 drop, alter, create 
                컬럼을 insert, update, delete 할 수 있는 권한을 모아놓은
                 role
    >>connect: oracle에 접속할 수 있는 권한 role
    
>> user password을 잊어버렸을 경우
cmd --> 서버컴퓨터의 경우, sqlplus 프로그램 실행 --> splplue --> sys as sysdba (관리자 모드 접속)
--> grant create user to 
******************************/


/******************************
system 계정으로 user 설정
*******************************/

-- 계정 생성
create user webdb identified by 1234;

--접속 권한 부여
grant resource, connect to webdb;
/* 권한을 부여해야지 접속할 수 있다*/

--계정 비밀번호 변경
alter user webdb identified by webdb;

--계정 삭제
drop user webdb cascade;
