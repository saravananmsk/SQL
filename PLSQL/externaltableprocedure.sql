CREATE TABLE admin_ext_employees
                   (employee_id       NUMBER(4), 
                    first_name        VARCHAR2(20),
                    last_name         VARCHAR2(25), 
                    job_id            VARCHAR2(10),
                    manager_id        NUMBER(4),
                    hire_date         DATE,
                    salary            NUMBER(8,2),
                    commission_pct    NUMBER(2,2),
                    department_id     NUMBER(4),
                    email             VARCHAR2(25) 
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY DIR_TEMP
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         badfile DIR_TEMP:'empxt%a_%p.bad' 
         logfile DIR_TEMP:'empxt%a_%p.log' 
         fields terminated by ',' 
         missing field values are null 
         ( employee_id, first_name, last_name, job_id, manager_id, 
           hire_date char date_format date mask "dd-mon-yyyy", 
           salary, commission_pct, department_id, email 
         ) 
       ) 
       LOCATION ('empxt1.txt', 'empxt2.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 
-- enable parallel for loading (good if lots of data to load)
ALTER SESSION ENABLE PARALLEL DML;
-- load the data in hr employees table
INSERT INTO employees (employee_id, first_name, last_name, job_id, manager_id,
                       hire_date, salary, commission_pct, department_id, email) 
            SELECT * FROM admin_ext_employees;
commit;
