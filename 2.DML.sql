-- insert into : 테이블에 데이터 삽입
insert into table_name(column_1, column_2, column_3) values(data_1, data_2, data_3);
-- 문자열은 일반적으로 작은따옴표 '' 를 사용
insert into author(id, name, email) values(3, 'kim', 'kim@naver.com');
-- select : 데이터 조회, * : 모든 컬럼을 의미
select * from author;
select name, email from author;

-- post에 데이터 1줄 추가
insert into post(id, title, author_id) values(1, 'test', 1);
insert into post(id, title, contents, author_id) values(1, 'hi', 'hi~~~', 5);

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

-- insert 문을 통해 author 데이터 2개 추가, post 데이터 2개 추가(1개는 익명)

-- update : 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의
update table_name set column_name='홍길동' where id=1;
update table_name set column_name='홍길동', email='hong@naver.com' where id=1;

-- delete : 데이터 삭제
-- where문을 생략할 경우, 모든 데이터가 삭제됨에 유의
delete from author where id=5;

-- select : 조회
select * from author;
select * from author where id=1;
select * from author where name='홍길동';
select * from author where id>2 and name='kim'; -- 또는 : or

-- 중복 제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- 아무런 정렬 조거 없이 조회할 경우에는 pk 기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;

-- 멀티컬럼 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬 후 중복시 그 다음 정렬옵션 적용
select * from author order by name desc, email;

-- 결과값 개수 제한
select * from author order by id desc limit 2;

-- 별칭(alias)을 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a; --원래는 a 자리에 author가 들어가는데 이런식으로 치환해서 활용 가능
select a.name, a.email from author a;

-- null을 조회 조건으로 활용
select * from author where password is null;
select * from author where password is not null;

-- 프로그래머스 sql 문제풀이
-- 여러 기준으로 정렬하기
-- 상위 n개 레코드