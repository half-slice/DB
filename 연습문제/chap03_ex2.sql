/*마당서점 도서의 총수*/
SELECT count(*)
FROM book;

/*마당서점에 도서를 출고하는 출판사의 총수*/
SELECT COUNT(DISTINCT publisher)
FROM book;

/*모든 고객의 이름, 주소*/
SELECT name, address
FROM customer;

/*2020년 7월 4일 ~7월 7일 사이에 주문받은 도서의 주문번호*/
SELECT orderid
FROM orders
WHERE orderdate BETWEEN '2020-07-04' AND '2020-07-07';

/*2020년 7월 4일 ~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호*/
SELECT orderid
FROM orders
WHERE orderdate NOT BETWEEN '2020-07-04' AND '2020-07-07';

/*성이 '김'씨인 고객의 이름과 주소*/
SELECT name, address
FROM customer
WHERE name LIKE '김%';

/*성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소*/
SELECT name, address
FROM customer
WHERE name LIKE '김%아';
