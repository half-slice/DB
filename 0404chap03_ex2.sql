/*�������� ������ ������ ���ǻ� ��*/
SELECT COUNT(DISTINCT publisher)
FROM book
WHERE bookid IN (SELECT bookid
                    FROM orders
                    WHERE custid = (SELECT custid
                                    FROM customer
                                    WHERE name = '������'));
                                    
/*�������� ������ ������ ���ǻ� ��-2*/
SELECT COUNT(DISTINCT publisher)
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid=book.bookid AND customer.name like '������';

/*�������� ������ ������ �̸�, ����, ������ �ǸŰ����� ���� book.price = ���� / orders.saleprice = �ǸŰ�*/
SELECT bookname, price, saleprice, price-saleprice AS ��������
FROM book, orders
WHERE book.bookid = orders.bookid AND orders.custid = (SELECT custid
                                                FROM customer
                                                WHERE name = '������');

/*�������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����-2 book.price = ���� / orders.saleprice = �ǸŰ�*/
SELECT bookname, price, price-saleprice
FROM customer, orders, book
WHERE customer.custid=orders.custid AND orders.bookid=book.bookid AND customer.name LIKE '������';


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

/*�������� �������� ���� ������ �̸�-2 / ������� = �������ǿ��� book���̺��� ��������Ƿ� �������ǿ��� book�� ����� �ʿ�� ����*/
SELECT bookname
FROM book
WHERE NOT EXISTS (SELECT bookname
                    FROM customer, orders
                    WHERE customer.custid = orders.custid AND orders.bookid = book.bookid AND customer.name like '������');

/*�ֹ����� ���� ���� �̸�(�μ����� ���)*/
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                FROM orders);
                
/*�ֹ����� ���� ���� �̸�(�μ����� ���)-2*/
SELECT name
FROM customer
WHERE name NOT IN(SELECT name
            FROM orders
            WHERE customer.custid = orders.custid);


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
                                
/*���� �̸��� ���� ������ ���� ���-2*/
SELECT name, bookname
FROM customer ,book, orders
WHERE customer.custid = orders.custid AND book.bookid = orders.bookid;

/*������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�*/
SELECT *
FROM orders
WHERE orders.orderid = (SELECT orders.orderid
                    FROM orders, book
                    WHERE orders.bookid = book.bookid AND (book.price - orders.saleprice) = (SELECT MAX(book.price - orders.saleprice)
                                                                                            FROM book, orders
                                                                                            WHERE orders.bookid = book.bookid));

/*������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�-2*/
SELECT *
FROM book, orders
WHERE book.bookid = orders.bookid AND price-saleprice = (SELECT MAX(book.price-saleprice)
                                                        FROM book, orders
                                                        WHERE book.bookid = orders.bookid);

/*������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸� HAVING���� ���ǿ� SUM, COUNT���� �����ִ� ��� �տ� GROUP BY�� ����ߵ�*/
SELECT name
FROM customer
WHERE customer.custid IN (SELECT orders.custid
                        FROM orders
                        GROUP BY custid
                        HAVING SUM(orders.saleprice) > (SELECT AVG(saleprice)
                                                        FROM orders))
GROUP BY name;

/*������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�-2*/
SELECT name, avg(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY name
HAVING avg(saleprice) > (SELECT avg(saleprice) 
                        FROM orders);



