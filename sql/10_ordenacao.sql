/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 10_ordenacao.sql
Objetivo: Ordenar resultados (ORDER BY, ASC, DESC) isoladamente e combinados
          com filtros (WHERE) em preços, datas e cidades.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Ordem de escrita das cláusulas: SELECT, FROM, WHERE, ORDER BY.
- WHERE escolhe quais linhas entram; ORDER BY define apenas a ordem em que
  aparecem e não altera a quantidade de linhas.
- ASC (crescente) é o padrão; DESC inverte a ordem.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. ORDENAÇÃO POR PREÇO
   Pergunta: quais são o menor e o maior preço entre os itens vendidos?
----------------------------------------------------------------------------- */

-- Do menor para o maior preço
SELECT order_id, price
FROM olist_order_items_dataset
ORDER BY price;                                                         -- 112.650 | menor preço: 0.85

-- Do maior para o menor preço
SELECT order_id, price
FROM olist_order_items_dataset
ORDER BY price DESC;                                                    -- 112.650 | maior preço: 6735.0

/* Observação: o ORDER BY não altera o número de linhas (112.650 em ambos). */


/* -----------------------------------------------------------------------------
   2. FILTRO E ORDENAÇÃO COMBINADOS
   Pergunta: como ordenar apenas os itens de uma faixa de preço?
----------------------------------------------------------------------------- */

SELECT order_id, price
FROM olist_order_items_dataset
WHERE price BETWEEN 100 AND 200
ORDER BY price DESC;                                                    -- 27.111 | primeiro preço: 200.0

/* Observação: o filtro (WHERE) é aplicado antes da ordenação; por isso o
   primeiro valor não excede 200 e o total coincide com o do filtro isolado
   (07_filtros_com_between.sql). */


/* -----------------------------------------------------------------------------
   3. ORDENAÇÃO POR DATA
   Pergunta: qual é a data da compra mais recente?
----------------------------------------------------------------------------- */

SELECT order_id, order_purchase_timestamp
FROM olist_orders_dataset
ORDER BY order_purchase_timestamp DESC;                                 -- 99.441 | mais recente: 2018-10-17 17:30:18

/* Observação: o formato de data (ano-mês-dia hora) permite ordenar o texto
   em ordem cronológica. */


/* -----------------------------------------------------------------------------
   4. ORDENAÇÃO DE CLIENTES POR CIDADE
   Pergunta: como listar os clientes do Rio de Janeiro por cidade?
----------------------------------------------------------------------------- */

SELECT customer_city, customer_id
FROM olist_customers_dataset
WHERE customer_state = 'RJ'
ORDER BY customer_city;                                                 -- 12.852

/* Validação: 12.852 é o mesmo total do filtro sem ordenação
   (05/04: clientes do RJ). */