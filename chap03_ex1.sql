/*도서번호가 1번 도서의 이름*/
SELECT bookname 
FROM Book
WHERE price>=20000;

/*가격이 20000원 이상인 도서의 이름*/
SELECT bookname 
FROM Book
WHERE price>=20000;

/*박지성의 총구매액*/
SELECT SUM(saleprice)
FROM orders
WHERE custid=1;

/*박지성의 총구매액2*/
SELECT SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid AND customer.name LIKE '박지성';

/*박지성이 구매한 도서의 수*/
SELECT COUNT(*)
FROM customer, orders
WHERE customer.custid = orders.custid AND customer.name LIKE '박지성';

/*박지성의 구매한 도서의 출판사의 수*/
SELECT COUNT(publisher)
FROM book, customer, orders
WHERE book.bookid = orders.bookid AND customer.custid = orders.custid AND customer.name LIKE '박지성';



