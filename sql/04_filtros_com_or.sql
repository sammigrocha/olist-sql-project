/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 04_filtros_com_or.sql
Objetivo: Combinar condições alternativas (OR) para recortar clientes,
          vendedores e pedidos por mais de um valor de uma mesma coluna.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- Cada lado do OR é uma condição completa (coluna, operador, valor).
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. CLIENTES POR ESTADO
   Pergunta: quantos clientes estão em São Paulo ou no Rio de Janeiro?
----------------------------------------------------------------------------- */

SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state = 'SP' OR customer_state = 'RJ';                   -- 54.598

/* Validação: 41.746 (SP) + 12.852 (RJ) = 54.598.
   A soma é válida porque cada cliente possui um único estado. */


/* -----------------------------------------------------------------------------
   2. VENDEDORES POR ESTADO
   Pergunta: quantos vendedores atuam em SP, RJ e MG?
----------------------------------------------------------------------------- */

-- São Paulo ou Rio de Janeiro
SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_state = 'SP' OR seller_state = 'RJ';                       -- 2.020

-- São Paulo, Rio de Janeiro ou Minas Gerais
SELECT seller_id
FROM olist_sellers_dataset
WHERE seller_state = 'SP' OR seller_state = 'RJ' OR seller_state = 'MG'; -- 2.264

/* Validação: 1.849 (SP) + 171 (RJ) = 2.020.
   O acréscimo de MG corresponde a 244 vendedores (2.264 - 2.020). */


/* -----------------------------------------------------------------------------
   3. PEDIDOS COM PROBLEMAS
   Pergunta: quantos pedidos foram cancelados ou ficaram indisponíveis?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'canceled' OR order_status = 'unavailable';        -- 1.234

/* Validação: 625 (canceled) + 609 (unavailable) = 1.234.
   Os status são mutuamente exclusivos (um pedido tem apenas um status). */


/* -----------------------------------------------------------------------------
   NOTA SOBRE O USO DE OR
   Somar as contagens de cada condição só equivale ao resultado do OR quando
   nenhuma linha atende a mais de uma condição. Se isso ocorrer, a linha
   aparece uma única vez no resultado e a soma das contagens fica superior
   ao total de linhas retornado.
----------------------------------------------------------------------------- */