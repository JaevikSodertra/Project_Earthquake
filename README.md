# Project Earthquake

Data-pipeline для сбора данных о землетрясениях с [USGS API](https://earthquake.usgs.gov/fdsnws/event/1/), хранения в S3-совместимом хранилище (MinIO) и загрузки в PostgreSQL DWH. Визуализация через Metabase.

## Архитектура

```
USGS API ──> DuckDB ──> MinIO (S3)
                            │
                            v
                        DuckDB ──> PostgreSQL DWH (ods) ──> Airflow (dm) ──> Metabase
```

**Airflow DAGs:**

| DAG | Описание |
|-----|----------|
| `raw_from_api_to_s3` | Забирает CSV с USGS API, сохраняет parquet в MinIO |
| `raw_from_s3_to_pg` | Читает parquet из MinIO, загружает в `ods.fct_earthquake` |
| `fct_count_day_earthquake` | Считает количество землетрясений за день → `dm.fct_count_day_earthquake` |
| `fct_avg_day_earthquake` | Считает среднюю магнитуду за день → `dm.fct_avg_day_earthquake` |

## Стек

- **Airflow 2.10.5** — оркестрация
- **DuckDB** — ETL-движок (httpfs + postgres extensions)
- **MinIO** — S3-совместимое хранилище
- **PostgreSQL 13** — DWH
- **Metabase** — BI / визуализация
- **Docker Compose** — инфраструктура

## Структура проекта

```
.
├── airflow/
│   ├── dags/                # DAG-файлы Airflow
│   ├── config/
│   ├── plugins/
│   └── logs/                # gitignored
├── postgres/
│   └── init_dwh.sql         # DDL: схема ods + таблица fct_earthquake
├── minio/
│   └── data/                # gitignored
├── metabase/
│   └── plugins/             # JDBC-драйверы для Metabase
├── docker-compose.yaml
├── Dockerfile               # Airflow + duckdb + psycopg2
├── req.txt
├── .env.example
└── README.md
```

## Быстрый старт

1. Скопировать `.env.example` в `.env` и при необходимости отредактировать:
   ```bash
   cp .env.example .env
   ```

2. Запустить инфраструктуру:
   ```bash
   docker-compose up -d
   ```

3. Настроить Airflow Variables через UI (`http://localhost:8080`):
   - `access_key` — ключ доступа MinIO
   - `secret_key` — секретный ключ MinIO
   - `pg_password` — пароль PostgreSQL DWH

## Сервисы

| Сервис | URL | Логин / Пароль |
|--------|-----|----------------|
| Airflow | http://localhost:8080 | airflow / airflow |
| MinIO Console | http://localhost:9001 | minioadmin / minioadmin |
| Metabase | http://localhost:3000 | — |
| PostgreSQL DWH | localhost:5432 | postgres / postgres |
