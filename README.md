# Projeto SQL - Curso EBA Analista

## :information_source: **Descrição**

Este projeto é a conclusão do módulo de SQL do curso **EBA Analista** da professora Renata Biaggi.
O objetivo é demonstrar habilidades em consultas e análises SQL utilizando o **Google BigQuery**.


## :game_die: **Base de dados**

O projeto utiliza 12 arquivos `.csv` fictícios que foram disponibilizados como base para análise na plataforma do curso.

Todos os arquivos foram baixados e importados individualmente no Google BigQuery para realização das consultas.


## :file_folder: **Estrutura do projeto**
```
meu-projeto-sql/
├── README.md
├── bases-projeto-final/
│ ├── accounts.csv
│ ├── city.csv
│ ├── country.csv
│ ├── customers.csv
│ ├── month.csv
│ ├── pix_moviments.csv
│ ├── state.csv
│ ├── time.csv
│ ├── transfer_ins.csv
│ ├── transfer_outs.csv
│ ├── week.csv
│ └── year.csv
├── queries/
│ ├── construcao-query-principal.sql
│ └── criacao-tabela-total-transfers.sql
```


## :hammer: **Construção da solução**

A partir dos dados disponibilizados no curso, o objetivo principal foi consolidar, em uma única tabela, os dados de movimentações financeiras (entradas, saídas e pix), para permitir o cálculo do saldo mensal por cliente. Para isso, foi necessário combinar e tratar os dados de diferentes tabelas, de modo que possibilitasse o cálculo do saldo mensal de cada cliente no período de janeiro a dezembro de 2020.
Os principais passos realizados foram:

**1. Importação das bases**  
Os arquivos `.csv` foram carregados individualmente no Google BigQuery, trazendo as tabelas dimensão (como `accounts`, `city`, `customers`, `time`, entre outras) e as tabelas fato (`pix_moviments`, `transfer_ins`, `transfer_outs`).

**2. Análise exploratória das tabelas**  
Realizei consultas simples para entender a estrutura dos dados, identificar possíveis relacionamentos e validar a qualidade das informações.

**3. Relacionamento entre tabelas**  
Com base nas colunas em comum, foram realizados joins entre as tabelas dimensão e as tabelas fato, a fim de combinar todos os dados em uma única tabela e facilitar a análise posterior para chegar no resultado esperado.

**4. Criação de colunas adicionais**  
Algumas colunas foram criadas ou transformadas para padronizar as informações e permitir cruzamentos entre as tabelas (por exemplo: normalização de datas, concatenação de colunas, etc.).

**5. Consolidação da tabela final**  
Ao final, o resultado foi uma tabela chamada `total_transfers`, que consolida os dados de movimentações de entrada, saída e pix, e também informações sobre os clientes.
