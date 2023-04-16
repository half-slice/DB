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

/*ex11 ���̺� ���� ����:theater �󿵰�:screen ����:reserve ��:moveicustomer */
create table theater(
theaterid number,
theatername varchar2(10),
location varchar2(10),
primary key(theaterid)
);

/*�󿵰�*/
create table screen(
theaterid number,
screenid number check(1<=screenid and screenid<=10),
moviename varchar2(20),
price number check(price <= 20000),
seatcount number,
primary key(screenid, theaterid)
);

/*��*/
create table moviecustomer(
custid number,
name varchar2(10),
address varchar2(10),
primary key(custid)
);

/*����*/
create table reserve(
theaterid number,
screenid number,
custid number,
seatid number UNIQUE,
reservedate date,
primary key(theaterid, screenid, custid)
);

/*ex11 Ʃ�� ����*/
insert into theater values(1, '�Ե�', '���');
insert into theater values(2, '�ް�', '����');
insert into theater values(3, '����', '���');

insert into screen values(1, 1, '����� ��ȭ', 15000, 48);
insert into screen values(3, 1, '���� ��ȭ', 7500, 120);
insert into screen values(3, 2, '��մ� ��ȭ', 8000, 110);

insert into moviecustomer values(3, 'ȫ�浿', '����');
insert into moviecustomer values(4, '��ö��', '���');
insert into moviecustomer values(9, '�ڿ���', '����');

insert into reserve values(3, 2, 3, 15, '2020-09-01');
insert into reserve values(3, 1, 4, 16, '2020-09-01');
insert into reserve values(1, 1, 9, 48, '2020-09-01');

/*ex11-1 �ܼ�����*/
/*��� ������ �̸��� ��ġ�� ���̽ÿ�*/
select theatername, location 
from theater;

/*��ǿ� �ִ� ������ ���̽ÿ�*/
select *
from theater
where location='���';

/*��ǿ� ��� ���� �̸��� ������������ ���̽ÿ�*/
select name
from moviecustomer
where address='���'
order by name;

/*������ 8000�� ������ ��ȭ�� �����ȣ, �󿵰���ȣ, ��ȭ������ ���̽ÿ�*/
select theaterid, screenid, moviename
from screen
where price<=8000;

/*������ ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�*/
select distinct name
from moviecustomer, theater
where theater.location = moviecustomer.address;

/*ex11-2 ��������*/
/*������ ���� �� ���ΰ�*/
select count(*)
from theater;

/*�󿵵Ǵ� ��ȭ�� ��� ������ ���ΰ�*/
select avg(price)
from screen;

/*2020�� 9�� 1�Ͽ� ��ȭ�� ������ ���� ���� ���ΰ�*/
select count(*)
from reserve
where reservedate in ('2020-09-01');

/*ex11-3 �μ����ǿ� ����*/
/*���ѱ��忡�� �󿵵� ��ȭ������ ���̽ÿ�*/
select moviename
from theater, screen
where theater.theaterid = screen.theaterid and theater.theatername like '����';

/*���ѱ��忡�� ��ȭ�� �� ���� �̸��� ���̽ÿ�*/
select name
from moviecustomer, reserve
where reserve.custid = moviecustomer.custid and  reserve.theaterid in (select theaterid
                                                                        from theater
                                                                        where theatername like '����');

/*���ѱ��忡�� ��ü ������ ���̽ÿ�*/
select sum(price)
from screen, theater, reserve
where theater.theatername like '����' and reserve.theaterid = screen.theaterid; 

/*ex11-4 �μ����ǿ� ����*/
/*���庰 �󿵰� ���� ���̽ÿ�*/
select theatername, count(screen.theaterid)
from theater, screen
where theater.theaterid = screen.theaterid(+)
group by theatername;

/*��ǿ� �ִ� ������ �󿵰��� ���̽ÿ�*/
select *
from screen
where screen.theaterid in (select theaterid
                            from theater
                            where location='���');

/*2020�� 9�� 1���� ���庰 ��� ���� �� ���� ���̽ÿ�*/
select theatername, count(reserve.theaterid)
from theater left outer join reserve
on theater.theaterid = reserve.theaterid and reserve.reservedate in ('2020-09-01')
group by theatername;

/*2020�� 9�� 1�Ͽ� ���� ���� ���� ������ ��ȭ�� ���̽ÿ�*/
select moviename
from (select moviename, count(reserve.custid) as countmax
        from screen, reserve, moviecustomer
        where screen.screenid = reserve.screenid and reserve.custid = moviecustomer.custid and screen.theaterid = reserve.theaterid and reserve.reservedate in ('2020-09-01')
        group by moviename);