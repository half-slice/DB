/*반올림*/
select custid "고객번호", round(sum(saleprice)/count(*), -2) "평균금액"
from orders
group by custid;

/*날짜 내장 함수*/
select TO_DATE('2020-07-01', 'yyyy-mm-dd')+5 before, to_date('2020-07-01', 'yyyy-mm-dd')-5 after
from dual;

/*dbms 서버에 설정된 현재 날짜와 시간*/
select sysdate
from dual;

/*date형 데이터에 일수를 더하는게 가능*/
select orderid "주문번호", orderdate "주문일", orderdate + 10 "확정"
from Orders;

/*dbms 서버에 설정된 현재 날짜와 시간, 요일 확인*/
select sysdate, TO_CHAR(sysdate, 'yyyy-mm-dd hh24:mm:ss') "sysdate_1"
from dual;

/*문자열을 잘라서 성을 추출하기*/
select substr(name, 1, 1) "성", count(*) "인원"
from customer
group by substr(name, 1, 1);

select name "이름", nvl(phone, '연락처 없음') "전화번호"
from customer;

select rownum "순번", custid, name, phone
from customer
where rownum<=2;

/*3번*/
select * 
from book;

/*5행까지만*/
select * 
from book
where rownum <= 5; 

/*가격대에 따라*/
select * 
from book
where rownum <= 5
order by price;

select *
from (select * from book order by price) b
where rownum <= 5;

/*순번 5개를 먼저 선택 후 가격대를 비교*/
select *
from (select * from book where rownum <= 5) b
order by price;

select *
from(select * 
    from book
    where rownum <= 5 
    order by price) b;


