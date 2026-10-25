/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 12_aliases.sql
Objetivo: Renomear colunas no resultado (alias com AS) para tornar as consultas
          mais legíveis, mantendo os nomes originais em filtros e ordenações.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Cada coluna recebe o seu próprio AS; as colunas são separadas por vírgula.
- O alias altera apenas o título da coluna no resultado.
- Em WHERE e ORDER BY, usar o nome original da coluna (portável entre bancos).
- Aliases sem espaços, com sublinhado quando necessário.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. ALIAS EM RANKING DE PREÇOS
   Pergunta: quais são os 5 itens mais caros, com títulos legíveis?
----------------------------------------------------------------------------- */

SELECT order_id AS pedido, price AS preco
FROM olist_order_items_dataset
ORDER BY price DESC
LIMIT 5;                                                                -- 5 | maior preço: 6735.0

/* Títulos no resultado: pedido, preco. */


/* -----------------------------------------------------------------------------
   2. ALIAS COM FILTRO E ORDENAÇÃO
   Pergunta: como listar clientes do Rio de Janeiro por cidade, com títulos
   em português?
----------------------------------------------------------------------------- */

SELECT customer_city AS cidade, customer_state AS estado
FROM olist_customers_dataset
WHERE customer_state = 'RJ'
ORDER BY customer_city
LIMIT 10;                                                               -- 10

/* Observação: o filtro usa a coluna do estado (customer_state); a sigla 'RJ'
   não corresponde a nenhuma cidade. */

SELECT seller_id AS vendedor, seller_city AS cidade
FROM olist_sellers_dataset
WHERE seller_city = 'santos'
ORDER BY seller_id;                                                     -- 16

/* Validação: 16 vendedores em Santos, igual ao obtido em
   08_filtros_com_like.sql. */


/* -----------------------------------------------------------------------------
   NOTA SOBRE ALIAS NO WHERE (DIFERENÇA ENTRE BANCOS)
   O SQLite aceita o alias no WHERE, mas outros bancos (PostgreSQL,
   SQL Server, Oracle) retornam erro, porque o filtro é aplicado antes de o
   SELECT definir os apelidos. Por portabilidade, usar sempre o nome original
   da coluna no WHERE.
----------------------------------------------------------------------------- */