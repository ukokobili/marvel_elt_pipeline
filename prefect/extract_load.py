import psycopg2
import pandas as pd
from sqlalchemy import create_engine
from api_request import stories, comics, events, characters, series
from prefect_sqlalchemy import SqlAlchemyConnector
from prefect import flow, task

@task(log_prints=True, retries=3)
def extract_data():
    """Extract all data from the API and store in dictionary."""
    data = {'tables': ['stories', 'comics', 'events', 'characters', 'series'],
            'dfs': [stories(), comics(), events(), characters(), series()]}
    return data

@task(log_prints=True, retries=3)
def load_db(data):
    """Connects to the database."""
    connection_block = SqlAlchemyConnector.load("postgres-connector")
    with connection_block.get_connection(begin=False) as engine:

        """Loads the data into the database."""
        for table, df in zip(data['tables'], data['dfs']):
            df.to_sql(name=table, con=engine, if_exists='replace', index=False)

# Define your Prefect flow
@flow(name='Extract and Load')
def main_flow():
    """Runs the EL."""
    data = extract_data()
    load_db(data)


if __name__ == '__main__':
    main_flow()