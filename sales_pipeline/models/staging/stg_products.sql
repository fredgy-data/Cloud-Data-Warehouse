SELECT
  -- Primary key
  CAST(prd_id AS INT64) AS product_id,

  -- Business key
  prd_key AS product_key,

  -- 👇 derived key to match sales
  REGEXP_EXTRACT(prd_key, r'([A-Z]{2}-[A-Z0-9]+-[0-9]+)$') AS sales_product_key,
  
  -- Clean name
  INITCAP(TRIM(prd_nm)) AS product_name,

  -- Standardized product line
  UPPER(TRIM(prd_line)) AS product_line,

  -- Cost (ensure numeric)
  SAFE_CAST(prd_cost AS FLOAT64) AS cost,

  -- Dates
  DATE(prd_start_dt) AS start_date,
  DATE(prd_end_dt) AS end_date,

  -- Status flag (very useful in analytics)
  CASE 
    WHEN prd_end_dt IS NULL THEN 'Active'
    ELSE 'Inactive'
  END AS product_status

FROM {{ source('raw', 'bronze_products') }}