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
\qecho ****************************** hr_main.sql ******************************


-- =============================================================================
-- Cleanup section
-- =============================================================================

-- Removes "HR" schema from "compraiz" database:
\qecho
\qecho Removes "HR" schema from "compraiz" database:
\c compraiz

DROP SCHEMA IF EXISTS hr CASCADE;

-- Removes "HR" user:
\qecho
\qecho Removes "HR" user:

DROP USER IF EXISTS hr;


-- =============================================================================
-- HR user
-- =============================================================================

-- Create "HR" user:
\qecho
\qecho Create "HR" user:

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

COMMENT ON ROLE hr IS 'HR user, owner of HR schema.';


-- =============================================================================
-- HR schema
-- =============================================================================

-- Create HR schema:
\qecho
\qecho Create HR schema:
CREATE SCHEMA hr AUTHORIZATION hr;

COMMENT ON SCHEMA hr IS 'Human Resources (HR) Schema.';


-- =============================================================================
-- Database connection
-- =============================================================================
-- Connect as hr user on compraiz database:
\qecho
\qecho Connect as hr user on compraiz database:
\c "dbname=compraiz user=hr password=hr"


-- =============================================================================
-- Schema objects
-- =============================================================================
-- Execute hr_cre.sql script:
\qecho
\qecho ****************************** hr_cre.sql *******************************
\i hr_cre.sql


-- =============================================================================
-- Populate tables
-- =============================================================================
-- Execute hr_popul.sql script:
\qecho
\qecho ****************************** hr_popul.sql *****************************
\i hr_popul.sql


-- =============================================================================
-- Create indexes on some tables
-- =============================================================================
-- Execute hr_idx.sql script:
\qecho
\qecho ****************************** hr_idx.sql *******************************
\i hr_idx.sql


-- =============================================================================
-- Create procedural objects
-- =============================================================================
-- Execute hr_code.sql script:
\qecho
\qecho ****************************** hr_code.sql ******************************
\i hr_code.sql


-- =============================================================================
-- Comments for table and columns
-- =============================================================================
-- Execute hr_comnt.sql script:
\qecho
\qecho ****************************** hr_comnt.sql *****************************
\i hr_comnt.sql


-- =============================================================================
-- Analyze schema tables
-- =============================================================================
-- Execute hr_analz.sql script:
\qecho
\qecho ****************************** hr_analz.sql *****************************
\i hr_analz.sql


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho ****************************** hr_main.sql ******************************
\qecho
\qecho The end!
\echo
\echo The End! If you are seeing this message the schema "hr" was successfully
\echo created. Even so, please check the "hr.log" log file for any errors or
\echo warnings. Thanks!
