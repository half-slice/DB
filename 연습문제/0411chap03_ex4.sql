/*ex4-1 */
insert into book(bookid, bookname, publisher, price)
        values (11, '스포츠 세계', '대한미디어', 10000);

select * from book;
rollback;
/*ex4-2 삼성당에서 출판한 도서를 삭제하시오*/
delete from book
where publisher = '삼성당';

/*ex4-3 이상미디어에서 출판한 도서를 삭제하시오. 삭제가 안 되면 원인을 생각해 보시오 <== orders테이블에서 이상미디어에 관련된 책을 외래키로 지정하기 때문에 외래키 제약조건으로 삭제되지 않는다*/
delete from book
where publisher = '이상미디어';

/*ex4-4 출판사 대한미디어를 대한출판사로 이름을 바꾸시오*/
update customer 
set publisher = '대한미디어'
where publisher = '대한출판사';

/*ex4-5 */
create table bookcompany(
name varchar(20) primary key,
address varchar(20),
begin date
)
    