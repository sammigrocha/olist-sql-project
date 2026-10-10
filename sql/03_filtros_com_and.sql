/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 03_filtros_com_and.sql
Objetivo: Combinar condições de filtro (AND) para recortar clientes e
          vendedores por estado e cidade, e validar a consistência geográfica.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- Comentários ao final da linha indicam o número de linhas retornado.
- Nomes de cidades estão em minúsculas na base (ex.: 'campinas').
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. CLIENTES DE CAMPINAS
   Pergunta: quantos clientes estão em Campinas, e a condição de estado
   altera esse número?
----------------------------------------------------------------------------- */

-- Clientes de Campinas (SP)
SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state = 'SP' AND customer_city = 'campinas';             -- 1.444

-- Clientes de Campinas (somente filtro de cidade)
SELECT customer_id
FROM olist_customers_dataset
WHERE customer_city = 'campinas';                                       -- 1.444

-- Campinas combinada com o estado do Rio de Janeiro
SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state = 'RJ' AND customer_city = 'campinas';             -- 0

/* Observação: a condição de estado não alterou o resultado (1.444 nos dois
   primeiros casos) e a combinação com RJ retornou vazio. Isso indica que
   todos os clientes de Campinas estão em SP. */


/* -----------------------------------------------------------------------------
   2. VALIDAÇÃO GEOGRÁFICA
   Pergunta: a cidade 'campinas' pertence a mais de um estado nos dados?
----------------------------------------------------------------------------- */

SELECT DISTINCT customer_state
FROM olist_customers_dataset
WHERE customer_city = 'campinas';                                       -- 1 valor: SP

/* Conclusão: confirmada a consistência entre cidade e estado para Campinas. */


/* -----------------------------------------------------------------------------
   3. VENDEDORES DE CAMPINAS
   Pergunta: quantos vendedores estão em Campinas?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_state = 'SP' AND seller_city = 'campinas';                 -- 41