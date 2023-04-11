/*newbook ���̺� ����*/
CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000));

select * from newbook;

/*newcustomer ���̺� ����*/
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

/*neworders ���̺� ����*/
create table NewOrders(
orderid number,
custid number not null,
bookid number not null,
slaeprice number,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid) on delete cascade);

/*�Ӽ�*/
alter table newbook add isbn varchar2(13);
select * from newbook;
/*���� ���� ����*/
alter table newbook modify isbn number;

select * from newbook;
select * from newcustomer;
select * from neworders;

/*���̺� ����*/
drop table newbook;

select * from book;

/*���� �߰�*/
insert into book(bookid, bookname, publisher, price)
        values(11, '������ ����', '�Ѽ����м���', 90000);

insert into book(bookid, bookname, publisher)
        values(14, '������ ����', '�Ѽ����м���');

select * from imported_book;

/*�뷮 ����*/
insert into book(bookid, bookname, publisher, price)
select bookid, bookname, publisher, price
from imported_book;

select * from customer;

/*������Ʈ*/
update customer
set address='���ѹα� �λ�'
where custid=5;

update customer
set address=(select address
            from customer
            where name='�迬��')
where name='�ڼ���';

/*Ʃ�� ����*/
delete from customer
where custid=5;

rollback;

