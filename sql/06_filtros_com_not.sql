/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 06_filtros_com_not.sql
Objetivo: Inverter condições de filtro (NOT / NOT IN) para obter o
          complemento de um conjunto e validar a partição dos dados.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- NOT IN retorna as linhas cujo valor NÃO está na lista informada.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. CLIENTES FORA DA REGIÃO SUDESTE (SP, RJ, MG, ES)
   Pergunta: quantos clientes estão fora desses quatro estados?
----------------------------------------------------------------------------- */

SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state NOT IN ('SP', 'RJ', 'MG', 'ES');                   -- 31.175

/* Validação: 68.266 (IN, em 05_filtros_com_in.sql) + 31.175 = 99.441,
   total de clientes. IN e NOT IN com a mesma lista particionam a tabela. */


/* -----------------------------------------------------------------------------
   2. PEDIDOS EM STATUS MENOS FREQUENTES
   Pergunta: quantos pedidos não estão como delivered, shipped ou canceled?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_orders_dataset
WHERE order_status NOT IN ('delivered', 'shipped', 'canceled');         -- 1.231

/* Validação: 301 (processing) + 314 (invoiced) + 609 (unavailable)
              + 5 (created) + 2 (approved) = 1.231. */


/* -----------------------------------------------------------------------------
   3. LISTA SEM CORRESPONDÊNCIA
   Pergunta: o que ocorre quando nenhum valor da lista existe na coluna?
----------------------------------------------------------------------------- */

SELECT customer_id
FROM olist_customers_dataset
WHERE customer_state NOT IN ('XX', 'YY');                               -- 99.441

/* Observação: as siglas 'XX' e 'YY' não existem na base, então nenhuma linha
   é excluída e o resultado equivale ao total de clientes (99.441). */