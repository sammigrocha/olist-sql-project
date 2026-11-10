# Olist SQL Project

Análise de dados de e-commerce com SQL, usando o dataset público da Olist e o SQLite.

> **Status:** em desenvolvimento. Este README é atualizado a cada etapa concluída.

## Objetivo

Construir uma análise de dados completa sobre o e-commerce brasileiro, cobrindo exploração, validação da qualidade dos dados, consultas analíticas e modelagem, com todas as consultas documentadas e versionadas.

## Dataset

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle): cerca de 100 mil pedidos feitos entre 2016 e 2018 em marketplaces brasileiros, distribuídos em 9 tabelas.

| Tabela | Conteúdo |
|---|---|
| `olist_customers_dataset` | clientes e localização |
| `olist_orders_dataset` | pedidos, status e datas |
| `olist_order_items_dataset` | itens de cada pedido e preços |
| `olist_order_payments_dataset` | pagamentos dos pedidos |
| `olist_order_reviews_dataset` | avaliações dos clientes |
| `olist_products_dataset` | produtos e categorias |
| `olist_sellers_dataset` | vendedores e localização |
| `olist_geolocation_dataset` | coordenadas por CEP |
| `product_category_name_translation` | tradução das categorias para o inglês |

## Ferramentas

- SQL (dialeto SQLite)
- DB Browser for SQLite
- Git e GitHub

## Estrutura do projeto

```
olist-sql-project/
├── README.md
├── .gitignore
└── sql/          consultas SQL, numeradas por etapa
```

A pasta `data/` (arquivos CSV e banco `olist.db`) existe apenas no ambiente local e não é versionada, devido ao tamanho dos arquivos.

## Como reproduzir

1. Baixe o dataset no Kaggle e extraia os 9 arquivos `.csv`.
2. No DB Browser for SQLite, crie um banco chamado `olist.db` na pasta `data/`.
3. Importe cada `.csv` (Arquivo > Importar > Tabela de arquivo CSV), com a opção de nomes de coluna na primeira linha, mantendo o nome da tabela igual ao do arquivo.
4. Grave as alterações e execute os arquivos da pasta `sql/`.

## Consultas

| Arquivo | Conteúdo |
|---|---|
| `01_exploracao_inicial.sql` | reconhecimento das tabelas, recortes por estado e status |
| `02_valores_distintos.sql` | valores distintos de colunas categóricas e validação dos status |
| `03_filtros_com_and.sql` | filtros combinados e validação geográfica |
| `04_filtros_com_or.sql` | filtros alternativos por estado e status |
| `05_filtros_com_in.sql` | filtros por lista de valores |
| `06_filtros_com_not.sql` | complementos de conjuntos (NOT IN) |
| `07_filtros_com_between.sql` | filtros por faixa de preço |
| `08_filtros_com_like.sql` | busca de texto por padrão |
| `09_valores_nulos_e_qualidade.sql` | valores ausentes e consistência entre status e data |
| `10_ordenacao.sql` | ordenação de resultados |
| `11_limit.sql` | rankings por preço e data |
| `12_aliases.sql` | apelidos de colunas |
| `13_funcoes_de_texto.sql` | funções de texto e inconsistências de grafia |

## Principais achados até agora

**Volume e distribuição**
- A base tem 99.441 pedidos e 99.441 registros de clientes.
- São Paulo concentra cerca de 42% dos clientes (41.746).
- Cerca de 97% dos pedidos estão como `delivered` (96.478).
- Os preços dos itens vão de R$ 0,85 a R$ 6.735,00.

**Qualidade dos dados**
- Os 8 status de pedido existentes somam exatamente o total de pedidos (99.441), sem lacunas.
- 8 pedidos estão como `delivered` sem data de entrega.
- 6 pedidos com data de entrega estão como `canceled`.
- A cidade de Paraty aparece com duas grafias (`parati`, 13 clientes, e `paraty`, 19), o que exige padronização antes de análises por cidade.

## Limitações

- O SQLite foi escolhido por simplicidade. Algumas funções e comportamentos (por exemplo, `LIKE` sem diferenciação de maiúsculas e `UPPER` sem tratar acentos) variam em outros bancos, como PostgreSQL, MySQL e SQL Server.
- Os nomes de cidade do dataset vêm sem acento e com grafias inconsistentes.

## Próximos passos

- Funções de texto, número e data.
- Agregações (contagens, somas e médias) e agrupamentos.
- Junção de tabelas para análises de vendas, entregas e avaliações.
- Limpeza e padronização dos dados.
- Modelagem e consultas analíticas avançadas.
