from prefect import flow, task, get_run_logger
from pathlib import Path
import subprocess

# Helps finding dbt_project.yml
PROJECT_PATH = Path(__file__).parent / "sales_pipeline"

@task
def run_dbt():
    logger = get_run_logger()
    logger.info("Running dbt models...")

    result = subprocess.run(
        ["dbt", "run"],
        cwd=PROJECT_PATH,
        capture_output=True,
        text=True
    )

    logger.info(result.stdout)

    if result.returncode != 0:
        logger.error(result.stderr)
        raise Exception(
            f"""
dbt run failed

STDOUT:
{result.stdout}

STDERR:
{result.stderr}
"""
        )


@task
def test_dbt():
    logger = get_run_logger()
    logger.info("Running dbt tests...")

    result = subprocess.run(
        ["dbt", "test"],
        cwd=PROJECT_PATH,
        capture_output=True,
        text=True
    )

    logger.info(result.stdout)

    if result.returncode != 0:
        logger.error(result.stderr)
        raise Exception(
            f"""
dbt test failed

STDOUT:
{result.stdout}

STDERR:
{result.stderr}
"""
        )


@flow
def sales_pipeline():
    run_dbt()
    test_dbt()


if __name__ == "__main__":
    sales_pipeline()
