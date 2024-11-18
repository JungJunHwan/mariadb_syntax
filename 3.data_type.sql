-- tinyint는 -128~127까지 표현 (1byte 할당)
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;
-- data insert 테스트 : 200살 insert
insert into author(id, age) values(6, 200);
alter table author modify column age tinyint unsigned; -- 음수 사용하지 않는 설정

-- decimal 실습
-- decimal(정수부 자릿수,실수부 자릿수)
alter table post add column price decimal(10,3);

-- decimal 소수점 초과 후 값 짤림 현상
insert into post(id, title, price) values(2, 'java', 10.33412);

-- 문자열 실습
alter table author add column self_introduction text;
insert into author(id, self_introduction) values(7, '안녕하세요');


-- blob(바이너리 데이터) 타입 실습
alter table author add column profile_image longblob;
insert into author(id, profile_image) values(8, LOAD_FILE('C:\\Users\Playdata\Desktop\골댕.jfif'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('user', 'admin') not null default 'user';
-- user 값 세팅 후 insert
insert into author(id, role) values(9, 'user');
-- users 값 세팅 후 insert (잘못된 값)
insert into author(id, role) values(10, 'users');
-- 아무것도 안넣고 insert (default 값)
insert into author(id) values(11);

-- date : 날짜, datetime : 날짜 및 시분초, datetime(m) : 소숫점 초까지
-- 입력, 수정, 조회 시 문자열 형식을 사용
alter table post add column created_time datetime default current_timestamp();
alter table post add column created_time datetime(3) default current_timestamp(3);
update post set created_time = '2024-11-18 17:12:20' where id = 6;

-- 조회시 비교연산자
select * from author where id >= 2 and id <= 4;
select * from author where id between 2 and 4; -- 위 구문과 같음
select * from author where id not(id < 2 or id > 4); -- 위 구문과 같음
select * from author where id in(2,3,4); -- 위 구문과 같음
select * from author where id not in(1,5); -- 위 구문과 같음 (전체 데이터가 1~5까지만 있다는 가정하에)

-- 글쓴 경험있는지 확인
select * from author where id in(select author_id from post);