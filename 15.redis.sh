# redis 설치
sudo apt-get install redis-server

# redis 접속
redis-cli

# redis는 0~15번까지의 database로 구성 (default는 0번 db)
# 데이터베이스 선택
select db번호

# 데이터베이스 내의 모든 키 조회
keys *

# 일반적인 String 자료구조
set key명 value값
# set을 통해 key, value 세팅. 맵에서 set은 이미 존재할때 덮어쓰기
set user:email:1 hong1@naver.com
# nx : key에 값이 존재하면 pass, 없으면 set
set user:email:1 hong1@naver.com nx
# ex : 만료시간(초단위) - ttl(time to live)
set user:email:1 hong1@naver.com ex 10

# get을 통해 value값 얻기
get user:email:1

# 특정 key 삭제
del user:email:1

# 현재 db내의 모든 데이터 삭제
flushdb

# redis 활용 예시 : 동시성 이슈
# 1. 좋아요 기능 구현
set likes:posting:1 0
# 좋아요 눌렀을 경우
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1 #특정 key값의 value를 1만큼 감소
get likes:posting:1
# 2. 재고 관리
set stocks:product:1 100
decr stocks:product:1
get stocks:product:1
# bash쉘을 활용하여 재고감소 프로그램 작성
# 15-1 쉘 파일 참조

# redis 활용 예시 : 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 결과값을 redis로 캐싱 -> json형식으로 저장 {"name":"hong", "email":"hong@naver,com", "age":"30"}
set author:info:1 "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":\"30\"}" ex 20

# list 자료구조
# redis의 list는 자바의 deque와 같은 자료구조, 즉 double-ended queue 구조

# lpush : 데이터를 왼쪽에 삽입 
# rpush : 데이터를 오른쪽에 삽입
# lpop : 데이터를 왼쪽에서 꺼내기 (key에서 값을 다 빼면 key도 사라짐)
# rpop : 데이터를 오른쪽에서 꺼내기

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3
rpop hongildongs

# list 조회
# -1은 리스트의 끝자리를 의미, -2는 끝에서 2번째를 의미
lrange hongildongs 0 0 #첫번째 값
lrange hongildongs 0 -1 #처음부터 끝까지
lrange hongildongs -1 -1 #마지막 값

# 데이터 개수 조회
llen hongildongs

# ttl 적용
expire hongildongs 20
# ttl 조회 (남은 시간 나옴)
ttl hongildongs
# pop과 push를 동시에
# A리스트에서 pop하여 B리스트로 push
rpoplpush A리스트 B리스트

# 최근 방문한 페이지
# 5개정도 데이터 push
# 최근 방문한 페이지 3개만 보여주는
lpush sites naver.com
lpush sites google.com
lpush sites daum.com
lpush sites kakao.com
lpush sites chrome.com
lrange sites 0 2

# set 자료구조 : 중복없음, 순서없음
sadd memberlist member1
sadd memberlist member2
sadd memberlist member1

# set 조회
smembers memberlist
# set 개수 조회
scard memberlist
# set에서 멤버 삭제
srem memberlist member2
# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember memberlist member1

# 좋아요 구현
sadd likes:posting:1 member1
sadd likes:posting:1 member2
sadd likes:posting:1 member1
scard likes:posting:1

# zset : sorted set
# 사이에 숫자는 score라고 불리고, score를 기준으로 정렬이 가능
zadd memberlist 3 member1
zadd memberlist 4 member2
zadd memberlist 1 member3
zadd memberlist 2 member4

# 조회 방법
# score 기준 오름차순 정렬
zrange memberlist 0 -1
# score 기준 오름차순 정렬
zrevrange memberlist 0 -1

# zset 삭제
zrem memberlist member4

# zrank : 특정 멤버가 몇번째 index에 있는지 출력
zrank memberlist member4

# 최근 본 상품 목록 => zset 활용해서 최근 시간순으로 정렬
# zset도 set이므로 같은 상품을 add할 경우에 시간만 업데이트되고 중복이 제거
zadd recent:products 151930 pineapple
zadd recent:products 152030 banana
zadd recent:products 212130 orange
zadd recent:products 212230 apple
zadd recent:products 212330 apple
# 최근 본 상품 목록 3개 조회
zrevrange recent:products 0 2
zrevrange recent:products 0 2 withscores

# hashes : map 형태의 자료구조(key:value key:value ... 형태의 자료구조)
hset author:info:1 name "hong" email "homg@naver.com" age 30
# 특정값 조회
hget author:info:1 name
# 모든 객체값 조회
hgetall author:info:1

# 특정 요소값 수정
hset author:info:1 name kim