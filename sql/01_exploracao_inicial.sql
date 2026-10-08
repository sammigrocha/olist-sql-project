/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 01_exploracao_inicial.sql
Objetivo: Exploração inicial do dataset Olist (e-commerce brasileiro):
          reconhecimento das tabelas e primeiros recortes por estado e
          status de pedido.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- Comentários ao final da linha indicam o número de linhas retornado,
  para facilitar a conferência dos resultados.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. RECONHECIMENTO DAS TABELAS
   Pergunta: o que cada tabela contém e qual o seu tamanho?
----------------------------------------------------------------------------- */

-- Clientes
SELECT * FROM olist_customers_dataset;                                  -- 99.441 linhas
SELECT customer_city FROM olist_customers_dataset;                      -- 99.441
SELECT customer_city, customer_state FROM olist_customers_dataset;      -- 99.441

-- Pedidos
SELECT order_id, order_status FROM olist_orders_dataset;                -- 99.441

-- Vendedores
SELECT seller_id, seller_state FROM olist_sellers_dataset;              -- 3.095

-- Produtos
SELECT product_id, product_category_name FROM olist_products_dataset;   -- 32.951

-- Pagamentos
SELECT payment_type, payment_value FROM olist_order_payments_dataset;   -- 103.886

/* Observação: a tabela de pagamentos tem mais linhas que a de pedidos
   (103.886 vs. 99.441). Hipótese a validar: um mesmo pedido pode ter mais de
   um pagamento (ex.: parte no cartão, parte em outra forma). */


/* -----------------------------------------------------------------------------
   2. DISTRIBUIÇÃO GEOGRÁFICA
   Pergunta: como clientes e vendedores se distribuem por estado?
----------------------------------------------------------------------------- */

-- Clientes de São Paulo
SELECT customer_city, customer_state
FROM olist_customers_dataset
WHERE customer_state = 'SP';                                            -- 41.746 (~42% do total)

-- Clientes do Rio de Janeiro
SELECT customer_city
FROM olist_customers_dataset
WHERE customer_state = 'RJ';                                            -- 12.852

-- Clientes fora de São Paulo
SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state <> 'SP';                                           -- 57.695

-- Vendedores do Rio de Janeiro
SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_state = 'RJ';                                              -- 171

/* Validação: 41.746 (SP) + 57.695 (não SP) = 99.441 (total de clientes). */


/* -----------------------------------------------------------------------------
   3. STATUS DOS PEDIDOS
   Pergunta: qual a proporção de pedidos entregues, enviados e cancelados?
----------------------------------------------------------------------------- */

-- Pedidos entregues
SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'delivered';                                       -- 96.478 (~97%)

-- Pedidos enviados (ainda em trânsito)
SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'shipped';                                         -- 1.107

-- Pedidos cancelados
SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'canceled';                                        -- 625

-- Pedidos em qualquer status diferente de entregue
SELECT order_id
FROM olist_orders_dataset
WHERE order_status <> 'delivered';                                      -- 2.963

/* Validação: 96.478 (entregues) + 2.963 (demais) = 99.441 (total de pedidos).
   Pendência: listar todos os valores distintos de order_status. */