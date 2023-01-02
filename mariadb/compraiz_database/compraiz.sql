--
-- compraiz.sql
--
-- Copyright (c) 2022, Computação Raiz. All rights reserved.
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
--   compraiz.sql: script for compraiz database (MariaDB/MySQL) and
--   computacao user.
--
-- DESCRIPTON:
--   compraiz is the main MariaDB/MySQL database for the Computação Raiz
--   Course CR6.180A (https://cursos.computacaoraiz.com.br).
--
-- NOTES:
--   Run as ROOT, eg.:
--   mysql -u root -p --force < compraiz.sql


-- =============================================================================
-- Log file
-- =============================================================================
tee compraiz.log
\! echo "****************************** hr_main.sql ******************************" >> compraiz.log


-- =============================================================================
-- Cleanup section
-- =============================================================================
-- Revoke all privileges from computacao user:
\! echo " " >> compraiz.log
\! echo "Revoke all privileges from computacao user (error if computacao user not exists)" >> compraiz.log
REVOKE ALL PRIVILEGES, GRANT OPTION FROM computacao;

-- Drop computacao user:
\! echo " " >> compraiz.log
\! echo "Drop computacao user:" >> compraiz.log
DROP USER IF EXISTS computacao;

-- Drop database compraiz:
\! echo " " >> compraiz.log
\! echo "Drop compraiz database:" >> compraiz.log
DROP DATABASE IF EXISTS compraiz;


-- =============================================================================
-- Create compraiz database
-- =============================================================================
-- Create compraiz database:
\! echo " " >> compraiz.log
\! echo "Create compraiz database:" >> compraiz.log
CREATE DATABASE compraiz
  CHARACTER SET 'utf8mb4'
  COLLATE 'utf8mb4_bin' 
  COMMENT 'Banco de dados compraiz.';


-- =============================================================================
-- Creates computacao user and make grants
-- =============================================================================
-- Create computacao user
\! echo " " >> compraiz.log
\! echo "Create computacao user:" >> compraiz.log
CREATE USER computacao
  IDENTIFIED BY 'raiz';

-- Grants on compraiz database to computacao user
\! echo " " >> compraiz.log
\! echo "Grants on compraiz database to computacao user:" >> compraiz.log
GRANT ALL PRIVILEGES ON compraiz.*
  TO 'computacao'@'%'
  WITH GRANT OPTION;
FLUSH PRIVILEGES;


-- =============================================================================
-- DUAL table on compraiz database to simualte Oracle SYS.DUAL.
-- =============================================================================
\! echo " " >> compraiz.log
\! echo "MariaDB alredy have a DUAL table simualte Oracle SYS.DUAL. Nothing to do." >> compraiz.log


-- =============================================================================
-- Finalização
-- =============================================================================
\! echo " " >> compraiz.log
\! echo "The End!" >> compraiz.log
\! echo " "
\! echo "The End! If you are seeing this message the 'compraiz' database was
\! echo "successfully created. Even so, please check the 'compraiz.log' log file"
\! echo "for any errors or warnings. Thanks!"

