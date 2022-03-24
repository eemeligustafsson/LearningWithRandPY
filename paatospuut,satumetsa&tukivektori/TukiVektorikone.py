#luokittelu
#tukivektorikone
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import svm
from sklearn.metrics import confusion_matrix, accuracy_score

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

#tehdään aliit ja opetetaan ne
malli01 = svm.SVC(kernel='linear', C=1.0)
malli02 = svm.SVC(kernel='poly', gamma='scale', C=1.0, coef0=0)
malli03 = svm.SVC(kernel='poly', gamma='scale', C=1.5, coef0=0)
malli04 = svm.SVC(kernel='poly', gamma='scale', C=0.01, coef0=0)

#opetetaan mallit
malli01.fit(X_train, Y_train)
malli02.fit(X_train, Y_train)
malli03.fit(X_train, Y_train)
malli04.fit(X_train, Y_train)

#tehdään ennusteet testidatalle
y_pred01 = malli01.predict(X_test)
y_pred02 = malli02.predict(X_test)
y_pred03 = malli03.predict(X_test)
y_pred04 = malli04.predict(X_test)

#ennustuksien tarkuudet
print(f"Mallin 01 tarkkuus: {round(accuracy_score(Y_test, y_pred01),4)}")
print(confusion_matrix(Y_test, y_pred01))

print(f"Mallin 02 tarkkuus: {round(accuracy_score(Y_test, y_pred02),4)}")
print(confusion_matrix(Y_test, y_pred02))

print(f"Mallin 03 tarkkuus: {round(accuracy_score(Y_test, y_pred03),4)}")
print(confusion_matrix(Y_test, y_pred03))

print(f"Mallin 04 tarkkuus: {round(accuracy_score(Y_test, y_pred04),4)}")
print(confusion_matrix(Y_test, y_pred04))