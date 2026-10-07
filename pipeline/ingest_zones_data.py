import os
import pandas as pd
from sqlalchemy import create_engine
from tqdm.auto import tqdm

os.system("wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv")

df_zones = pd.read_csv("taxi_zone_lookup.csv")

engine = create_engine('postgresql+psycopg://root:root@localhost:5432/ny_taxi')

df_zones.to_sql(name='zones', con=engine, if_exists='replace', index=False)

os.system("rm taxi_zone_lookup.csv")