# Marvel ELT Data Pipeline
## Overview 

This project is an ELT data pipeline using modern data stacks. It retrieves data from the ```Marvel API```, ingests it into ``AWS RDS Postgres``` using a ```Python`` script, which is automated by ```Prefect's``` workflow orchestration tool, transforms data with ```dbt``` to build a dimensional model, and loads it into a PostgreSQL database for analytics. Additionally, it employs ```GitHub Action``` ```CI/CD``` to create a workflow that builds models each time changes are made and pushed to the main branch of the ```Git``` repository.

## Data Visualization
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/Marvel_Studio_Dashboard.png)

## Data Architecture
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/Marvel_ELT_Achitecture.png)
I chose the following tools for this project because they are a good combination for learning about ```ELT```, workflow orchestration, as well as ```CI/CD```, and they also collectively address data extraction, automation, transformation, modeling, and deployment needs for a data pipeline project.

### Architecture and Tools Summary:
* **Data Source**: ```Marvel API``` for data retrieval.
* **Data Ingestion**: ```Python``` script for extracting and loading data into ```AWS RDS PostgreSQL```.
* **Database**: ```AWS RDS PostgreSQL``` for structured data storage.
* **Workflow Orchestration**: ```Prefect's``` Workflow Orchestration tool for automation, scheduling, and error handling.
* **Data Transformation**: ```dbt``` (Data Build Tool) for transforming and modeling data.
* **Data Modeling**: Creation of a dimensional model for analytics.
* **CI/CD**: ```GitHub Action``` ```CI/CD``` to automate testing and deployment of data models on changes to the main branch.
* **Data Analytics and Visualization**: ```Qlik Sense``` for creating interactive dashboards, data exploration, and reporting.

## Prerequisites
