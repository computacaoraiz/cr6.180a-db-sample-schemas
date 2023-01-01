--
-- hr_drop.sql
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
--   hr_drop.sql: Drop objects from HR schema on a PostgreSQL database.
--
-- DESCRIPTON:
--   This script drop all objects from a HR schema on a PostgreSQL database,
--   drop the HR schema and HR user.
--
-- NOTES:
--   Please, do not run this script if you don't want to remove HR schema
--   from your PostgreSQL compraiz database. Run as postgres user:
--   psql -U postgres < hr_drop.sql


-- =============================================================================
-- Log file
-- =============================================================================
--\set ECHO all
\set ON_ERROR_STOP on
\o hr_drop.log
\qecho ****************************** hr_drop.sql ******************************

\qecho
\qecho DROP HR schema (all objects) and HR user from a PostgreSQL database:

-- Conect in compraiz database:
\c compraiz

-- Removes "HR" schema from "compraiz" database:
\qecho
\qecho Removes "HR" schema from "compraiz" database:


DROP SCHEMA IF EXISTS hr CASCADE;

-- Removes "HR" user:
\qecho
\qecho Removes "HR" user:

DROP USER IF EXISTS hr;


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho The end!
\echo
\echo The End! If you are seeing this message the "hr" schema (all objects) and
\echo the "hr" user were successfully removed from compraiz database.
\echo Even so, please check the "hr_drop.log" log file for any errors or
\echo warnings. Thanks!
