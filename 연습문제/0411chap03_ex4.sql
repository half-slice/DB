/*ex4-1 */
insert into book(bookid, bookname, publisher, price)
        values (11, '������ ����', '���ѹ̵��', 10000);

select * from book;
rollback;
/*ex4-2 �Ｚ�翡�� ������ ������ �����Ͻÿ�*/
delete from book
where publisher = '�Ｚ��';

/*ex4-3 �̻�̵��� ������ ������ �����Ͻÿ�. ������ �� �Ǹ� ������ ������ ���ÿ� <== orders���̺��� �̻�̵� ���õ� å�� �ܷ�Ű�� �����ϱ� ������ �ܷ�Ű ������������ �������� �ʴ´�*/
delete from book
where publisher = '�̻�̵��';

/*ex4-4 ���ǻ� ���ѹ̵� �������ǻ�� �̸��� �ٲٽÿ�*/
update customer 
set publisher = '���ѹ̵��'
where publisher = '�������ǻ�';

/*ex4-5 */
create table bookcompany(
name varchar(20) primary key,
address varchar(20),
begin date
)
    