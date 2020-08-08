#!/bin/sh
echo "Test shell script for testing oracle connections"
sqlplus system/oracle@xe<<EOF
declare
a number;
err_num NUMBER;
   err_msg VARCHAR2(100);
begin
insert into test_unix values(10,'testddkgkdkgsdgfskdfklslkdflkslkfklsdlfksd');
commit;
exception
when others then
err_num := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 100);
      INSERT INTO errors VALUES (err_num, err_msg);
insert into test_unix values(2,'test');
commit;
end;
/
EOF
