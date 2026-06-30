SELECT
  -- Order ID
  sls_ord_num AS order_id,

  -- Foreign keys
  sls_cust_id AS customer_id,
  sls_prd_key AS product_key,

  -- Convert integer dates (YYYYMMDD → DATE)
  PARSE_DATE('%Y%m%d', CAST(sls_order_dt AS STRING)) AS order_date,
  PARSE_DATE('%Y%m%d', CAST(sls_ship_dt AS STRING)) AS ship_date,
  PARSE_DATE('%Y%m%d', CAST(sls_due_dt AS STRING)) AS due_date,

  -- Metrics
  SAFE_CAST(sls_sales AS FLOAT64) AS sales_amount,
  SAFE_CAST(sls_quantity AS INT64) AS quantity,
  SAFE_CAST(sls_price AS FLOAT64) AS price,

  -- Derived metric
  SAFE_CAST(sls_quantity AS FLOAT64) * SAFE_CAST(sls_price AS FLOAT64) AS revenue,

  -- Order status (very strong signal)
  CASE
    WHEN sls_ship_dt IS NULL THEN 'Pending'
    WHEN sls_ship_dt > sls_due_dt THEN 'Late'
    ELSE 'Shipped'
  END AS order_status

FROM {{ source('raw', 'bronze_sales') }}