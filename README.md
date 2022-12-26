# Exemplos de schemas de bancos de dados utilziados no curso CR6.180A

## 1. Introdução

Este repositório contém uma cópia dos exemplos de esquemas (schemas) de bancos
de dados distribuídos com o Oracle Database. Esses schemas de exemplo são
utilizados em diversas documentações e cursos da Oracle a respeito de SQL e de
outras funcionalidades do Oracle Database.

Os schemas são documentados em
[Oracle Database Sample Schemas](https://www.oracle.com/pls/topic/lookup?ctx=dblatest&id=COMSC),
e são livremente distribuídos sob uma licença MIT para qualquer tipo de uso,
pessoal, acadêmico ou comercial.

Os schemas originais, para o Oracle, são:
- HR: *Human Resources*
- OE: *Order Entry*
- PM: *Product Media*
- IX: *Information Exchange*
- SH: *Sales History*
- BI: *Business Intelligence*
- CO: *Customer Orders*

Esses schemas serão utilizados para demonstração e ensino de SQL no curso
[*CR6.180A: Introdução ao Projeto e Sistemas de Bancos de Dados*](https://cursos.computacaoraiz.com.br/)
e, para isso, foram adaptados e modificados para a utilização em outros SGBDRs
(além do Oracle).

## 2. Modificação para outros SGBDRs

Os scripts originais liberados pela Oracle só funcionam, obviamente, com o
Oracle Database. Para as finalidades do CR6.180A, que pretende demonstrar o uso
da SQL de forma genérica e independente do fornecedor, foi preciso adaptar e
modificar os scripts para que funcionassem também nos seguintes SGBDRs:

- Oracle: scripts originais
- PostgreSQL: scripts adaptados
- SQL Server: scripts adaptados
- MariaDB (ou MySQL): scripts adaptados

Como algumas coisas são específicas do Oracle nem tudo pôde ser adaptado de
maneira exata e, nesses casos, minha decisão foi um compromisso entre a
complexidade da adaptação necesserária para reproduzir a funcionalidade
do Oracle e a real necessidade dos alunos. Se uma funcionalidade não fará falta
para os alunos (pelo menos no CR6.180A), ela não foi traduzida para os scripts
adaptados, nesse primeiro momento.

## 3. Instalando os schemas

Verifique as instruções dentre dos subdiretórios apropriados (oracle, mariadb,
postgresql e sqlserver).

As instruções foram testadas e funcionam na *DBSERVER 2.0*, uma máquina virtual
do Computação Raiz especialmente preparada para o curso CR6.180A. Maiores
informações em
[*DBSERVER 2.0: máquina virtual para estudo de bancos de dados*](https://www.computacaoraiz.com.br/).

ATENÇÃO: todos os scripts já estão instalados na DBSERVER 2.0! Se você usar
essa máquina virtual para acompanhar o curso, não precisa fazer nada, nem
instalar nada: já está tudo pronto para você. Você só precisa instalar
diretamente esses scripts se estiver utilizando outra máquina virtual ou
utilizando diretamente SGBDRs instalados em seu computador.

## 4. Licença

### 4.1. Licença MIT dos scripts originais fornecidos pela Oracle:

A licença a seguir refere-se aos scripts originais fornecidos pela Oracle,
disponíveis do subdiretório Oracle.

**Copyright (c) 2019 Oracle

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.**

### 4.2. Licença MIT dos scripts adaptados pelo Computação Raiz:

A licença a seguir refere-se aos scripts adaptados pelo Computação Raiz para
funcionarem em outros SGBDRs (scripts disponíveis nos subdiretórios ``mariadb``,
``postgresql`` e ``sqlserver``):

**Copyright (c) 2022 Computação Raiz

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.**
