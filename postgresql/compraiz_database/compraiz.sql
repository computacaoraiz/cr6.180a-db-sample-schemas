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
--   compraiz.sql: script for compraiz database (PostgreSQL) and
--   computacao user.
--
-- DESCRIPTON:
--   compraiz is the main PostgreSQL database for the Computação Raiz
--   Course CR6.180A (https://cursos.computacaoraiz.com.br).
--
-- NOTES:
--   Run as POSTGRES, eg.:
--   psql -U postgres -d postgres < compraiz.sql


-- =============================================================================
-- Log file
-- =============================================================================
--\set ECHO all
\set ON_ERROR_STOP on
\o compraiz.log


-- =============================================================================
-- Limpeza geral (cleanup section)
-- =============================================================================
-- Remove o banco de dados "compraiz", se existir
\qecho
\qecho Remove o banco de dados "compraiz", se existir:
DROP DATABASE IF EXISTS compraiz;

-- Remove o usuário "computacao", se existir
\qecho
\qecho Remove o usuário "computacao", se existir:
DROP USER IF EXISTS computacao;


-- =============================================================================
-- Cria usuário e banco de dados
-- =============================================================================
-- Cria o usuário "computacao":
\qecho
\qecho Cria o usuário "computacao":
CREATE USER computacao WITH
  NOSUPERUSER
  CREATEDB
  CREATEROLE
  INHERIT
  LOGIN
  NOREPLICATION
  NOBYPASSRLS
  CONNECTION LIMIT -1
  ENCRYPTED PASSWORD 'raiz';

COMMENT ON ROLE computacao IS 'Usuário dono do banco de dados compraiz.';

-- Cria o banco de dados "compraiz":
\qecho 
\qecho Cria o banco de dados "compraiz":
CREATE DATABASE compraiz WITH
  OWNER      = computacao
  TEMPLATE   = template1
  ENCODING   = 'UTF-8'
  LC_COLLATE = 'pt_BR.UTF-8'
  LC_CTYPE   = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS = true;

COMMENT ON DATABASE compraiz IS 'Banco de dados compraiz.';


-- =============================================================================
-- Conexão ao banco compraiz e criação do schema computacao
-- =============================================================================
-- Conexão ao banco compraiz:
\qecho
\qecho Conexão ao banco de dados compraiz:
\c "dbname=compraiz user=computacao password=raiz"

-- Criação do schema "elmasri".
\qecho
\qecho Criação e configurando do schema "computacao":
CREATE SCHEMA computacao AUTHORIZATION computacao;

COMMENT ON SCHEMA computacao IS 'Schema computacao para o banco de dados compraiz.';
COMMENT ON SCHEMA public IS 'Schema public padrão para o banco de dados compraiz.';


-- =============================================================================
-- Criação da view DUAL no schema public do banco de dados compraiz, para manter
-- compatibilidade e sintaxe com o Oracle, simulando sua tabela SYS.DUAL.
-- =============================================================================
\qecho
\qecho Criação da view DUAL no schema public do banco de dados compraiz:
CREATE OR REPLACE VIEW compraiz.public.dual AS
  SELECT 'X'::VARCHAR AS dummy;

COMMENT ON VIEW compraiz.public.dual IS 'Simulação da tabela SYS.DUAL do Oracle para manter compatibilidade e sintaxe.';


-- =============================================================================
-- Finalização
-- =============================================================================
\qecho
\qecho Fim.
\echo
\echo Fim! Se você está vendo esta mensagem o banco de dados "compraiz" foi
\echo criado com sucesso. Mesmo assim, por favor, verifique o arquivo de log
\echo "compraiz.log" em busca de erros ou avisos. Obrigado!

