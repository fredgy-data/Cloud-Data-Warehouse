# Cloud Data Warehouse Project (BigQuery + dbt + Prefect)

![pipeline architecture](https://github.com/fredcodess/data-engineering/blob/main/images/pl-archi.png?raw=true)

## Overview

This project builds an end-to-end **data engineering pipeline** using different tools to transform raw sales data into analytics-ready datasets and dashboards.

The pipeline follows a **Medallion Architecture (Bronze → Silver → Gold)** and is fully automated using orchestration.

---


**Pipeline Flow:**

```
Raw CSV → BigQuery (Bronze)
        → dbt (Silver & Gold transformations)
        → Prefect (orchestration)
        → Dashboard (Looker Studio)
```

---

## 🛠 Tech Stack

* **Data Warehouse:** Google BigQuery
* **Transformations:** dbt
* **Orchestration:** Prefect
* **Visualization:** Looker Studio

---

## 📂 Data Model

The project uses a **Medallion Architecture**:

### 🥉 Bronze Layer (Raw Data)

* Raw CSV files ingested into BigQuery
* No transformations applied

Tables:

* `bronze_customers`
* `bronze_products`
* `bronze_sales`

---

### 🥈 Silver Layer (Cleaned Data)

* Data cleaned and standardized using dbt staging models
* Handles:

  * Null values
  * Data types
  * Text normalization
  * Date conversions

Models:

* `stg_customers`
* `stg_products`
* `stg_sales`

---

### 🥇 Gold Layer (Business-Ready Data)

* Final analytics tables for reporting

Model:

* `fct_sales`

Includes:

* Customer + product joins
* Revenue calculations
* Order status
* Clean business metrics

---

## 🔄 Pipeline Workflow

1. **Ingestion**

   * Raw CSV data loaded into BigQuery (Bronze)

2. **Transformation (dbt)**

   * Staging models clean and standardize data
   * Fact table joins dimensions and calculates metrics

3. **Orchestration (Prefect)**

   * Pipeline runs:

     * `dbt run`
     * `dbt test`
   * Includes logging and failure handling

4. **Analytics**

   * Data consumed in dashboard

---

## ⚙️ How to Run the Project

### 1. Install dependencies

```bash
pip install dbt-bigquery prefect
```

---

### 2. Run dbt models

```bash
dbt run
```

---

### 3. Run tests

```bash
dbt test
```

---

### 4. Run pipeline

```bash
python pipeline.py
```

---

## 📊 Dashboard

The dashboard provides insights into:

* Total revenue
* Revenue trends over time
* Top products
* Top customers

---

## 📈 Example Insights

* A small group of customers contributes a large share of revenue
* Certain product lines dominate total sales
* Late shipments impact order completion rates

---

## 🧪 Data Quality

Data validation is implemented using dbt tests:

* Unique and non-null primary keys
* Valid relationships between tables

---

## 🔥 Key Features

* End-to-end data pipeline
* Cloud-based data warehouse
* Medallion architecture
* Automated workflows (Prefect)
* Data quality testing (dbt)
* Business-ready analytics layer

---

## 📁 Project Structure

```
project/
│
├── sales_pipeline/        # dbt project
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│
├── pipeline.py           # Prefect pipeline
├── prefect.yaml
├── README.md
```


---

## Author
[Fred](https://github.com/fredgy-data)
