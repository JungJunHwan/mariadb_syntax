-- mariadb 서버에 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스키마 생성
create database board;

-- 스키마 삭제
drop database board;

-- 데이터베이스 선택
use board;

-- 테이블 목록 조회
show tables;

-- 문자 인코딩 조회
show variables like 'character_set_server';

-- 문자 인코딩 변경
alter database board default character set = utf8mb4;

-- 테이블 생성
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author;

-- 테이블 컬럼 상세 조회
show full columns from author;

-- 테이블 생성 명령문 조회
show create table author;

-- post 테이블 신규 생성 (id, title, content, author_id) : 중요
create table post(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, foreign key(author_id) references author(id));

-- 테이블 index(성능향상 옵션) 조회
show index from author;

-- alter문 : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table post rename posts;
-- 테이블 컬럼 추가 : 중요
alter table author add column age int;
-- 테이블 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);
-- 테이블 컬럼 타입과 제약조건 변경 -> 덮어쓰기 됨에 주의 : 중요
alter table author modify column email varchar(100) not null;

-- 실습 : author 테이블에 address 컬럼추가. varchar(255)
alter table author add column address varchar(255);
-- 실습 : post 테이블에 title은 not null로 변경, contents 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
show create table post;
drop table post;