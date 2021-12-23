/*************************************************/
drop sequence seq_author_id;
drop sequence seq_book_id;
drop table author;
drop table book;
delete from author;
delete from book;
/************** 실 습 ********************/

--book, author 테이블 만들기
create table author(
    author_id number(10),
    author_name varchar2(50),
    author_desc varchar2(50),
    primary key(author_id)
);

create table book (
    book_id number(10),
    title varchar2(50) not null,
    pubs varchar2(50),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id) 
    references author(author_id)
);

--시퀀스 생성
create sequence seq_book_id
increment by 1
start with 1;

create sequence seq_author_id
increment by 1
start with 1;

--데이터 넣기
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '김문열', '경북 양양');
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '박경리', '경상남도 통영');
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '유시민', '17대 국회의원');
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '김영하', '알쓸신잡');

insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);
insert into book (book_id, title, pubs, pub_date, author_id)
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);
insert into book (book_id, title, pubs, pub_date, author_id)
values(seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

select * from author;
select * from book;

--[예제] 다음과 같이 출력되도록
select book_id,
        title,
        pubs,
        to_char(pub_date, 'YYYY-MM-DD'),
        book.author_id,
        author_name,
        author_desc
from book, author
where book.author_id = author.author_id;
        
--[예제] 강풀의 author_desc 정보를 '서울특별시'로 변경해 보세요
update author
set author_desc = '서울특별시'
where author_name = '강풀';

--[예제] author 테이블에서 기안84 데이터를 삭제해 보세요 -> 삭제 안됨
delete from author
where author_name = '기안84';
/*
ORA-02292: integrity constraint (WEBDB.BOOK_FK) violated - child record found
*/

commit;