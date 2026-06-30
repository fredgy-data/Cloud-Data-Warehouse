SELECT DISTINCT product_key FROM {{ ref('stg_sales') }} LIMIT 20;
SELECT DISTINCT product_key FROM {{ ref('stg_products') }} LIMIT 20;