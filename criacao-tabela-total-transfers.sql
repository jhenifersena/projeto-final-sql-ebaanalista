--- Tabela com todas as transações realizadas, seja entrada ou saída
CREATE OR REPLACE TABLE `projetofinaleba.total_transfers` AS (
  SELECT
    transaction_id,
    customer_id,
    full_name,
    account_id,
    amount,
    status,
    type_transaction,
    date_completed,
    month
  FROM (

--- Tabela de pix
SELECT
  pix.id AS transaction_id,
  account.customer_id,
  CONCAT(customer.first_name, ' ', customer.last_name) AS full_name,
  pix.account_id,
  pix.pix_amount AS amount,
  pix.status,
  pix.in_or_out AS type_transaction,
  DATE(time.action_timestamp) AS date_completed,
  EXTRACT(MONTH FROM DATE(time.action_timestamp)) AS month
FROM
  `projetofinaleba.pix_moviments` pix
LEFT JOIN
  `projetofinaleba.accounts` account
ON
  pix.account_id = account.account_id
LEFT JOIN
  `projetofinaleba.customers` customer
ON
  account.customer_id = customer.customer_id
LEFT JOIN
  `projetofinaleba.time` time
ON
  pix.pix_completed_at = time.time_id
WHERE
  pix.status = 'completed'
  AND
    DATE(time.action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'

UNION ALL

--- Tabela de transfer_ins
SELECT
  ins.id AS transaction_id,
  account.customer_id,
  CONCAT(customer.first_name, ' ', customer.last_name) AS full_name,
  ins.account_id,
  ins.amount,
  ins.status,
  'transfer_ins' AS type_transaction,
  DATE(time.action_timestamp) AS date_completed,
  EXTRACT(MONTH FROM DATE(time.action_timestamp)) AS month
FROM
  `projetofinaleba.transfer_ins` ins
LEFT JOIN
  `projetofinaleba.accounts` account
ON
  ins.account_id = account.account_id
LEFT JOIN
  `projetofinaleba.customers` customer
ON
  account.customer_id = customer.customer_id
LEFT JOIN
  `projetofinaleba.time` time
ON
  ins.transaction_completed_at = time.time_id
WHERE
  ins.status = 'completed'
  AND
    DATE(time.action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'

UNION ALL

--- Tabela de transfer_outs
SELECT
  outs.id AS transaction_id,
  account.customer_id,
  CONCAT(customer.first_name, ' ', customer.last_name) AS full_name,
  outs.account_id,
  outs.amount,
  outs.status,
  'transfer_outs' AS type_transaction,
  DATE(time.action_timestamp) AS date_completed,
  EXTRACT(MONTH FROM DATE(time.action_timestamp)) AS month
FROM
  `projetofinaleba.transfer_outs` outs
LEFT JOIN
  `projetofinaleba.accounts` account
ON
  outs.account_id = account.account_id
LEFT JOIN
  `projetofinaleba.customers` customer
ON
  account.customer_id = customer.customer_id
LEFT JOIN
  `projetofinaleba.time` time
ON
  outs.transaction_completed_at = time.time_id
WHERE
  outs.status = 'completed'
  AND
    DATE(time.action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'
))