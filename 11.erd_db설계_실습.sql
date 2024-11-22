-- https://www.erdcloud.com/d/vdT4dhW7xPqPTjsiM

-- 스키마 생성
create database mall;
use mall;

-- table 생성
create table user(id bigint primary key auto_increment, authority enum('user', 'seller') not null default 'user', 
password varchar(255) not null,
name varchar(255) not null,
email varchar(255) not null,
gender varchar(255),
phone varchar(255) not null,
created_time datetime not null default current_timestamp());
describe user;


create table address(id bigint primary key auto_increment,
user_id bigint, 
city varchar(255) not null,
village varchar(255) not null,
street varchar(255) not null,
created_time datetime not null default current_timestamp(),
foreign key(user_id) references user(id));
describe address;


create table purchase(id bigint primary key auto_increment,
address_id bigint, 
user_id bigint, 
created_time datetime not null default current_timestamp(),
foreign key(address_id) references address(id),
foreign key(user_id) references user(id));
describe purchase;


create table seller(id bigint primary key auto_increment,
authority enum('user', 'seller') not null default 'seller',
name varchar(255) not null,
created_time datetime not null default current_timestamp());
describe seller;


create table item(id bigint primary key auto_increment,
seller_id bigint, 
name varchar(255) not null,
description varchar(255) not null,
price int not null,
stock int not null,
created_time datetime not null default current_timestamp(),
foreign key(seller_id) references seller(id));
describe item;


create table purchase_detail(id bigint primary key auto_increment,
purchase_id bigint, 
item_id bigint, 
quantity int not null,
foreign key(purchase_id) references purchase(id),
foreign key(item_id) references item(id));
describe purchase_detail; 	


-- test 데이터 생성
-- user
insert into user(password, name, email, gender, phone) values('wert345', 'aaaa','aaaa@naver.com','male','010-0000-0000'); 
insert into user(password, name, email, gender, phone) values('a645WEF', 'awe','awe@naver.com','male','010-0000-0000'); 
insert into user(password, name, email, gender, phone) values('jaw98', 'oieqj','oieqj@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('9782fwjk', 'hff','hff@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('jowe23u89', 'nof','nof@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('fejkl235789', 'oncf','oncf@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('h786', 'dqwjio','dqwjio@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('hiuy', 'woeiru','woeiru@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('kjae98', 'kwef','kwef@naver.com','male','010-0000-0000');
insert into user(password, name, email, gender, phone) values('k9n8478', 'qvh8','qvh8@naver.com','male','010-0000-0000');

-- address
insert into address(user_id, city, village, street) values(1, '서울', '광진구', '능동로');
insert into address(user_id, city, village, street) values(1, '미국', '누욕', '어딘가');
insert into address(user_id, city, village, street) values(2, '서울', '광진구', '능동로');
insert into address(user_id, city, village, street) values(3, '서울', '광진구', '천호로');
insert into address(user_id, city, village, street) values(4, '부산', '부산진구', '부전동');
insert into address(user_id, city, village, street) values(5 ,'부산', '해운대구', '구남로');
insert into address(user_id, city, village, street) values(6 ,'아산', '아산', '배방읍');
insert into address(user_id, city, village, street) values(7, '천안', '동남구', '만남로');
insert into address(user_id, city, village, street) values(8, '강원', '속초시', '중앙로');
insert into address(user_id, city, village, street) values(9, '강원', '속초시', '아바이마을길');
insert into address(user_id, city, village, street) values(10,'인천', '중구', '공항로');


-- seller
insert into seller(name) values('1111');
insert into seller(name) values('2222');
insert into seller(name) values('3333');
insert into seller(name) values('4444');

-- item
insert into item(name, description, price, stock) values('apple', '--', 1300, 2);
insert into item(name, description, price, stock) values('banana', '--', 5000, 7);
insert into item(name, description, price, stock) values('orange', '--', 4000, 3);

insert into item(name, description, price, stock) values('laptop', '--', 2000000, 9);
insert into item(name, description, price, stock) values('keyboard', '--', 50000, 4);
insert into item(name, description, price, stock) values('chair', '--', 150000, 1);
insert into item(name, description, price, stock) values('desk', '--', 200000, 3);
insert into item(name, description, price, stock) values('wood', '--', 10000, 5);

insert into item(name, description, price, stock) values('tshirt', '--', 20000, 2);
insert into item(name, description, price, stock) values('jean', '--', 400000, 8);
insert into item(name, description, price, stock) values('shoes', '--', 200000, 4);
insert into item(name, description, price, stock) values('sunglass', '--', 5000000, 1);
insert into item(name, description, price, stock) values('clock', '--', 15000, 2);

-- purchase
insert into purchase(address_id, user_id) values(1,1);
insert into purchase(address_id, user_id) values(2,2);
insert into purchase(address_id, user_id) values(9,9);
insert into purchase(address_id, user_id) values(9,9);
insert into purchase(address_id, user_id) values(3,3);
insert into purchase(address_id, user_id) values(2,2);
insert into purchase(address_id, user_id) values(1,1);
insert into purchase(address_id, user_id) values(6,6);
insert into purchase(address_id, user_id) values(1,1);
insert into purchase(address_id, user_id) values(8,8);
insert into purchase(address_id, user_id) values(9,9);
insert into purchase(address_id, user_id) values(10,10);
insert into purchase(address_id, user_id) values(1,1);

-- purchase_detail
insert into purchase_detail(purchase_id, item_id, quantity) values(1,1,10);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,2,3);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,3,7);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,4,4);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,5,3);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,6,2);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,7,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(1,8,1);

