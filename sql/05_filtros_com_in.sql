/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 05_filtros_com_in.sql
Objetivo: Filtrar registros por lista de valores de uma mesma coluna (IN),
          como alternativa mais concisa ao uso repetido de OR.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- IN compara uma única coluna com uma lista de valores.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. VENDEDORES POR ESTADO
   Pergunta: quantos vendedores atuam em SP, RJ e MG?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_state IN ('SP', 'RJ', 'MG');                               -- 2.264

/* Validação: resultado idêntico à versão com OR
   (04_filtros_com_or.sql): 2.264. */


/* -----------------------------------------------------------------------------
   2. PEDIDOS COM PROBLEMAS
   Pergunta: quantos pedidos foram cancelados ou ficaram indisponíveis?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
WHERE order_status IN ('canceled', 'unavailable');                      -- 1.234

/* Validação: resultado idêntico à versão com OR: 1.234. */


/* -----------------------------------------------------------------------------
   3. CLIENTES DO SUDESTE
   Pergunta: quantos clientes estão nos estados SP, RJ, MG e ES?
----------------------------------------------------------------------------- */

SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state IN ('SP', 'RJ', 'MG', 'ES');                       -- 68.266

/* Validação: 54.598 (SP + RJ) + 13.668 (MG + ES) = 68.266. */


/* -----------------------------------------------------------------------------
   4. VENDEDORES POR CIDADE
   Pergunta: quantos vendedores há em Campinas, Santos e Curitiba?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_city IN ('campinas', 'santos', 'curitiba');                -- 184

/* Validação: 41 (campinas) + 143 (santos + curitiba) = 184. */


/* -----------------------------------------------------------------------------
   NOTA SOBRE IN x OR
   - IN e OR produzem o mesmo resultado quando a condição envolve uma única
     coluna; IN é mais conciso à medida que a lista cresce.
   - IN não substitui OR quando as condições usam colunas diferentes
     (ex.: customer_state = 'SP' OR customer_city = 'niteroi').
----------------------------------------------------------------------------- */