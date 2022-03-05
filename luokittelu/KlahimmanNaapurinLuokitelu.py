#luokittelu
#K-lähimmän naapurin menetelmä

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier

from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report, confusion_matrix

#data
data = pd.read_csv('framingham.csv')

#datan katsastelua
print(f"datan puuttuvat arvot: {data.isnull().sum()}")
data = data.dropna()

data_y = data['TenYearCHD']
data_X = data.loc[:, data.columns != 'TenYearCHD']

#skaalataan data_X
skaalaaja = StandardScaler()
skaalaaja.fit(data_X)
data_scaled_X = skaalaaja.transform(data_X)

#Datan jakaminen opetus- ja testidataan - 25% testiin
X_train, X_test, Y_train, Y_test = train_test_split(data_scaled_X, 
                                                    data_y, 
                                                    test_size=0.25, 
                                                    random_state=72)

#tehdään mallit
malli1 = KNeighborsClassifier(n_neighbors=5)
malli1.fit(X_train, Y_train)

malli2 = KNeighborsClassifier(n_neighbors=7)
malli2.fit(X_train, Y_train)

malli3 = KNeighborsClassifier(n_neighbors=9)
malli3.fit(X_train, Y_train)

#tehdään ennusteet testidatalle
y_pred1 = malli1.predict(X_test)
y_pred2 = malli2.predict(X_test)
y_pred3 = malli3.predict(X_test)

#ennusteiden tarkkuus ja luokittelumatriisi
print(f"Mallin 1 tarkkuus: {round(accuracy_score(Y_test, y_pred1),4)}")
print(confusion_matrix(Y_test, y_pred1))
print(classification_report(Y_test, y_pred1, target_names=['Ei sairastu', 'sairastuu']))

print(f"Mallin 2 tarkkuus: {round(accuracy_score(Y_test, y_pred2),4)}")
print(confusion_matrix(Y_test, y_pred2))
print(classification_report(Y_test, y_pred2, target_names=['Ei sairastu', 'sairastuu']))

print(f"Mallin 3 tarkkuus: {round(accuracy_score(Y_test, y_pred3),4)}")
print(confusion_matrix(Y_test, y_pred3))
print(classification_report(Y_test, y_pred3, target_names=['Ei sairastu', 'sairastuu']))

#testataan mallit K:n arvoille 3-30
errors = []
for i in range(3, 31):
    malli = KNeighborsClassifier(n_neighbors=i)
    malli.fit(X_train, Y_train)
    pred_i = malli.predict(X_test)
    errors.append(np.mean(pred_i != Y_test))
    
#visualisoidaan virheet
plt.figure(figsize=(12,6))
plt.plot(range(3,31), errors, color='blue', linestyle='dashed', marker='o',
         markerfacecolor='red', markersize=10)
plt.title("Virghe eri k:n arvoille")
plt.xlabel("k:n arvo")
plt.ylabel("Keskivirhe")
    







