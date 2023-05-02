/*7장*/
drop table summer;

create table summer(
    sid number,
    class varchar2(20),
    price number
);

insert into summer values(100, 'fortran', 20000);
insert into summer values(150, 'pascal', 15000);
insert into summer values(200, 'c', 10000);
insert into summer values(250, 'fortran', 20000);

select * from summer;

select sid, class
from summer;

select price "c 수강료"
from summer
where class='c';

select distinct class
from summer
where price = (select max(price)
                from summer);

select count(*), sum(price)
from summer;

delete from summer
where sid=200;

select price "수강료"
from summer
where class='c';

insert into summer values(null, 'java', 25000);

select count(*) as "수강인원"
from summer;

select count(sid) as "수강인원"
from summer;

select count(*) as "수강인원"
from summer
where sid is not null;

update summer
set price=15000
where class='fortran';

select distinct price "fortran 수강료"
from  summer
where class='fortran';

update summer
set price=20000 
where class='fortran';

select *
from summer;

update summer 
set price=15000
where class='fortran' and sid=100;

drop table summer;

drop table summerprice;
drop table summerenroll;

create table summerprice(
    class varchar2(20),
    price integer
);

insert into summerprice values('fortran', 20000);
insert into summerprice values('pascal', 15000);
insert into summerprice values('c', 10000);

select *
from summerprice;

create table summerenroll(
    sid integer,
    class varchar2(20)
);

insert into summerenroll values(100, 'fortran');
insert into summerenroll values(150, 'pascal');
insert into summerenroll values(200, 'c');
insert into summerenroll values(250, 'fortran'); 

select * 
from summerenroll;

select sid, class
from summerenroll;

select price
from summerprice
where class='c';

select distinct class
from summerprice
where price=(select max(price)
            from summerprice);

select count(*), sum(price)
from summerenroll, summerprice
where summerenroll.class = summerprice.class;

select price as "수강료"
from summerprice
where class='c';

delete from summerenroll
where sid=200;

select * 
from summerenroll;

insert into summerprice values('java', 25000);

select *
from summerprice;

update summerprice
set price=15000
where class='fortran';

select price as "fortran 수강료"
from summerprice
where class='fortran';




