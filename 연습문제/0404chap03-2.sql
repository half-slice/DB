/*ex1-5 박지성이 구매한 도서의 출판사 수*/
SELECT COUNT(DISTINCT publisher)
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid=book.bookid AND customer.name like '박지성';

/*ex1-6 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이*/
SELECT bookname, price, price-saleprice
FROM customer, orders, book
WHERE customer.custid=orders.custid AND orders.bookid=book.bookid AND customer.name LIKE '박지성';

/*ex1-7 박지성이 구매하지 않은 도서의 이름*/
SELECT bookname
FROM book
WHERE NOT EXISTS (SELECT bookname
                    FROM customer, orders
                    WHERE customer.custid = orders.custid AND orders.bookid = book.bookid AND customer.name like '박지성');
