/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 14_verificacao_de_espacos.sql
Objetivo: Verificar a presença de espaços sobrando no início ou no fim de
          colunas de texto (TRIM e LENGTH) e identificar produtos sem categoria.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- TRIM remove espaços no início e no fim do texto (não altera os espaços
  entre palavras) e não modifica a tabela, apenas o resultado.
- Um texto sem espaços sobrando tem LENGTH(coluna) = LENGTH(TRIM(coluna)).
- Valores NULL não são avaliados por comparações (<>, =); devem ser checados
  com IS NULL.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. VALIDAÇÃO DO MÉTODO
   Pergunta: a comparação de tamanhos detecta espaços sobrando?
----------------------------------------------------------------------------- */

SELECT LENGTH('  Ana '), LENGTH(TRIM('  Ana '));                        -- 6 e 3

/* Observação: o texto de teste tem 3 espaços (dois no início, um no fim).
   A diferença entre 6 e 3 confirma que o método identifica espaços; um
   resultado de 0 linhas nas verificações abaixo indica ausência de espaços. */


/* -----------------------------------------------------------------------------
   2. VERIFICAÇÃO DE ESPAÇOS SOBRANDO
   Pergunta: existem textos com espaços no início ou no fim?
----------------------------------------------------------------------------- */

SELECT customer_city, LENGTH(customer_city)
FROM olist_customers_dataset
WHERE LENGTH(customer_city) <> LENGTH(TRIM(customer_city));             -- 0

SELECT customer_state, LENGTH(customer_state)
FROM olist_customers_dataset
WHERE LENGTH(customer_state) <> LENGTH(TRIM(customer_state));           -- 0

SELECT seller_city, LENGTH(seller_city)
FROM olist_sellers_dataset
WHERE LENGTH(seller_city) <> LENGTH(TRIM(seller_city));                 -- 0

SELECT product_category_name, LENGTH(product_category_name)
FROM olist_products_dataset
WHERE LENGTH(product_category_name) <> LENGTH(TRIM(product_category_name)); -- 0

/* Conclusão: as quatro colunas verificadas não possuem espaços sobrando. */


/* -----------------------------------------------------------------------------
   3. PRODUTOS SEM CATEGORIA
   Pergunta: quantos produtos não possuem categoria informada?
----------------------------------------------------------------------------- */

SELECT product_id
FROM olist_products_dataset
WHERE product_category_name IS NULL;                                    -- 610

/* Achado de qualidade de dados:
   - 610 dos 32.951 produtos (cerca de 2%) não possuem categoria.
   - A verificação de espaços da seção 2 não avalia esses registros
     (comparações com NULL não retornam linhas); portanto, abrange os 32.341
     produtos com categoria (32.951 - 610).
   Pendência: definir o tratamento desses produtos nas análises por
   categoria (ex.: agrupá-los como 'sem categoria'). */