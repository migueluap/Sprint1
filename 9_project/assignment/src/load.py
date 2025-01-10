from typing import Dict

from sqlalchemy.exc import SQLAlchemyError  # Add this import
from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    # TODO: Implement this function. For each dataframe in the dictionary, you must
    # use pandas.Dataframe.to_sql() to load the dataframe into the database as a
    # table.
    # For the table name use the `data_frames` dict keys.
    
        # Create SQLite connection
    #engine = create_engine(f'sqlite:///{database}')
    

    try:
        # Create SQLite connection
        engine = database
        
        # Iterate through the dictionary and load each DataFrame
        for table_name, df in data_frames.items():
            try:
                if df.empty:
                    print(f"Skipping empty DataFrame for table: {table_name}")
                    continue
                    
                df.to_sql(
                    name=table_name,
                    con=engine,
                    if_exists='replace',
                    index=False
                )
                print(f"Successfully loaded table: {table_name}")
                
            except Exception as e:
                print(f"Error loading table {table_name}: {str(e)}")
                raise
                
    except SQLAlchemyError as e:
        print(f"Database connection error: {str(e)}")
        raise


    
    # Iterate through the dictionary and load each DataFrame
    '''
    for table_name, df in data_frames.items():
        df.to_sql(
            name=table_name,
            con=database,
            if_exists='replace',  # Replace table if it already exists
            index=False  # Don't include DataFrame index as a column
        )
    
    # Close the connection
    #engine.dispose()
    '''