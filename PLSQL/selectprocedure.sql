create or replace procedure dual_test as
X varchar2(20);
begin
select * into x from dual;
dbms_output.put_line('the value of x' is ||x) ;
end;
/
