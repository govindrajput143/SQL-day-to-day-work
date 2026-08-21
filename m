use newdb;

start transaction ;
delete from department7;
 rollback;
 select * from department;
 
 select transaction;
 insert into department7 values (105,'asdfasd', 'jaipasdflkasdjfur');
  savepoint department_insert_chk1; -- creating a reference point to revert to this transaction only
  delete from department7 where dept_id=103;
  
rollback to department_insert_chk1 ;

select * from department;


start transaction;
insert into department value( 999999,'asdfg', 'jaipasdflkasdjful');

create table ajkslhfdash(id int); -- ddl statement end transaction here





-- data control language
-- authentication and authorization


create user govind identified by 'govind123';



show grants for govind;
grant select on newdb.* to govind;
