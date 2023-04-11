/*newbook 테이블 생성*/
CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000));

select * from newbook;

/*newcustomer 테이블 생성*/
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

/*neworders 테이블 생성*/
create table NewOrders(
orderid number,
custid number not null,
bookid number not null,
slaeprice number,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid) on delete cascade);

/*속성*/
alter table newbook add isbn varchar2(13);
select * from newbook;
/*제약 사항 변경*/
alter table newbook modify isbn number;

select * from newbook;
select * from newcustomer;
select * from neworders;

/*테이블 삭제*/
drop table newbook;

select * from book;

/*투플 추가*/
insert into book(bookid, bookname, publisher, price)
        values(11, '스포츠 의학', '한솔의학서적', 90000);

insert into book(bookid, bookname, publisher)
        values(14, '스포츠 의학', '한솔의학서적');

select * from imported_book;

/*대량 삽입*/
insert into book(bookid, bookname, publisher, price)
select bookid, bookname, publisher, price
from imported_book;

select * from customer;

/*업데이트*/
update customer
set address='대한민국 부산'
where custid=5;

update customer
set address=(select address
            from customer
            where name='김연아')
where name='박세리';

/*튜플 삭제*/
delete from customer
where custid=5;

rollback;

