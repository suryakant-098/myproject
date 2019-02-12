---------------------Trigger-----------------------------
create table EmployeeTB
(
	empNo int primary key,
	empName varchar(20),
	empDesignation varchar(20),
	empSalary int
)

drop table emp_log

create table EMPLOG
(
	id int identity,
	empNo int,
	empName varchar(20),
	empDesignation varchar(20),
	empSalary int,
	empAction varchar(30),
	ondate date
)

create trigger trg_emp
on EmployeeTB
for insert
as
begin
		declare @eno int
		declare @ename varchar(20)
		declare @edesignation varchar(20)
		declare @esal int
		set @eno=(select i.empNo from inserted i)
		set @ename=(select i.empName from inserted i)
		set @edesignation=(select i.empDesignation from inserted i)
		set @esal=(select i.empSalary from inserted i)

		insert into EMPLOG values(@eno,@ename,@edesignation,@esal,'Joined',GETDATE())
end

create trigger trg_emp_update
on EmployeeTB
for update
as
begin
		declare @eno int
		declare @ename varchar(20)
		declare @edesignation varchar(20)
		declare @esal int
		set @eno=(select i.empNo from inserted i)
		set @ename=(select i.empName from inserted i)
		set @edesignation=(select i.empDesignation from inserted i)
		set @esal=(select i.empSalary from inserted i)

		insert into EMPLOG values(@eno,@ename,@edesignation,@esal,'updated',GETDATE())
end

alter trigger trg_emp_delete
on EmployeeTB
for delete
as
begin
		declare @eno int
		declare @ename varchar(20)
		declare @edesignation varchar(20)
		declare @esal int
		set @eno=(select i.empNo from deleted i)
		set @ename=(select i.empName from deleted i)
		set @edesignation=(select i.empDesignation from deleted i)
		set @esal=(select i.empSalary from deleted i)

		insert into EMPLOG values(@eno,@ename,@edesignation,@esal,'left the job',GETDATE())
end

select * from EmployeeTB 

select * from EMPLOG where empNo=101

insert into EmployeeTB values(101, 'Nikhil','Consultant',5000)
insert into EmployeeTB values(102, 'Suraj','HR',6000)
insert into EmployeeTB values(103, 'Sagar','IT',7000)

update EmployeeTB set empSalary=empSalary+600 where empNo=101
update EmployeeTB set empName='Nikhil Shah' where empNo=101

delete from EmployeeTB where empNo=101
-------------------------------------------------------------------------------------------------------------------------------------------
create table brinfo
(
   brno int primary key,
   branchname varchar(20),
   branchcity varchar(20),
)
insert into brinfo values(101,'mahape','navi mumbai')
insert into brinfo values(102,'vitawa','mumbai')
insert into brinfo values(103,'kalwa','mumbai')

select * from brinfo
create table acinfo
(
  acno int primary key,
  acname varchar(20),
  actype varchar(20),
  acbalance int,
  acbranch int,

  constraint fk_branch foreign key(acbranch) references brinfo
)
select * from acinfo

create view view_emp
as 
 select acinfo.acno,acinfo.acname,acinfo.actype,acinfo.acbranch,acinfo.acbalance,
 brinfo.brno,brinfo.branchname,brinfo.branchcity
from acinfo join brinfo
on acinfo.acbranch=brinfo.brno

select * from view_emp


 
insert into view_emp values (501,'Kartik','saving',102,6000,102,'kalyan','mumbai')

create trigger trg_insteadof
on view_emp
instead of insert 
as 
  begin 
       declare @acno int
	   declare @acname varchar(20)
	   declare @actype varchar(20)
	   declare @acbal int
	   declare @acbranch int

	   set @acno = (select i.acno from inserted i)
	   set @acname = (select i.acname from inserted i)
       set @actype = (select i.actype from inserted i)
       set @acbal = (select i.acbalance from inserted i)
	   set @acbranch = (select i.acbranch from inserted i)

	   insert into acinfo values(@acno,@acname,@actype,@acbal,@acbranch)
end
	











