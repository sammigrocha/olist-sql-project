/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 08_filtros_com_like.sql
Objetivo: Buscar texto por padrão (LIKE e curinga %) em nomes de cidades de
          vendedores e clientes, e verificar o tratamento de maiúsculas e
          minúsculas.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- O curinga % representa qualquer sequência de caracteres (inclusive vazia).
- Sem o curinga, LIKE equivale a uma comparação de igualdade de texto.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. LIKE SEM CURINGA x IGUALDADE
   Pergunta: LIKE sem % se comporta como o operador =?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city = 'santos';                                           -- 16

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city LIKE 'santos';                                        -- 16

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city LIKE 'santos%';                                       -- 16

/* Observação: o resultado é o mesmo porque nenhuma outra cidade da base
   começa com 'santos'. */

SELECT customer_city
FROM olist_customers_dataset
WHERE customer_city LIKE 'sao';                                         -- 0

/* Observação: sem %, o padrão 'sao' exige texto idêntico; não há cidade com
   esse nome exato, e o resultado é vazio (sem erro). */


/* -----------------------------------------------------------------------------
   2. MAIÚSCULAS E MINÚSCULAS
   Pergunta: LIKE e = diferenciam maiúsculas de minúsculas no SQLite?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city LIKE 'SANTOS';                                        -- 16

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city = 'SANTOS';                                           -- 0

/* Conclusão: no SQLite, LIKE ignora a diferença entre maiúsculas e
   minúsculas, enquanto = a diferencia. O comportamento de LIKE varia entre
   sistemas de banco de dados. */


/* -----------------------------------------------------------------------------
   3. BUSCA POR PADRÃO EM CIDADES
   Pergunta: como o curinga muda o resultado conforme sua posição?
----------------------------------------------------------------------------- */

-- Cidades que começam com 'san' (vendedores)
SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city LIKE 'san%';                                          -- 103

-- Cidades que começam com 'sao' (clientes)
SELECT customer_city
FROM olist_customers_dataset
WHERE customer_city LIKE 'sao%';                                        -- 20.988

-- Cidades que contêm 'paulo' em qualquer posição (clientes)
SELECT customer_city
FROM olist_customers_dataset
WHERE customer_city LIKE '%paulo%';                                     -- 15.606

-- Mesmo padrão de 'sao%', em maiúsculas
SELECT customer_city
FROM olist_customers_dataset
WHERE customer_city LIKE 'SAO%';                                        -- 20.988

/* Observações:
   - '%paulo%' retorna menos linhas que 'sao%': cidades como 'sao bernardo do
     campo' começam com 'sao' mas não contêm 'paulo'.
   - 'SAO%' e 'sao%' retornam o mesmo número de linhas (20.988), confirmando
     que LIKE ignora maiúsculas e minúsculas. */