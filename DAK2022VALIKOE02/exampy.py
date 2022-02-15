import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.metrics import mean_squared_error as MSE
from sklearn.metrics import r2_score

data = pd.read_csv('bikerental.csv')

Y = data['cnt']
X = data[['workingday', 'weathersit', 'hum', 'casual', 'temp', 'windspeed', 'hr', 'season']]
cols = ['workingday', 'weathersit', 'hum', 'casual', 'temp', 'windspeed', 'hr', 'season']
lm = LinearRegression()
lm.fit(data[cols], Y)
Y_test_pred = lm.predict(data[cols])
RMSE = np.sqrt(MSE(Y, Y_test_pred))
R2 = r2_score(Y, Y_test_pred)
print(f"RMSE on {RMSE}")
print(f"R2 on {R2}")