/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 07_filtros_com_between.sql
Objetivo: Filtrar valores dentro de um intervalo (BETWEEN) e compará-lo com
          a forma equivalente usando >= e <=.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Palavras reservadas do SQL em maiúsculas.
- BETWEEN inclui os dois extremos do intervalo.
- O menor valor deve vir primeiro: BETWEEN 100 AND 200.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. ITENS DE PEDIDO POR FAIXA DE PREÇO
   Pergunta: quantos itens vendidos custam entre R$ 100 e R$ 200?
   Coluna utilizada: price (tipo REAL).
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_order_items_dataset
WHERE price BETWEEN 100 AND 200;                                        -- 27.111

-- Forma equivalente, com operadores de comparação
SELECT order_id
FROM olist_order_items_dataset
WHERE price >= 100 AND price <= 200;                                    -- 27.111

/* Validação: as duas formas retornam o mesmo número de linhas (27.111). */


/* -----------------------------------------------------------------------------
   2. INTERVALO INVERTIDO
   Pergunta: o que ocorre quando o limite inferior é maior que o superior?
----------------------------------------------------------------------------- */

SELECT order_id
FROM olist_order_items_dataset
WHERE price BETWEEN 200 AND 100;                                        -- 0

SELECT order_id
FROM olist_order_items_dataset
WHERE price >= 200 AND price <= 100;                                    -- 0

/* Observação: nenhum valor satisfaz "maior ou igual a 200" e "menor ou igual
   a 100" simultaneamente. O SQLite não retorna erro, apenas resultado vazio.
   Ao usar BETWEEN, o menor valor deve vir primeiro. */