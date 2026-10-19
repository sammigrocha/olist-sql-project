/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 09_valores_nulos_e_qualidade.sql
Objetivo: Identificar valores ausentes (NULL) na tabela de pedidos e verificar
          a consistência entre o status do pedido e a data de entrega.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- NULL indica ausência de valor; deve ser testado com IS NULL / IS NOT NULL
  (comparações com = ou <> não retornam linhas com NULL).
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. VALORES AUSENTES NA DATA DE ENTREGA
   Pergunta: quantos pedidos não têm data de entrega ao cliente?
   Coluna utilizada: order_delivered_customer_date.
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NULL;                            -- 2.965

SELECT order_id
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;                        -- 96.476

/* Validação: 2.965 + 96.476 = 99.441 (total de pedidos). */

-- Verificação de textos vazios (valores ausentes gravados como '')
SELECT order_id
FROM olist_orders_dataset
WHERE order_delivered_customer_date = '';                               -- 0

/* Conclusão: as datas ausentes estão armazenadas como NULL, e não como texto
   vazio. */


/* -----------------------------------------------------------------------------
   2. CONSISTÊNCIA ENTRE STATUS E DATA DE ENTREGA
   Pergunta: o status do pedido é coerente com a existência da data de entrega?
----------------------------------------------------------------------------- */

-- Pedidos entregues sem data de entrega
SELECT order_id
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;                            -- 8

-- Pedidos com data de entrega e status diferente de entregue
SELECT order_id
FROM olist_orders_dataset
WHERE order_status <> 'delivered'
  AND order_delivered_customer_date IS NOT NULL;                        -- 6

-- Status dos pedidos do grupo anterior
SELECT DISTINCT order_status
FROM olist_orders_dataset
WHERE order_status <> 'delivered'
  AND order_delivered_customer_date IS NOT NULL;                        -- 1 valor: canceled

/* Achados de qualidade de dados:
   - 8 pedidos com status 'delivered' não possuem data de entrega.
   - 6 pedidos com data de entrega possuem status 'canceled'.
   Hipótese a validar: pedidos entregues e depois cancelados (ex.: devolução).
   Os dados isolados não confirmam a causa; registrar como ponto de atenção
   para análises de prazo de entrega. */