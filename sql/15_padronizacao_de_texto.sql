/*
===============================================================================
Projeto : Olist SQL Project
Arquivo : 15_padronizacao_de_texto.sql
Objetivo: Padronizar a grafia de nomes de cidade no resultado das consultas
          (REPLACE) e medir quantos registros são afetados.
Banco   : SQLite (data/olist.db)
Autora  : sammigrocha
===============================================================================
Convenções
- REPLACE(texto, trecho_procurado, trecho_novo) troca o trecho em qualquer
  posição do texto; se o trecho não existe, o texto retorna inalterado.
- A função altera apenas o resultado da consulta, e não a tabela.
- Comentários ao final da linha indicam o número de linhas retornado.
===============================================================================
*/


/* -----------------------------------------------------------------------------
   1. PADRONIZAÇÃO DA GRAFIA 'PARATI' PARA 'PARATY'
   Pergunta: como exibir as duas grafias de Paraty de forma padronizada?
   Contexto: achado registrado em 13_funcoes_de_texto.sql (13 + 19 = 32
   clientes distribuídos em duas grafias).
----------------------------------------------------------------------------- */

-- Amostra dos registros com a grafia antiga, com original e padronizado
SELECT customer_city, REPLACE(customer_city, 'parati', 'paraty') AS cidade_padronizada
FROM olist_customers_dataset
WHERE customer_city = 'parati'
LIMIT 3;                                                                -- 3

/* Observação: a coluna original permanece 'parati'; a padronização ocorre
   apenas no resultado. */


/* -----------------------------------------------------------------------------
   2. IMPACTO DA PADRONIZAÇÃO
   Pergunta: quantos registros têm a cidade alterada pela substituição?
----------------------------------------------------------------------------- */

SELECT customer_id, customer_city
FROM olist_customers_dataset
WHERE customer_city <> REPLACE(customer_city, 'parati', 'paraty');      -- 13

/* Validação: 13 registros, igual ao total de clientes com a grafia 'parati'
   (13_funcoes_de_texto.sql). Nas demais cidades, o REPLACE não encontra o
   trecho e o texto permanece igual ao original, portanto não entram no
   resultado. Após a padronização, Paraty passa a reunir 32 clientes
   (19 + 13). */


/* -----------------------------------------------------------------------------
   NOTA SOBRE REPLACE
   O REPLACE troca o trecho em qualquer posição do texto. Trechos curtos ou
   comuns (ex.: 'o') podem alterar partes não desejadas; usar trechos
   específicos e conferir o impacto com uma comparação como a da seção 2.
----------------------------------------------------------------------------- */