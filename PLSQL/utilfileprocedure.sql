declare 
  fhandle  utl_file.file_type;
begin
  fhandle := utl_file.fopen(
                'c:\temp'     -- File location
              , 'test_file.txt' -- File name
              , 'w' -- Open mode: w = write. 
                  );

  utl_file.put(fhandle, 'Hello world!'
                      || CHR(10));
  utl_file.put(fhandle, 'Hello again!');

  utl_file.fclose(fhandle);
exception
  when others then 
    dbms_output.put_line('ERROR: ' || SQLCODE 
                      || ' - ' || SQLERRM);
    raise;
end;
/
