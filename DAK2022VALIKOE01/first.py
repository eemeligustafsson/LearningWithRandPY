import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import math

df = pd.read_csv('airbnb.csv')

print(df.isna().sum())
print(df.count())

print(round(0.205583393, 4))