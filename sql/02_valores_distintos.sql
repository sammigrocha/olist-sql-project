/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 02_valores_distintos.sql
Objetivo: Identificar os valores distintos de colunas categóricas e validar
          a cobertura dos status de pedido.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. VALORES DISTINTOS DE COLUNAS CATEGÓRICAS
   Pergunta: quais categorias existem em cada coluna?
----------------------------------------------------------------------------- */

-- Status dos pedidos
SELECT DISTINCT order_status
FROM olist_orders_dataset;                                              -- 8 valores
/* delivered, shipped, canceled, processing, invoiced, unavailable,
   created, approved */

-- Estados dos clientes
SELECT DISTINCT customer_state
FROM olist_customers_dataset;                                           -- 27 valores
/* Corresponde às 27 unidades federativas (26 estados + DF). */

-- Tipos de pagamento
SELECT DISTINCT payment_type
FROM olist_order_payments_dataset;                                      -- 5 valores
/* credit_card, boleto, voucher, debit_card, not_defined.
   Pendência: investigar o significado e a frequência de 'not_defined'. */


/* -----------------------------------------------------------------------------
   2. PEDIDOS POR STATUS (STATUS MENOS FREQUENTES)
   Pergunta: quantos pedidos há em cada status além de delivered, shipped
   e canceled (consultados em 01_exploracao_inicial.sql)?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'processing';                                      -- 301

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'invoiced';                                        -- 314

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'unavailable';                                     -- 609

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'created';                                         -- 5

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'approved';                                        -- 2


/* -----------------------------------------------------------------------------
   3. VALIDAÇÃO
   Soma dos pedidos por status:
     delivered   96.478
     shipped      1.107
     canceled       625
     processing     301
     invoiced       314
     unavailable    609
     created          5
     approved         2
     ------------------
     Total       99.441  (= total de linhas de olist_orders_dataset)
   Conclusão: os 8 status cobrem todos os pedidos, sem lacunas ou sobreposição.
----------------------------------------------------------------------------- */