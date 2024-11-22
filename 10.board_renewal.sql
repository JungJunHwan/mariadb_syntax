-- 여러 사용자가 사용자가 1개의 글을 수정할 수 있다 가정 후 DB 리뉴얼
-- author와 post가 m:n 관계가 되어 관계 테이블을 별도록 생성
-- 스키마 생성
create database board;
use board;

-- author 테이블 생성
create table author(id BIGINT primary key auto_increment, email varchar(255) not null unique
, password varchar(255) not null, name varchar(255), created_time datetime not null default current_timestamp());

-- author_address 테이블 생성 (1:1 관계)
create table author_address(id BIGINT primary key auto_increment, author_id bigint not null, country varchar(255), city varchar(255), street varchar(255), 
created_time datetime not null default current_timestamp(), foreign key(author_id) references author(id));
 
-- post 테이블 생성
create table post(id BIGINT primary key auto_increment, title varchar(255) not null
, contents varchar(255), created_time datetime not null default current_timestamp());

-- author_post 테이블 생성
create table author_post(id BIGINT primary key auto_increment, author_id bigint not null, 
post_id bigint not null, created_time datetime not null default current_timestamp(), 
foreign key(author_id) references author(id), foreign key(post_id) references post(id));

-- 복합키로 author_post 생성
create table author_post2(
author_id bigint not null, 
post_id bigint not null,
primary key(author_id, post_id),
foreign key(author_id) references author(id), foreign key(post_id) references post(id));

-- 내 id로 내가 쓴 글 조회
select p.* from post p inner join author_post ap on p.id=ap.post_id where ap.author_id=1;

-- 글 2번 이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id
group by a.id having count(a.id)>=2 order by a.id;