/*박지성이 구매한 도서의 출판사 수*/
SELECT COUNT(DISTINCT publisher)
FROM book
WHERE bookid IN (SELECT bookid
                    FROM orders
                    WHERE custid = (SELECT custid
                                    FROM customer
                                    WHERE name = '박지성'));
                                    
/*박지성이 구매한 도서의 출판사 수-2*/
SELECT COUNT(DISTINCT publisher)
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid=book.bookid AND customer.name like '박지성';

/*박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 book.price = 정가 / orders.saleprice = 판매가*/
SELECT bookname, price, saleprice, price-saleprice AS 가격차이
FROM book, orders
WHERE book.bookid = orders.bookid AND orders.custid = (SELECT custid
                                                FROM customer
                                                WHERE name = '박지성');

/*박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이-2 book.price = 정가 / orders.saleprice = 판매가*/
SELECT bookname, price, price-saleprice
FROM customer, orders, book
WHERE customer.custid=orders.custid AND orders.bookid=book.bookid AND customer.name LIKE '박지성';


/*박지성이 구매하지 않은 도서의 이름*/
SELECT bookname
FROM book
MINUS
SELECT bookname
FROM book
WHERE bookid IN (SELECT bookid 
                FROM orders
                WHERE custid = (SELECT custid
                                FROM customer
                                WHERE name LIKE '박지성'));

/*박지성이 구매하지 않은 도서의 이름-2 / 상관질의 = 상위질의에서 book테이블을 언급했으므로 하위질의에서 book을 언급할 필요는 없다*/
SELECT bookname
FROM book
WHERE NOT EXISTS (SELECT bookname
                    FROM customer, orders
                    WHERE customer.custid = orders.custid AND orders.bookid = book.bookid AND customer.name like '박지성');

/*주문하지 않은 고객의 이름(부속질의 사용)*/
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                FROM orders);
                
/*주문하지 않은 고객의 이름(부속질의 사용)-2*/
SELECT name
FROM customer
WHERE name NOT IN(SELECT name
            FROM orders
            WHERE customer.custid = orders.custid);


/*주문 금액의 총액과 주문의 평균 금액*/
SELECT SUM(saleprice), AVG(saleprice)
FROM orders;

/*고객의 이름과 고객별 구매액*/
SELECT name, SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid(+)
GROUP BY name;

/*고객의 이름과 고객이 구매한 도서 목록*/
SELECT name, bookname
FROM customer LEFT OUTER JOIN book
                ON book.bookid IN (SELECT bookid
                                FROM orders
                                WHERE orders.custid = customer.custid);
                                
/*고객의 이름과 고객이 구매한 도서 목록-2*/
SELECT name, bookname
FROM customer ,book, orders
WHERE customer.custid = orders.custid AND book.bookid = orders.bookid;

/*도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문*/
SELECT *
FROM orders
WHERE orders.orderid = (SELECT orders.orderid
                    FROM orders, book
                    WHERE orders.bookid = book.bookid AND (book.price - orders.saleprice) = (SELECT MAX(book.price - orders.saleprice)
                                                                                            FROM book, orders
                                                                                            WHERE orders.bookid = book.bookid));

/*도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문-2*/
SELECT *
FROM book, orders
WHERE book.bookid = orders.bookid AND price-saleprice = (SELECT MAX(book.price-saleprice)
                                                        FROM book, orders
                                                        WHERE book.bookid = orders.bookid);

/*도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 HAVING절은 조건에 SUM, COUNT등을 쓸수있다 대신 앞에 GROUP BY를 써줘야됨*/
SELECT name
FROM customer
WHERE customer.custid IN (SELECT orders.custid
                        FROM orders
                        GROUP BY custid
                        HAVING SUM(orders.saleprice) > (SELECT AVG(saleprice)
                                                        FROM orders))
GROUP BY name;

/*도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름-2*/
SELECT name, avg(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY name
HAVING avg(saleprice) > (SELECT avg(saleprice) 
                        FROM orders);



