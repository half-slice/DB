drop table theater;
drop table screen;
drop table moviecustomer;
drop table reserve; 

select * from theater;
select * from screen;
select * from moviecustomer;
select * from reserve;

alter table theater drop primary key;

rollback;

/*ex11 테이블 생성 극장:theater 상영관:screen 예약:reserve 고객:moveicustomer */
create table theater(
theaterid number,
theatername varchar2(10),
location varchar2(10),
primary key(theaterid)
);

/*상영관*/
create table screen(
theaterid number,
screenid number check(1<=screenid and screenid<=10),
moviename varchar2(20),
price number check(price <= 20000),
seatcount number,
primary key(screenid, theaterid)
);

/*고객*/
create table moviecustomer(
custid number,
name varchar2(10),
address varchar2(10),
primary key(custid)
);

/*예약*/
create table reserve(
theaterid number,
screenid number,
custid number,
seatid number UNIQUE,
reservedate date,
primary key(theaterid, screenid, custid)
);

/*ex11 튜플 삽입*/
insert into theater values(1, '롯데', '잠실');
insert into theater values(2, '메가', '강남');
insert into theater values(3, '대한', '잠실');

insert into screen values(1, 1, '어려운 영화', 15000, 48);
insert into screen values(3, 1, '멋진 영화', 7500, 120);
insert into screen values(3, 2, '재밌는 영화', 8000, 110);

insert into moviecustomer values(3, '홍길동', '강남');
insert into moviecustomer values(4, '김철수', '잠실');
insert into moviecustomer values(9, '박영희', '강남');

insert into reserve values(3, 2, 3, 15, '2020-09-01');
insert into reserve values(3, 1, 4, 16, '2020-09-01');
insert into reserve values(1, 1, 9, 48, '2020-09-01');

/*ex11-1 단순질의*/
/*모든 극장의 이름과 위치를 보이시오*/
select theatername, location 
from theater;

/*잠실에 있는 극장을 보이시오*/
select *
from theater
where location='잠실';

/*잠실에 사는 고객의 이름을 오름차순으로 보이시오*/
select name
from moviecustomer
where address='잠실'
order by name;

/*가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오*/
select theaterid, screenid, moviename
from screen
where price<=8000;

/*극장의 위치와 고객의 주소가 같은 고객의 보이시오*/
select distinct name
from moviecustomer, theater
where theater.location = moviecustomer.address;

/*ex11-2 집계질의*/
/*극장의 수는 몇 개인가*/
select count(*)
from theater;

/*상영되는 영화의 평균 가격은 얼마인가*/
select avg(price)
from screen;

/*2020년 9월 1일에 영화를 관람한 고객의 수는 얼마인가*/
select count(*)
from reserve
where reservedate in ('2020-09-01');

/*ex11-3 부속질의와 조인*/
/*대한극장에서 상영된 영화제목을 보이시오*/
select moviename
from theater, screen
where theater.theaterid = screen.theaterid and theater.theatername like '대한';

/*대한극장에서 영화를 본 고객의 이름을 보이시오*/
select name
from moviecustomer, reserve
where reserve.custid = moviecustomer.custid and  reserve.theaterid in (select theaterid
                                                                        from theater
                                                                        where theatername like '대한');

/*대한극장에서 전체 수입을 보이시오*/
select sum(price)
from screen, theater, reserve
where theater.theatername like '대한' and reserve.theaterid = screen.theaterid; 

/*ex11-4 부속질의와 조인*/
/*극장별 상영관 수를 보이시오*/
select theatername, count(screen.theaterid)
from theater, screen
where theater.theaterid = screen.theaterid(+)
group by theatername;

/*잠실에 있는 극장의 상영관을 보이시오*/
select *
from screen
where screen.theaterid in (select theaterid
                            from theater
                            where location='잠실');

/*2020년 9월 1일의 극장별 평균 관람 고객 수를 보이시오*/
select theatername, count(reserve.theaterid)
from theater left outer join reserve
on theater.theaterid = reserve.theaterid and reserve.reservedate in ('2020-09-01')
group by theatername;

/*2020년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오*/
select moviename
from (select moviename, count(reserve.custid) as countmax
        from screen, reserve, moviecustomer
        where screen.screenid = reserve.screenid and reserve.custid = moviecustomer.custid and screen.theaterid = reserve.theaterid and reserve.reservedate in ('2020-09-01')
        group by moviename);