SELECT
  -- Primary key
  CAST(cst_id AS INT64) AS customer_id,

  -- Business key
  cst_key AS customer_key,

  -- Names
  INITCAP(TRIM(cst_firstname)) AS first_name,
  INITCAP(TRIM(cst_lastname)) AS last_name,

  -- Derived full name
  CONCAT(
    INITCAP(TRIM(cst_firstname)),
    ' ',
    INITCAP(TRIM(cst_lastname))
  ) AS full_name,

  -- Standardized gender
  CASE 
    WHEN LOWER(cst_gndr) IN ('m', 'male') THEN 'Male'
    WHEN LOWER(cst_gndr) IN ('f', 'female') THEN 'Female'
    ELSE 'Unknown'
  END AS gender,

  -- Standardized marital status
  CASE 
    WHEN LOWER(cst_marital_status) IN ('s', 'single') THEN 'Single'
    WHEN LOWER(cst_marital_status) IN ('m', 'married') THEN 'Married'
    ELSE 'Unknown'
  END AS marital_status,

  -- Dates
  DATE(cst_create_date) AS created_date

FROM {{ source('raw', 'bronze_customers') }} WHERE cst_id IS NOT NULL