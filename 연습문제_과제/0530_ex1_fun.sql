/*�ݿø�*/
select custid "����ȣ", round(sum(saleprice)/count(*), -2) "��ձݾ�"
from orders
group by custid;

/*��¥ ���� �Լ�*/
select TO_DATE('2020-07-01', 'yyyy-mm-dd')+5 before, to_date('2020-07-01', 'yyyy-mm-dd')-5 after
from dual;

/*dbms ������ ������ ���� ��¥�� �ð�*/
select sysdate
from dual;

/*date�� �����Ϳ� �ϼ��� ���ϴ°� ����*/
select orderid "�ֹ���ȣ", orderdate "�ֹ���", orderdate + 10 "Ȯ��"
from Orders;

/*dbms ������ ������ ���� ��¥�� �ð�, ���� Ȯ��*/
select sysdate, TO_CHAR(sysdate, 'yyyy-mm-dd hh24:mm:ss') "sysdate_1"
from dual;

/*���ڿ��� �߶� ���� �����ϱ�*/
select substr(name, 1, 1) "��", count(*) "�ο�"
from customer
group by substr(name, 1, 1);

select name "�̸�", nvl(phone, '����ó ����') "��ȭ��ȣ"
from customer;

select rownum "����", custid, name, phone
from customer
where rownum<=2;

/*3��*/
select * 
from book;

/*5�������*/
select * 
from book
where rownum <= 5; 

/*���ݴ뿡 ����*/
select * 
from book
where rownum <= 5
order by price;

select *
from (select * from book order by price) b
where rownum <= 5;

/*���� 5���� ���� ���� �� ���ݴ븦 ��*/
select *
from (select * from book where rownum <= 5) b
order by price;

select *
from(select * 
    from book
    where rownum <= 5 
    order by price) b;


