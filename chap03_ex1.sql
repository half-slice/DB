/*������ȣ�� 1�� ������ �̸�*/
SELECT bookname 
FROM Book
WHERE price>=20000;

/*������ 20000�� �̻��� ������ �̸�*/
SELECT bookname 
FROM Book
WHERE price>=20000;

/*�������� �ѱ��ž�*/
SELECT SUM(saleprice)
FROM orders
WHERE custid=1;

/*�������� �ѱ��ž�2*/
SELECT SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid AND customer.name LIKE '������';

/*�������� ������ ������ ��*/
SELECT COUNT(*)
FROM customer, orders
WHERE customer.custid = orders.custid AND customer.name LIKE '������';

/*�������� ������ ������ ���ǻ��� ��*/
SELECT COUNT(publisher)
FROM book, customer, orders
WHERE book.bookid = orders.bookid AND customer.custid = orders.custid AND customer.name LIKE '������';



