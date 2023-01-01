--
-- hr_analz.sql
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
--   hr_analz.sql: Gathering statistics for HR schema on a PostgreSQL database.
--
-- DESCRIPTON:
--   This script analyzes several tables and gather statistics for HR schema
--   on a PostgreSQL database.
--
-- NOTES:
--   Please, do not run this script directly. Run the main script, eg.:
--   psql -U postgres -d postgres < hr_main.sql

\qecho
\qecho Create Analyze HR schema tables on a PostgreSQL database:


-- =============================================================================
-- Analyze HR schema tables
-- =============================================================================
ANALYZE VERBOSE countries;
ANALYZE VERBOSE departments;
ANALYZE VERBOSE employees;
ANALYZE VERBOSE job_history;
ANALYZE VERBOSE jobs;
ANALYZE VERBOSE locations;
ANALYZE VERBOSE regions;


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Tables analyzed.
