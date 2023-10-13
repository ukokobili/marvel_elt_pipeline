# Marvel ELT Data Pipeline
## Tables of Contents
1. [Overview](#overview)
2. [Data Visualization](#data-visualization)
3. [Data Architecture](#data-architecture)
4. [Prerequisites](#prerequisites)
5. [How to Run This Project](#how-to-run-this-project)
6. [Lessons Learned](#lessons-learned)
7. [Contact](#contact)
   
## Overview 

This project is an ELT data pipeline using modern data stacks. It retrieves data from the ```Marvel API```, ingests it into ```AWS RDS Postgres``` using a ```Python``` script, which is automated by ```Prefect's``` workflow orchestration tool, transforms data with ```dbt``` to build a dimensional model, and loads it into a PostgreSQL database for analytics. Additionally, it employs ```GitHub Action``` ```CI/CD``` to create a workflow that builds models each time changes are made and pushed to the main branch of the ```Git``` repository.

## Data Visualization
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/Marvel_Dashboard.png)

## Conceptual Model
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/conceptual_model.png)

## Logical Model
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/logical_model.png)

## dbt Dag
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/dbt-dag.png)

## Data Architecture
![](https://github.com/ukokobili/marvel_elt_pipeline/blob/main/images/Marvel_ELT_Achitecture.png)
I chose the following tools for this project because they are a good combination for learning about ```ELT```, workflow orchestration, as well as ```CI/CD```, and they also collectively address data extraction, automation, transformation, modeling, and deployment needs for a data pipeline project.


### Architecture and Tools Summary:
* **Data Source**: ```Marvel API``` for data source.
* **Data Ingestion**: ```Python``` script for extracting and loading data into ```AWS RDS PostgreSQL```.
* **Database**: ```AWS RDS PostgreSQL``` for structured data storage.
* **Workflow Orchestration**: ```Prefect's``` Workflow Orchestration tool for automation, scheduling, and error handling.
* **Data Transformation**: ```dbt``` (Data Build Tool) for transforming and modeling data.
* **Data Modeling**: Creation of a dimensional model for analytics.
* **CI/CD**: ```GitHub Action``` ```CI/CD``` to automate testing and deployment of data models on changes to the main branch.
* **Data Analytics and Visualization**: ```Qlik Sense``` for creating interactive dashboards, data exploration, and reporting.

## Prerequisites
* Marvel Studio API Keys
* Python
* Prefect CLI
* AWS RDS Account
* dbt core
* GitHub Action
* Docker
* Qlik Sense Account
  
## How to Run This Project
In order to run this project step-by-step you need to install the following packages:
1. Run ```pip install pipenv`` to create a virtual environment
2. Install the dependencies by running ```pipenv install -r requirements.txt```
3. Enter your Marvel Studio API secrets credentials in ```.env``` file
4. Run the ```extract_load.py``` file to start the EL(Extract & Load phase) with ```Prefect```. Please refer to [this tutorial](https://www.youtube.com/playlist?list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb) on how to configure Prefect.
5. Install ```dbt core``` on your local machine. Please refer to [this tutorial](https://www.youtube.com/playlist?list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb) install and run ```dbt core```.
6. Implement the ```GitHub Action``` by creating the ```.github/workflows``` dir in the main branch and add the ```workflow.yml``` file to the ```.github/workflows``` dir
7. Connect the ```Qlik Sense``` to the ```AWS RDS``` and create your visualization.

## Lessons Learned
One of the key takeaways from this project is the importance of scalability and flexibility in designing data pipelines. By utilizing cloud-based solutions like AWS RDS PostgreSQL, the project ensures scalability to handle varying data volumes. Additionally, the ability to adapt to changing requirements, data sources, and business needs is crucial. The choice of modular tools and technologies facilitates easy modifications and enhancements to the pipeline, allowing it to evolve alongside the organization's requirements.

## Contact
You can reach me on [LinkedIn](https://www.linkedin.com/in/jacobukokobili/) to learn more about this project, and I'm open to collaboration.
