--- Tabela com todos os meses do calendário
WITH all_month AS (
  SELECT
    DISTINCT month
  FROM
    `projetofinaleba.total_transfers`
),

--- Cálculo de entradas e saídas
transacoes_mensais AS (
  SELECT
    EXTRACT(MONTH FROM DATE(date_completed)) AS month,
    customer_id,
    full_name,
    SUM(CASE WHEN type_transaction IN ('transfer_ins', 'pix_in') THEN amount ELSE 0 END) AS total_transfer_in,
    SUM(CASE WHEN type_transaction IN ('transfer_outs', 'pix_out') THEN amount ELSE 0 END) AS total_transfer_out
  FROM
    `projetofinaleba.total_transfers`
  GROUP BY
    1, 2, 3
),

--- Combinando informações de clientes com todos os meses e o saldo de cada mês
saldo_mensal AS (
  SELECT
    allmonth.month,
    crossj.customer_id,
    crossj.full_name,
    COALESCE(total_transfer_in, 0) AS total_transfer_in,
    COALESCE(total_transfer_out, 0) AS total_transfer_out,
    total_transfer_in - total_transfer_out AS saldo_mes
  FROM
    all_month allmonth
  CROSS JOIN (
    SELECT
      DISTINCT customer_id,
      full_name
    FROM
      transacoes_mensais) crossj
  LEFT JOIN
    transacoes_mensais tm
  ON
    allmonth.month = tm.month AND crossj.customer_id = tm.customer_id
)

--- Saldo acumulado por cliente
SELECT
  month,
  customer_id,
  full_name,
  ROUND(total_transfer_in, 2) AS total_transfer_in,
  ROUND(total_transfer_out, 2) AS total_transfer_out,
  ROUND(SUM(saldo_mes) OVER (PARTITION BY customer_id ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS account_monthly_ba
FROM
  saldo_mensal
ORDER BY
  2,1;