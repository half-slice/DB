/*department(�μ�) table ����*/
create table department(
    deptno number not null primary key,
    deptname varchar2(20),
    manager varchar2(20)
);

/*employee(����) table  ����*/
create table employee(
    empno number not null primary key,
    name varchar2(20),
    phoneno number,
    address varchar2(20),
    sex varchar2(20),
    position varchar2(20),
    deptno number,
    foreign key(deptno) references department(deptno) on delete cascade
);

/*project(������Ʈ) table ����*/ 
create table project(
    projno number not null primary key,
    projname varchar2(20),
    deptno number,
    foreign key(deptno) references department(deptno) on delete cascade
);

/*works(�ٹ�) table ����*/
create table works(
    projno number not null,
    empno number not null, 
    hoursworked number,
    primary key(projno, empno),
    foreign key(projno) references project(projno) on delete cascade,
    foreign key(empno) references employee(empno) on delete cascade
);


/*������ ����*/
insert into department values(1,'IT', '����');
insert into department values(2,'Marketing', 'ȫ�浿');

insert into employee values(1, '�����', 01012341232, '����','��','Programmer',1);
insert into employee values(2, '�̼���', 01012323122, '����','��','Programmer',1);
insert into employee values(3, '�ڿ���', 01076851231, '����','��','Salesperson',2);
insert into employee values(4, 'ȫ�浿', 01012341546, '����','��','Manager',2);
insert into employee values(5, '����', 01012311112, '����','��','Manager',1);

insert into project values(1,'�����ͺ��̽�',1);
insert into project values(2,'��������',2);

insert into works values(1, 1, 3);
insert into works values(1, 2, 1);
insert into works values(2, 3, 1);
insert into works values(2, 4, 5);
insert into works values(1, 5, 1);

