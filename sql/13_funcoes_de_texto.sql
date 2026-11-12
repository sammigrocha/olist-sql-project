/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 13_funcoes_de_texto.sql
Objetivo: Aplicar funções de texto (UPPER) em resultados e filtros e investigar
          inconsistências de grafia em nomes de cidades.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- Funções transformam o valor apenas no resultado; a tabela não é alterada.
- Em SQLite, UPPER e LOWER convertem somente letras sem acento (A-Z).
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. UPPER NO RESULTADO
   Pergunta: como exibir os nomes de cidade em maiúsculas sem alterar a tabela?
----------------------------------------------------------------------------- */

SELECT customer_city, UPPER(customer_city) AS cidade_maiuscula
FROM olist_customers_dataset
WHERE customer_state = 'RJ'
LIMIT 5;                                                                -- 5

/* Observação: a coluna original permanece em minúsculas; apenas o resultado
   exibe o texto transformado. */


/* -----------------------------------------------------------------------------
   2. UPPER NO FILTRO
   Pergunta: como buscar uma cidade independentemente de como foi digitada?
----------------------------------------------------------------------------- */

SELECT seller_id
FROM olist_sellers_dataset
WHERE UPPER(seller_city) = 'SANTOS';                                    -- 16

/* Validação: 16 vendedores, igual a seller_city = 'santos' em
   08_filtros_com_like.sql. O valor comparado deve estar em maiúsculas, pois
   UPPER devolve o texto em maiúsculas. */


/* -----------------------------------------------------------------------------
   3. INCONSISTÊNCIA DE GRAFIA: PARATI x PARATY
   Pergunta: uma mesma cidade aparece com mais de uma grafia?
----------------------------------------------------------------------------- */

-- Cidades do RJ que começam com 'para'
SELECT DISTINCT customer_city
FROM olist_customers_dataset
WHERE customer_state = 'RJ' AND customer_city LIKE 'para%';             -- 4
/* parati, paraiba do sul, paracambi, paraty */

-- Clientes por grafia
SELECT customer_id
FROM olist_customers_dataset
WHERE customer_city = 'parati';                                         -- 13

SELECT customer_id
FROM olist_customers_dataset
WHERE customer_city = 'paraty';                                         -- 19

/* Achado de qualidade de dados:
   - 'parati' e 'paraty' parecem ser a mesma cidade (Paraty, RJ) escrita de
     duas formas: 13 + 19 = 32 clientes.
   - Uma busca por apenas uma grafia omite parte dos registros (buscar só
     'paraty' retorna 19 dos 32, cerca de 59%).
   - Em contagens agrupadas por cidade, as duas grafias seriam tratadas como
     cidades distintas e dividiriam o total.
   Pendência: padronizar a grafia na etapa de limpeza de dados. */


/* -----------------------------------------------------------------------------
   4. TAMANHO DE TEXTO (LENGTH)
   Pergunta: quais cidades do Rio de Janeiro têm os nomes mais longos?
----------------------------------------------------------------------------- */

SELECT customer_city, LENGTH(customer_city) AS tamanho
FROM olist_customers_dataset
WHERE customer_state = 'RJ'
ORDER BY LENGTH(customer_city) DESC
LIMIT 5;                                                                -- 5 | maior: 29 caracteres

/* Resultado: 'sao jose do vale do rio preto' (29 caracteres) é o nome mais
   longo entre os clientes do RJ. O critério do ORDER BY deve medir a mesma
   coluna exibida no SELECT (customer_city). */