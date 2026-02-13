FROM apache/airflow:2.10.5

USER root
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

USER airflow
RUN pip install --no-cache-dir \
    duckdb \
    psycopg2-binary