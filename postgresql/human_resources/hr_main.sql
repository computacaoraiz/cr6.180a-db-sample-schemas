--
-- hr_main.sql
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
--   hr_main.sql: creates an adaptation of the Oracle Human Resources (HR)
--                schema into a PostgreSQL database.
--
-- DESCRIPTON:
--   This script is a PostgreSQL adaptation of the original Oracle Human
--   Resources (HR) Schema, for the Computação Raiz Course CR6.180A
--   (https://cursos.computacaoraiz.com.br).
--
-- NOTES:
--   Run as POSTGRES, eg.:
--   psql -U postgres -d postgres < hr_main.sql


-- =============================================================================
-- Log file
-- =============================================================================
--\set ECHO all
\set ON_ERROR_STOP on
\o hr_main.log


-- =============================================================================
-- Limpeza geral (cleanup section)
-- =============================================================================
-- Remove o schema "hr" do banco "compraiz", se existir:
\qecho
\qecho Remove o schema "hr" do banco "compraiz", se existir:
\c compraiz
DROP SCHEMA IF EXISTS hr CASCADE;

-- Remove o usuário "hr", se existir
\qecho
\qecho Remove o usuário "hr", se existir:
DROP USER IF EXISTS hr;


-- =============================================================================
-- Cria usuário hr
-- =============================================================================
-- Cria o usuário "hr":
\qecho
\qecho Cria o usuário "hr":
CREATE USER hr WITH
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  LOGIN
  NOREPLICATION
  NOBYPASSRLS
  CONNECTION LIMIT -1
  ENCRYPTED PASSWORD 'hr';

COMMENT ON ROLE hr IS 'Usuário para o schema HR, adaptado do Oracle.';


-- =============================================================================
-- Criação do schema HR
-- =============================================================================
-- Criação do schema HR:
\qecho
\qecho Criação do schema HR:
CREATE SCHEMA hr AUTHORIZATION hr;

COMMENT ON SCHEMA hr IS 'Human Resources (HR) Schema.';


-- =============================================================================
-- Conexão ao banco compraiz com usuário hr
-- =============================================================================
-- Conexão ao banco compraiz:
\qecho
\qecho Conexão ao banco de dados compraiz:
\c "dbname=compraiz user=hr password=hr"


-- =============================================================================
-- Cria tabela REGIONS
-- =============================================================================
-- Create the REGIONS table to hold region information for locations
-- HR.LOCATIONS table has a foreign key to this table.
\qecho
\qecho Creating REGIONS table:
CREATE TABLE regions (
  region_id   INTEGER     CONSTRAINT region_id_nn NOT NULL,
  region_name VARCHAR(25)
);

ALTER TABLE regions ADD CONSTRAINT reg_id_pk
PRIMARY KEY (region_id);


-- =============================================================================
-- Cria tabela COUNTRIES
-- =============================================================================
-- Create the COUNTRIES table to hold country information for customers
-- and company locations. 
-- OE.CUSTOMERS table and HR.LOCATIONS have a foreign key to this table.
--
-- Originally this table uses organization index, but PostgreSQL does not have
-- this functionality.
\qecho
\qecho Creating COUNTRIES table:
CREATE TABLE countries (
  country_id   CHAR(2)      CONSTRAINT country_id_nn NOT NULL,
  country_name VARCHAR(40),
  region_id    INTEGER
);

ALTER TABLE countries ADD CONSTRAINT country_c_id_pk
PRIMARY KEY (country_id);

ALTER TABLE countries ADD CONSTRAINT countr_reg_fk
FOREIGN KEY (region_id) REFERENCES regions(region_id);


-- =============================================================================
-- Cria tabela LOCATIONS
-- =============================================================================
-- Create the LOCATIONS table to hold address information for company
-- departments.
-- HR.DEPARTMENTS has a foreign key to this table.
\qecho
\qecho Creating LOCATIONS table:
CREATE TABLE locations (
  location_id    INTEGER,
  street_address VARCHAR(40),
  postal_code    VARCHAR(12),
  city           VARCHAR(30) CONSTRAINT loc_city_nn NOT NULL,
  state_province VARCHAR(25),
  country_id     CHAR(2)
);

ALTER TABLE locations ADD CONSTRAINT loc_id_pk
PRIMARY KEY (location_id);

ALTER TABLE locations ADD CONSTRAINT loc_c_id_fk
FOREIGN KEY (country_id) REFERENCES countries(country_id);

-- Useful for any subsequent addition of rows to locations table
-- Starts with 3300
CREATE SEQUENCE locations_seq
  START WITH   3300
  INCREMENT BY  100
  MAXVALUE     9900
  CACHE           1
  NO CYCLE;


-- =============================================================================
-- Cria tabela DEPARTMENTS
-- =============================================================================
-- Create the DEPARTMENTS table to hold company department information.
-- HR.EMPLOYEES and HR.JOB_HISTORY have a foreign key to this table.
\qecho
\qecho Creating DEPARTMENTS table:
CREATE TABLE departments (
  department_id   INTEGER,
  department_name VARCHAR(30) CONSTRAINT dept_name_nn NOT NULL,
  manager_id      INTEGER,
  location_id     INTEGER
);

ALTER TABLE departments ADD CONSTRAINT dept_id_pk
PRIMARY KEY (department_id);

ALTER TABLE departments ADD CONSTRAINT dept_loc_fk
FOREIGN KEY (location_id) REFERENCES locations (location_id);

-- Useful for any subsequent addition of rows to departments table
-- Starts with 280
CREATE SEQUENCE departments_seq
  START WITH    280
  INCREMENT BY   10
  MAXVALUE     9990
  CACHE           1
  NO CYCLE;


-- =============================================================================
-- Cria tabela JOBS
-- =============================================================================
-- Create the JOBS table to hold the different names of job roles within the
-- company.
-- HR.EMPLOYEES has a foreign key to this table.
\qecho
\qecho Creating JOBS table:
CREATE TABLE jobs (
  job_id     VARCHAR(10),
  job_title  VARCHAR(35) CONSTRAINT job_title_nn NOT NULL,
  min_salary INTEGER,
  max_salary INTEGER
);

ALTER TABLE jobs ADD CONSTRAINT job_id_pk
PRIMARY KEY(job_id);


-- =============================================================================
-- Cria tabela EMPLOYEES
-- =============================================================================
-- Create the EMPLOYEES table to hold the employee personnel 
-- information for the company.
-- HR.EMPLOYEES has a self referencing foreign key to this table.
\qecho
\qecho Creating EMPLOYEES table:
CREATE TABLE employees (
  employee_id    INTEGER,
  first_name     VARCHAR(20),
  last_name      VARCHAR(25)  CONSTRAINT emp_last_name_nn NOT NULL,
  email          VARCHAR(25)  CONSTRAINT emp_email_nn     NOT NULL,
  phone_number   VARCHAR(20),
  hire_date      DATE         CONSTRAINT emp_hire_date_nn NOT NULL,
  job_id         VARCHAR(10)  CONSTRAINT emp_job_nn       NOT NULL,
  salary         DECIMAL(8,2),
  commission_pct DECIMAL(2,2),
  manager_id     INTEGER,
  department_id  INTEGER
);

ALTER TABLE employees ADD CONSTRAINT emp_emp_id_pk
PRIMARY KEY (employee_id);

CREATE UNIQUE INDEX emp_email_uk
ON employees (email);

ALTER TABLE employees ADD CONSTRAINT emp_dept_fk
FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE employees ADD CONSTRAINT emp_job_fk
FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE employees ADD CONSTRAINT emp_manager_fk
FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE departments ADD CONSTRAINT dept_mgr_fk
FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE employees ADD CONSTRAINT emp_salary_min
CHECK(salary > 0);

-- Useful for any subsequent addition of rows to employees table
-- Starts with 207 
CREATE SEQUENCE employees_seq
  START WITH   207
  INCREMENT BY   1
  CACHE          1
  NO CYCLE;


-- =============================================================================
-- Cria tabela JOB_HISTORY
-- =============================================================================
-- Create the JOB_HISTORY table to hold the history of jobs that 
-- employees have held in the past.
-- HR.JOBS, HR_DEPARTMENTS, and HR.EMPLOYEES have a foreign key to this table.
\qecho
\qecho Creating JOB_HISTORY table:
CREATE TABLE job_history (
  employee_id   INTEGER     CONSTRAINT jhist_employee_nn   NOT NULL,
  start_date    DATE        CONSTRAINT jhist_start_date_nn NOT NULL,
  end_date      DATE        CONSTRAINT jhist_end_date_nn   NOT NULL,
  job_id        VARCHAR(10) CONSTRAINT jhist_job_nn        NOT NULL,
  department_id INTEGER
);

ALTER TABLE job_history ADD CONSTRAINT jhist_emp_id_st_date_pk
PRIMARY KEY (employee_id, start_date);

ALTER TABLE job_history ADD CONSTRAINT jhist_job_fk
FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE job_history ADD CONSTRAINT jhist_emp_fk
FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

ALTER TABLE job_history ADD CONSTRAINT jhist_dept_fk
FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE job_history ADD CONSTRAINT jhist_date_interval
CHECK (end_date > start_date);


-- =============================================================================
-- Cria view EMP_DETAILS_VIEW
-- =============================================================================
-- Create the EMP_DETAILS_VIEW that joins the employees, jobs, 
-- departments, jobs, countries, and locations table to provide details
-- about employees.
--
-- Originally this view uses the WITH READ ONLY option, but PostgreSQL does not
-- have this functionality.
\qecho
\qecho Creating EMP_DETAILS_VIEW view:
CREATE OR REPLACE VIEW emp_details_view (
  employee_id,
  job_id,
  manager_id,
  department_id,
  location_id,
  country_id,
  first_name,
  last_name,
  salary,
  commission_pct,
  department_name,
  job_title,
  city,
  state_province,
  country_name,
  region_name
) AS
SELECT e.employee_id
     , e.job_id
     , e.manager_id
     , e.department_id
     , d.location_id
     , l.country_id
     , e.first_name
     , e.last_name
     , e.salary
     , e.commission_pct
     , d.department_name
     , j.job_title
     , l.city
     , l.state_province
     , c.country_name
     , r.region_name
FROM employees e
   , departments d
   , jobs j
   , locations l
   , countries c
   , regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id 
;


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Fim.
\echo
\echo Fim! Se você está vendo esta mensagem o schema "hr" foi criado com
\echo sucesso. Mesmo assim, por favor, verifique o arquivo de log
\echo "hr.log" em busca de erros ou avisos. Obrigado!

