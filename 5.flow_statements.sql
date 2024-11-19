-- case 문
select 컬럼1, 컬럼2, 컬럼3,
case 컬럼4
    when 비교값1 then 결과값1 -- 컬럼4 == 비교값1 이면 결과값1 출력
    when 비교값2 then 결과값2 -- 컬럼4 == 비교값2 이면 결과값2 출력
    else 결과값3
end
from 테이블명;

-- 예제
select id, email,
case
    when name is null then '익명 사용자'
    else name
end as '사용자'
from author;

-- ifnull(a,b) : a가 null이면 b출력, 아니면 a출력
select id, email, ifnull(name,'익명 사용자') as '사용자 명' from author;

-- 경기도에 위치한 식품창고 목록 출력하기

-- if(a,b,c) : a가 참이면 b반환, 거짓이면 c반환
select id, email, if(name is null,'익명 사용자',name) as '사용자 명' from author;

-- 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
    case STATUS
        when 'SALE' then '판매중'
        when 'RESERVED' then '예약중'
        else '거래완료'
    end
from USED_GOODS_BOARD where CREATED_DATE like '2022-10-05'
order by BOARD_ID desc;

-- 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE, ifnull(TLNO,'NONE') 
from PATIENT where AGE <= 12 && GEND_CD='W'
order by AGE desc, PT_NAME;