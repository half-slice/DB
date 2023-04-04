/*왼쪽 외부 조인*/
SELECT name,saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid = orders.custid;

/*왼쪽 외부 조인(+)*/
SELECT customer.name, saleprice
FROM customer, orders
WHERE customer.custid = orders.custid(+);

/*가장 비싼 도서의 가격 표시*/
SELECT MAX(price)
FROM book;

/*가장 비싼 도서의 이름*/
SELECT bookname
FROM book
WHERE price=35000;

/*가장 비싼 도서의 이름*/
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price)
            FROM book);
            
/*도서를 주문한적이 있는 고객 아이디 찾기*/
SELECT custid
FROM orders;

/*고객 아이디에 해당하는 고객 이름 찾기*/
SELECT name
FROM customer
WHERE customer.custid IN (1,2,3,4);
            
/*도서를 주문한 적이 있는 고객의 이름*/
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                    FROM orders);


SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
                FROM book b2    
                WHERE b2.publisher = b1.publisher);





