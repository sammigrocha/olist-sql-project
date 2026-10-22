/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 11_limit.sql
Objetivo: Limitar o número de linhas retornadas (LIMIT) e combiná-lo com
          ORDER BY para obter rankings ("top N") de preços e datas.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Ordem das cláusulas: SELECT, FROM, WHERE, ORDER BY, LIMIT.
- LIMIT define um teto de linhas; sem ORDER BY, a escolha das primeiras linhas
  não é garantida.
- Números são escritos sem separador de milhar (99442, e não 99.442).
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. COMPORTAMENTO DO LIMIT
   Pergunta: o que ocorre quando o limite excede o total de linhas da tabela?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
LIMIT 5;                                                                -- 5

SELECT order_id
FROM olist_orders_dataset
LIMIT 99442;                                                            -- 99.441

/* Observação: LIMIT é um teto. A tabela possui 99.441 linhas, e o banco
   retorna todas quando o limite é maior. */


/* -----------------------------------------------------------------------------
   2. RANKINGS ("TOP N")
   Pergunta: quais são os itens mais caros, mais baratos e as compras mais
   recentes?
----------------------------------------------------------------------------- */

-- 10 itens mais caros
SELECT order_id, price
FROM olist_order_items_dataset
ORDER BY price DESC
LIMIT 10;                                                               -- 10 | maior preço: 6735.0

-- 5 itens mais baratos
SELECT order_id, price
FROM olist_order_items_dataset
ORDER BY price
LIMIT 5;                                                                -- 5 | menor preço: 0.85

-- 5 compras mais recentes
SELECT order_id, order_purchase_timestamp
FROM olist_orders_dataset
ORDER BY order_purchase_timestamp DESC
LIMIT 5;                                                                -- 5 | mais recente: 2018-10-17 17:30:18

/* Validação: os valores extremos coincidem com os obtidos em
   10_ordenacao.sql (maior preço, menor preço e compra mais recente). */