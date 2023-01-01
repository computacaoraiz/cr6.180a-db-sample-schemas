--
-- hr_cmnt.sql
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
--   hr_cmnt.sql: Create comments for HR schema on a PostgreSQL database
--
-- DESCRIPTON:
--   This script creates, on a PostgreSQL database, the comments for
--   HR schema on a PostgreSQL database.
--
-- NOTES:
--   Please, do not run this script directly. Run the main script, eg.:
--   psql -U postgres -d postgres < hr_main.sql

\qecho
\qecho Create comments for HR schema on a PostgreSQL database:


-- =============================================================================
-- REGIONS table
-- =============================================================================
\qecho
\qecho Creating comments for REGIONS table:

COMMENT ON TABLE regions 
IS 'Regions table that contains region numbers and names.
Contains 4 rows; references with the Countries table.';

COMMENT ON COLUMN regions.region_id
IS 'Primary key of regions table.';

COMMENT ON COLUMN regions.region_name
IS 'Names of regions. Locations are in the countries of these regions.';


-- =============================================================================
-- LOCATIONS table
-- =============================================================================
\qecho
\qecho Creating comments for LOCATIONS table:

COMMENT ON TABLE locations
IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables.';

COMMENT ON COLUMN locations.location_id
IS 'Primary key of locations table.';

COMMENT ON COLUMN locations.street_address
IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name.';

COMMENT ON COLUMN locations.postal_code
IS 'Postal code of the location of an office, warehouse, or production site 
of a company.';

COMMENT ON COLUMN locations.city
IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located.';

COMMENT ON COLUMN locations.state_province
IS 'State or Province where an office, warehouse, or production site of a 
company is located.';

COMMENT ON COLUMN locations.country_id
IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';


-- =============================================================================
-- DEPARTMENTS table
-- =============================================================================
\qecho
\qecho Creating comments for DEPARTMENTS table:

COMMENT ON TABLE departments
IS 'Departments table that shows details of departments where employees 
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN departments.department_id
IS 'Primary key column of departments table.';

COMMENT ON COLUMN departments.department_name
IS 'A not null column that shows name of a department. Administration, 
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public 
Relations, Sales, Finance, and Accounting.';

COMMENT ON COLUMN departments.manager_id
IS 'Manager_id of a department. Foreign key to employee_id column of employees table.
The manager_id column of the employee table references this column.';

COMMENT ON COLUMN departments.location_id
IS 'Location id where a department is located.
Foreign key to location_id column of locations table.';


-- =============================================================================
-- JOB_HISTORY table
-- =============================================================================
\qecho
\qecho Creating comments for JOB_HISTORY table:

COMMENT ON TABLE job_history
IS 'Table that stores job history of the employees. If an employee 
changes departments within the job or changes jobs within the department, 
new rows get inserted into this table with old job information of the 
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN job_history.employee_id
IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table.';

COMMENT ON COLUMN job_history.start_date
IS 'A not null column in the complex primary key employee_id+start_date. 
Must be less than the end_date of the job_history table (enforced by 
constraint jhist_date_interval).';

COMMENT ON COLUMN job_history.end_date
IS 'Last day of the employee in this job role. A not null column. Must be 
greater than the start_date of the job_history table 
(enforced by constraint jhist_date_interval).';

COMMENT ON COLUMN job_history.job_id
IS 'Job role in which the employee worked in the past; foreign key to 
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN job_history.department_id
IS 'Department id in which the employee worked in the past;
foreign key to deparment_id column in the departments table.';


-- =============================================================================
-- COUNTRIES table
-- =============================================================================
\qecho
\qecho Creating comments for COUNTRIES table:

COMMENT ON TABLE countries
IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN countries.country_id
IS 'Primary key of countries table.';

COMMENT ON COLUMN countries.country_name
IS 'Country name.';

COMMENT ON COLUMN countries.region_id
IS 'Region ID for the country.
Foreign key to region_id column in the departments table.';


-- =============================================================================
-- JOBS table
-- =============================================================================
\qecho
\qecho Creating comments for JOBS table:

COMMENT ON TABLE jobs
IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN jobs.job_id
IS 'Primary key of jobs table.';

COMMENT ON COLUMN jobs.job_title
IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT.';

COMMENT ON COLUMN jobs.min_salary
IS 'Minimum salary for a job title.';

COMMENT ON COLUMN jobs.max_salary
IS 'Maximum salary for a job title.';


-- =============================================================================
-- EMPLOYEES table
-- =============================================================================
\qecho
\qecho Creating comments for EMPLOYEES table:

COMMENT ON TABLE employees
IS 'employees table. Contains 107 rows. References with departments, 
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN employees.employee_id
IS 'Primary key of employees table.';

COMMENT ON COLUMN employees.first_name
IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN employees.last_name
IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN employees.email
IS 'Email id of the employee.';

COMMENT ON COLUMN employees.phone_number
IS 'Phone number of the employee; includes country code and area code.';

COMMENT ON COLUMN employees.hire_date
IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN employees.job_id
IS 'Current job of the employee; foreign key to job_id column of the 
jobs table. A not null column.';

COMMENT ON COLUMN employees.salary
IS 'Monthly salary of the employee. Must be greater 
than zero (enforced by constraint emp_salary_min).';

COMMENT ON COLUMN employees.commission_pct
IS 'Commission percentage of the employee; Only employees in sales 
department elgible for commission percentage.';

COMMENT ON COLUMN employees.manager_id
IS 'Manager id of the employee; has same domain as manager_id in 
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query).';

COMMENT ON COLUMN employees.department_id
IS 'Department id where employee works; foreign key to department_id 
column of the departments table.';


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Comments for tables created.

