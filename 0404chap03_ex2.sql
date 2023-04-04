/*�������� ������ ������ ���ǻ� ��*/
SELECT COUNT(publisher)
FROM book
WHERE bookid IN (SELECT bookid
                    FROM orders
                    WHERE custid = (SELECT custid
                                    FROM customer
                                    WHERE name = '������'));

/*�������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����*/
SELECT bookname, price, price-saleprice AS ��������
FROM book, orders
WHERE book.bookid = orders.bookid AND orders.custid = (SELECT custid
                                                FROM customer
                                                WHERE name = '������');

/*�������� �������� ���� ������ �̸�*/
SELECT bookname
FROM book
MINUS
SELECT bookname
FROM book
WHERE bookid IN (SELECT bookid 
                FROM orders
                WHERE custid = (SELECT custid
                                FROM customer
                                WHERE name LIKE '������'));

/*�ֹ����� ���� ���� �̸�(�μ����� ���)*/
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                FROM orders);

/*�ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�*/
SELECT SUM(saleprice), AVG(saleprice)
FROM orders;

/*���� �̸��� ���� ���ž�*/
SELECT name, SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid(+)
GROUP BY name;

/*���� �̸��� ���� ������ ���� ���*/
SELECT name, bookname
FROM customer LEFT OUTER JOIN book
                ON book.bookid IN (SELECT bookid
                                FROM orders
                                WHERE orders.custid = customer.custid);

/*������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�*/
SELECT *
FROM orders
WHERE orders.orderid = (SELECT orders.orderid
                    FROM orders, book
                    WHERE orders.bookid = book.bookid AND (book.price - orders.saleprice) = (SELECT MAX(book.price - orders.saleprice)
                                                                                            FROM book, orders
                                                                                            WHERE orders.bookid = book.bookid));

/*������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�*/
SELECT name
FROM customer
WHERE customer.custid IN (SELECT orders.custid
                        FROM orders
                        GROUP BY custid
                        HAVING SUM(orders.saleprice) > (SELECT AVG(saleprice)
                                                        FROM orders))
GROUP BY name;