#luokittelu
#logistinen regressio

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report


data = pd.read_csv('framingham.csv')

#tutkitaan puuttuvia (null tietoja)
print(data.isnull().sum())

#poistetaan puuttuvat tiedot sisältämät rivit
data = data.dropna()



data_y = data['TenYearCHD'] #ennustettava data (sarake)
data_X = data.loc[:, data.columns != 'TenYearCHD'] #data josta ennustetaan (kaikki sarakeet) - TenYearCHD

#jaetaan train ja testidata, 25% testidataa
X_train, X_test, Y_train, Y_test = train_test_split(data_X,
                                                    data_y,
                                                    test_size=0.25,
                                                    random_state=72)

#malli opetusdataa käyttäen
malli = LogisticRegression(random_state=123, solver='lbfgs', multi_class='ovr').fit(X_train, Y_train)

#tehdään ennusteet testidatalle
y_pred = malli.predict(X_test)


#ennusteen tarkkuus ja luokittelumatriisi
print("Tarkkuus", end='')
print(round(accuracy_score(Y_test, y_pred),4))
print(classification_report(Y_test, y_pred, target_names=['ei sairastu','sairastuu']))

#uusi malli relevanteille sarakkeille
X_train = X_train[['sysBP','male', 'age', 'cigsPerDay']]
X_test = X_test[['sysBP','male', 'age', 'cigsPerDay']]
malli01 = LogisticRegression(random_state=123, solver='lbfgs', multi_class='ovr').fit(X_train, Y_train)

#tehdään ennusteet testidatalle
y_pred2 = malli01.predict(X_test)
#ennusteen tarkkuus ja luokittelumatriisi
print("Tarkkuus", end='')
print(round(accuracy_score(Y_test, y_pred2),4))
print(classification_report(Y_test, y_pred2, target_names=['ei sairastu','sairastuu']))
