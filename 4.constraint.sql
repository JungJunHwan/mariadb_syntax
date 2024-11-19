-- not null 제약조건 추가
alter table author modify column email varchar(255) not null;

-- unique 제약조건 추가
alter table author modify column email varchar(255) unique;
alter table author modify column email varchar(255) not null unique;

-- foreign key 제약조건 삭제 및 추가
-- 제약조건의 이름 확인 후 삭제 및 추가 가능
-- 제약조건 조회 (이 방법이 정확함)
select * from information_schema.key_column_usage where table_name = 'post';
-- 제약조건 삭제
alter table post drop foreign key post_ibfk_1;
-- 제약조건 추가 (foreign_key_name는 맘대로 작성 가능)
alter table post add constraint foreign_key_name foreign key(author_id) references author(id);

-- delete, update 관련 제약조건 테스트 (거의 손댈 일 없음)
-- on delete cascade 테스트
-- 제약조건 삭제
select * from information_schema.key_column_usage where table_name = 'post';

-- 제약조건 추가
-- on delete cascade
alter table post add constraint foreign_key_name foreign key(author_id) references author(id) on delete cascade;
-- on delete set null
alter table post add constraint foreign_key_name foreign key(author_id) references author(id) on delete set null on update set null;