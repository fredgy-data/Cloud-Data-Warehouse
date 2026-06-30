SELECT
  -- Order info
  s.order_id,
  s.order_date,
  s.ship_date,
  s.due_date,
  s.order_status,

  -- Customer dimension
  c.customer_id,
  c.full_name AS customer_name,
  c.gender,
  c.marital_status,

  -- Product dimension
  p.product_id,
  p.product_name,
  p.product_line,
  p.product_status,

  -- Metrics
  s.quantity,
  s.price,
  s.sales_amount,
  s.revenue

FROM {{ ref('stg_sales') }} s

LEFT JOIN {{ ref('stg_customers') }} c
  ON s.customer_id = c.customer_id

LEFT JOIN {{ ref('stg_products') }} p
  ON s.product_key = p.sales_product_key