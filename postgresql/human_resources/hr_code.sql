--
-- hr_code.sql
--
-- Copyright (c) 2001, 2015, Oracle and/or its affiliates.  All rights reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- OWNER: Computação Raiz
--        https://www.computacaoraiz.com.br
--
-- NAME:
--   hr_code.sql: Create PostgreSQL procedural objects for HR schema.
--
-- DESCRIPTON:
--   This script creates, on a PostgreSQL database, the procedural objects
--   needed by human resources (HR) schema.
--
-- NOTES:
--   Please, do not run this script directly. Run the main script, eg.:
--   psql -U postgres -d postgres < hr_main.sql

\qecho
\qecho Create procedural objects for HR schema on a PostgreSQL database:


-- =============================================================================
-- EMPLOYEES table: secutiry trigger function and trigger
-- =============================================================================
\qecho
\qecho Creating security trigger function and trigger or EMPLOYEES table:

CREATE OR REPLACE FUNCTION secure_dml()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS
$$
BEGIN
   IF    TO_CHAR(NOW(), 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
      OR TO_CHAR(NOW(), 'D') IN (1, 7)
   THEN
 	RAISE EXCEPTION 'You may only make changes during normal office hours'
          USING ERRCODE = 20205;
   END IF;
END;
$$;

CREATE OR REPLACE TRIGGER secure_employees
  BEFORE INSERT OR UPDATE OR DELETE OR TRUNCATE ON employees
  EXECUTE FUNCTION secure_dml();

-- The trigger is initially disabled
ALTER TABLE employees
DISABLE TRIGGER secure_employees;


-- =============================================================================
-- Populate JOB_HISTORY table: trigger function and trigger for EMPLOYEES table
-- =============================================================================
-- procedure to add a row to the JOB_HISTORY table and row trigger 
-- to call the procedure when data is updated in the job_id or 
-- department_id columns in the EMPLOYEES table:
\qecho
\qecho Creating populate JOB_HISTORY table: trigger function and trigger
\qecho for EMPLOYEES table:

CREATE OR REPLACE FUNCTION add_job_history()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS
$$
BEGIN
  INSERT INTO job_history
    ( employee_id
    , start_date
    , end_date
    , job_id
    , department_id
    )
  VALUES
    ( new.emp_id
    , new.start_date
    , new.end_date
    , new.job_id
    , new.department_id
    );
  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER update_job_history
  AFTER UPDATE OF job_id, department_id ON employees
  FOR EACH ROW
  EXECUTE FUNCTION add_job_history();


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Procedural objects created.

