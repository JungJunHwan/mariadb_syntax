-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환, on 조건을 통해 교집합 찾기
-- join 앞의 테이블이 먼저 나오고, 뒤의 테이블이 옆에 붙음
select * from author a inner join post p on a.id=p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오
-- post의 글쓴이가 없는 데이터는 포함 X, 글쓴이 중 글을 한번도 안쓴사람 포함 X
select p.*, a.email from post p inner join author a on a.id=p.author_id;
-- 글쓴이가 있는 글의 제목, 내용과 글쓴이의 이메일을 출력하시오
select p.title, p.contents, a.email from post p inner join author a on a.id=p.author_id;

-- 모든 글 목록을 출력하고, 글쓴이가 있다면 이메일 정보를 출력
-- left outer join -> left join으로 생략 가능
-- 글을 한번도 안쓴 글쓴이 정보는 포함 X
select p.*, a.email from post p left join author a on a.id=p.author_id;

-- 글쓴이를 기준으로 left join 할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 n번 출력됨
-- author와 post가 1:n 관계이기 때문임
-- 글쓴이가 없는 글은 포함 X
select * from author a left join post p on a.id=p.author_id;

-- 실습) 글쓴이가 있는 글 중에서 글의 제목과 저자의 이메일 만을 출력하되, 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from post p left join author a on a.id=p.author_id where a.age>=30;

-- 실습) 글의 내용과 글의 저자의 이름이 있는 글 목록을 출력하되 2024-06 이후에 만들어진 글만 출력
select p.*, a.name from post p inner join author a on a.id=p.author_id where p.contents 
is not null and p.title is not null and p.created_time >= '2024-06-01';

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT b.BOOK_ID, a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE
from BOOK b inner join AUTHOR a on b.AUTHOR_ID=a.AUTHOR_ID 
where b.CATEGORY = '경제'
order by b.PUBLISHED_DATE;

-- union : 두 테이블의 select 결과를 횡으로 결합 (기본적으로 distinct 적용)
-- 컬럼의 개수와 컬럼의 타입이 같아야함에 유의
-- union all : 중복까지 모두 포함
select name, email from author union select title, contents from post;


-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- where절 안에 서브쿼리
-- 한 번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id=p.author_id;
select * from author where id in (select author_id from post);

-- select절 안에 서브쿼리
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*)from post where author_id=a.id) as count from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- 없어진 기록 찾기
-- join 풀이
SELECT o.ANIMAL_ID, o.NAME from ANIMAL_OUTS o left join ANIMAL_INS i on o.ANIMAL_ID=i.ANIMAL_ID where i.ANIMAL_ID is null;
-- 서브쿼리 풀이
SELECT ANIMAL_ID, NAME from ANIMAL_OUTS where ANIMAL_ID not in (select ANIMAL_ID from ANIMAL_INS);


-- 집계 함수
-- null은 count에서 제외
select count(*) from author; -- 전체 데이터 개수 조회
select sum(price) from post; -- price의 총합
select avg(price) from post; -- price의 평균
select round(avg(price,n)) from post; -- price의 평균, 소숫점 n번째 자리까지 반올림 (안쓰면 n=0으로 적용)

-- group by : 그룹화된 데이터를 하나의 행처럼 취급
-- author_id로 그룹핑 하면, 그 외의 컬럼을 조회하는것은 적절치 않음
select author_id from post group by author_id;
-- group by와 집계 함수
-- 아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*)from post where author_id=a.id) as count from author a;
-- join과 group by, 집계 함수 활용한 글의 개수 출력
select a.email, count(p.author_id) from author a left join post p on a.id=p.author_id group by a.email;
select a.email, count(p.id) from author a left join post p on a.id=p.author_id group by a.id; -- 같은 결과

-- 문법 순서 : select from join on where group by having order by

-- where와 group by
-- 연도별 post 글의 개수 출력, 연도가 null인 값은 제외
select date_format(created_time,'%Y') as year, count(*) from post where created_time is not null group by year; -- where의 created_time을 year로 쓰면 실행조차 안됨 (where절 까지는 아직 year컬럼이 생성 안된듯)

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, count(CAR_ID) as CARS from CAR_RENTAL_COMPANY_CAR
where OPTIONS like '%시트%'
group by CAR_TYPE
order by CAR_TYPE;

-- 입양 시각 구하기(1)
SELECT date_format(DATETIME, '%H') as HOUR, count(*) as COUNT from ANIMAL_OUTS
where date_format(DATETIME, '%H') >= '09' and date_format(DATETIME, '%H') < '20'
group by HOUR
order by HOUR;

-- having : group by 를 통해 나온 집계값에 대한 조건
-- 글을 2개 이상 쓴 사람에 대한 정보 조회
select author_id from post group by author_id having count(*) >= 2;

-- 동명 동물 수 찾기
SELECT NAME, count(*) as COUNT from ANIMAL_INS
where NAME is not null
group by NAME
having COUNT >= 2
order by NAME;

-- 다중열 group by
-- post에서 작성자별로 만든 제목의 개수를 출력하시오
select author_id, title, count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID, PRODUCT_ID from ONLINE_SALE
group by USER_ID, PRODUCT_ID
HAVING count(*)>1
order by USER_ID, PRODUCT_ID DESC;