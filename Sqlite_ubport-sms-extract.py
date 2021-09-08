#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep  8 15:56:54 2021
@author: fabien
"""

import sqlite3
import pandas as pd

# open database and select
db = sqlite3.connect('history.sqlite')
cursor = db.cursor()

# excute list table (SQL query)
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()

# extract data for each table
table_list = []
for table_name in tables:
    table_name = table_name[0]
    table_list += [pd.read_sql_query("SELECT * from %s" % table_name, db)]

# close 
cursor.close()
db.close()