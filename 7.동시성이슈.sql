-- read uncommitted에서 발생할 수 있는 dirty read 실습
-- 실습 절차
-- 1) workbench에서 auto_commit 해제 후 update, commit 하지 않음 (transaction 1)
-- 2) 터미널을 열어 select 했을 때 위 변경사항이 읽히는지 확인 (transaction 2)
-- 결론 : mariadb는 기본이 repeatable read 이므로 commit 되기전에 조회되는 dirty read 발생하지 않음

-- read committed에서 발생할 수 있는 phantom read 또는 no-repeatable read 실습
-- 아래 코드는 워크벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 아래 코드는 터미널에서 실행
insert into author(email) values('sasdasdas');
-- 결론 : mariadb는 기본이 repeatable read 이므로 phantom read 발생하지 않음

-- repeatable read 에서 발생할 수 있는 lost update 실습
-- lost update 해결을 위한 배타적 lock
-- 아래 코드는 워크벤치에서 실행
start transaction;
select post_count from author where id=1 for update;
do sleep(10);
update author set post_count = (select post_count from author where id=1)-1 where id=1;
commit;
-- 아래 코드는 터미널에서 실행
update author set post_count = (select post_count from author where id=1)-1 where id=1;

-- lost update 해결을 위한 공유 lock
-- 아래 코드는 워크벤치에서 실행
start transaction;
select post_count from author where id=1 lock in share mode;
do sleep(10);
commit;
-- 아래 코드는 터미널에서 실행
select post_count from author where id=1;