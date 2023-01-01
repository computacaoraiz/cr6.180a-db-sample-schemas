--
-- hr_idx.sql
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
--   hr_idx.sql: Create indexes for HR schema on a PostgreSQL database.
--
-- DESCRIPTON:
--   This script creates, on a PostgreSQL database, some idexes in the
--   human resources (HR) schema.
--
-- NOTES:
--   Please, do not run this script directly. Run the main script, eg.:
--   psql -U postgres -d postgres < hr_main.sql

\qecho
\qecho Create indexes HR schema on a PostgreSQL database:


-- =============================================================================
-- Indexes on EMPLOYEES table
-- =============================================================================
CREATE INDEX emp_department_ix
ON employees (department_id);

CREATE INDEX emp_job_ix
ON employees (job_id);

CREATE INDEX emp_manager_ix
ON employees (manager_id);

CREATE INDEX emp_name_ix
ON employees (last_name, first_name);


-- =============================================================================
-- Indexes on DEPARTMENTS table
-- =============================================================================
CREATE INDEX dept_location_ix
ON departments (location_id);


-- =============================================================================
-- Indexes on JOB_HISTORY table
-- =============================================================================
CREATE INDEX jhist_job_ix
ON job_history (job_id);

CREATE INDEX jhist_employee_ix
ON job_history (employee_id);

CREATE INDEX jhist_department_ix
ON job_history (department_id);


-- =============================================================================
-- Indexes on LOCATIONS table
-- =============================================================================
CREATE INDEX loc_city_ix
ON locations (city);

CREATE INDEX loc_state_province_ix	
ON locations (state_province);

CREATE INDEX loc_country_ix
ON locations (country_id);


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Indexes created.