insert into purchase_detail(purchase_id, item_id, quantity) values(2,9,7);
insert into purchase_detail(purchase_id, item_id, quantity) values(2,8,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(2,6,9);
insert into purchase_detail(purchase_id, item_id, quantity) values(2,5,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(2,7,3);


insert into purchase_detail(purchase_id, item_id, quantity) values(3,9,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(3,6,9);
insert into purchase_detail(purchase_id, item_id, quantity) values(3,1,3);
insert into purchase_detail(purchase_id, item_id, quantity) values(3,5,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(3,7,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(3,2,3);

insert into purchase_detail(purchase_id, item_id, quantity) values(4,1,8);
insert into purchase_detail(purchase_id, item_id, quantity) values(4,2,9);
insert into purchase_detail(purchase_id, item_id, quantity) values(4,8,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(4,3,5);

insert into purchase_detail(purchase_id, item_id, quantity) values(5,1,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(5,3,4);
insert into purchase_detail(purchase_id, item_id, quantity) values(5,9,5);

insert into purchase_detail(purchase_id, item_id, quantity) values(6,8,8);
insert into purchase_detail(purchase_id, item_id, quantity) values(6,3,7);
insert into purchase_detail(purchase_id, item_id, quantity) values(6,4,2);

insert into purchase_detail(purchase_id, item_id, quantity) values(7,1,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(7,11,9);
insert into purchase_detail(purchase_id, item_id, quantity) values(7,10,5);

insert into purchase_detail(purchase_id, item_id, quantity) values(8,2,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(8,7,1);
insert into purchase_detail(purchase_id, item_id, quantity) values(8,3,1);

insert into purchase_detail(purchase_id, item_id, quantity) values(9,10,6);
insert into purchase_detail(purchase_id, item_id, quantity) values(9,8,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(9,5,9);

insert into purchase_detail(purchase_id, item_id, quantity) values(10,1,4);
insert into purchase_detail(purchase_id, item_id, quantity) values(10,5,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(10,6,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(10,7,5);
insert into purchase_detail(purchase_id, item_id, quantity) values(10,12,7);
insert into purchase_detail(purchase_id, item_id, quantity) values(10,13,1);


-- 조회
-- 주문한 적 있는 유저 조회
select * from user u inner join purchase p on u.id=p.user_id order by u.id;
-- 주문 횟수 출력
select u.email, count(p.id) from user u left join purchase p on u.id=p.user_id group by u.id;
