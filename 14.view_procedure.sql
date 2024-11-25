-- view : 실제 데이터를 참조만 하는 가상의 테이블
-- 사용목적 1) 복잡한 쿼리 대신함, 2) 테이블의 컬럼까지 권한 분리

-- view 생성
create view author_for_marketing as select name, email from author;

-- view 조회
select * from author_for_marketing;

-- view 권한 부여
grant select on board.author_for_marketing to '계정명'@'localhost';

-- view 삭제
drop view author_for_marketing;

-- procedure 생성
DELIMITER //
create procedure hello_procedure()
begin
    select 'hello world';
end
// DELIMITER ;

-- procedure 호출
call hello_procedure();

-- procedure 삭제
drop procedure hello_procedure;

-- 게시글 목록 조회 procedure 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select * from post;
end
// DELIMITER ;

-- 게시글 id 단건 조회 procedure 생성
DELIMITER //
create procedure 게시글id단건조회(in postid bigint)
begin
    select * from post where id = postid;
end
// DELIMITER ;

-- 실습) 본인의 email을 입력값으로 쓴 글 목록 조회, 결과는 *
DELIMITER //
create procedure 게시글목록조회byemail(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents from post p inner join author_post a on a.post_id = p.id 
    where p.id = (select id from author where email = inputEmail);
end
// DELIMITER ;

-- 글쓰기
DELIMITER //
create procedure 게시글목록조회byemail(in inputTitle varchar(255), in inputContents varchar(255), in inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;

    -- post 테이블에 insert
    insert into post(title, contents) values(inputTitle, inputContents);
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;

    -- author_post 테이블 insert : author_id, post_id
    insert into author_post(author_id, post_id) values();
end
// DELIMITER ;

-- 글 삭제 : 입력값으로 본인 글id, 본인 email
DELIMITER //
create procedure 글삭제(in inputPostId bigint, in inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint;

    select count(*) inpto authorPostCount from author_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;

    if authorPostCount >= 2 then
        delete from author_post where post_id = inputPostId and author_id = authorId;
    else
        delete from author_post where post_id = inputPostId and author_id = authorId;
        delete from post where id = inputPostId;
    end if;
end
// DELIMITER ;

-- 반복문을 통해 post 대량 생성 : title, 글쓴이 email
DELIMITER //
create procedure 글도배(in count int, in inputEmail varchar(255))
begin
    declare countValue int default 0;
    declare authorId bigint;
    declare postId bigint;
    while countValue < count do
        -- post 테이블에 insert
        insert into post(title, contents) values("안녕하세요");
        select id into postId from post order by id desc limit 1;
        select id into authorId from author where email = inputEmail;

        -- author_post 테이블 insert : author_id, post_id
        insert into author_post(author_id, post_id) values();
        set countValue = countValue + 1;
    end while;
end
// DELIMITER ;