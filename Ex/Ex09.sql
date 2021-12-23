/******************************
chpaterDDL 05  
2. DDL - 테이블 관리

DDL : Data Definition Language 
*******************************/

create table book(
    book_id number(5),
    title varchar2(50),
    author varchar2(10),
    pub_date date
);

/*
< 오라클 자료형 >
char(size) : 고정길이 문자열
varchar2(size) : 가변길이 문자열
number(p, s) : 숫자 데이터 / p(전체자리수), s(수소점 이하 자리수)
                자리수 지정없으면 number(38)
date : 날짜 + 시간
nchar(size) : national character set에 따라 결정되는 size만큼의 고정길이
            character data로 최대 2000byte까지 가능, 디폴트는 1 character           
*/

--컬럼 추가/수정/삭제
alter table book add (pubs varchar2(50));

alter table book modify(title varchar2(100));
alter table book rename column title to subject;

alter table book drop (author);

--테이블 명 수정/삭제/truncate 명령(테이블의 모든 로우를 제거)
rename book to article;

drop table article;

truncate table article; 
    
--제약조건
/*
not null : null값 입력 불가

unique : 중복값 입력 불가(null값은 허용)

primary key : not null + unique, 즉, 데이터들끼리의 유일성을 보장하는 컬럼
            에 설정, 테이블 당 1개만 설정 가능(여러 개를 묶어서 설정 가능)
            
foreign key : 외래 키,
                일반적으로 reference 테이블의 pk를 참조
                reference 테이블에 없는 값은 삽입 불가   
                reference 테이블의 레코드 삭제 시 동작
                - on delete cascade: 해당하는 fk를 가진 참조형도 삭제
                - on delete set null: 해당하는 fk를 null로 바꿈
*/

--author 테이블 만들기
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);

--book 테이블 만들기
create table book (
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    
    primary key(book_id),
    constraint book_fk foreign key(author_id) references author(author_id)
);

/******************************
3. DML - INSERT/UPDATE/DELETE

DML: Data Manipulation Language
*******************************/

--DML - INSERT
insert into author
values(1, '박경리', '토지 작가');

insert into author(author_id, author_name)
values(2, '이문열');

--DML - UPDATE
--(1) 조건을 만족하는 레코드 변경
update author
set author_name = '기안84',
    author_desc = '웹툰작가'
where author_id = 1;

--(2) where절이 생략되면 모든 레코드에 적용(주의!)
update author
set author_name = '강풀',
    author_desc = '인기작가';
    
--DML - DELETE
--(1)
delete from author
where author_id = 1;

--(2) 조건이 없으면 모든 데이터 삭제(주의!)
delete from author;

--(3) truncate 명령: 테이블의 모든 로우를 제거
truncate table article;

/***************************
4. SEQUENCE / SYSDATE
****************************/
--sequence : 연속적인 일렬번호 생성 -> pk에 주로 사용됨

--시퀸스 생성
create sequence seq_author_id
increment by 1
start with 1;

--시퀀스 사용
insert into author
values(seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values(seq_author_id.nextval, '기안84', '웹툰작가');

select * from book;
select * from author;

--시퀀스 조회
select * from user_sequences;

--현재 시퀀스 조회
select seq_author_id.currval from dual;

--다음 시퀀스 조회
select seq_author_id.nextval from dual;

--시퀀스 삭제
drop sequence seq_author_id;

--SYSDATE: 현재 시간이 입력이 됨

