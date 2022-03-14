#luokittelu satunnaismetsä
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report, confusion_matrix

#data
data = pd.read_csv('framingham.csv')

#datan katsastelua
print(f"datan puuttuvat arvot: {data.isnull().sum()}")
data = data.dropna()

data_y = data['TenYearCHD']
data_X = data.loc[:, data.columns != 'TenYearCHD']

#Datan jakaminen opetus- ja testidataan - 25% testiin
X_train, X_test, Y_train, Y_test = train_test_split(data_X, 
                                                    data_y, 
                                                    test_size=0.25, 
                                                    random_state=72)

#tehdään malli
malli = RandomForestClassifier(n_estimators=200, random_state=123)
malli = malli.fit(X_train, Y_train)

#tehdään ennusteet
y_pred = malli.predict(X_test)
#ennusteiden tarkkuus ja luokittelumatriisi
print(f"Mallin 1 tarkkuus: {round(accuracy_score(Y_test, y_pred),4)}")
print(confusion_matrix(Y_test, y_pred))
print(classification_report(Y_test, y_pred, target_names=['Ei sairastu', 'sairastuu']))