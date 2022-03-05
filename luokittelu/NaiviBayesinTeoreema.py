#luokittelu
#Naiivi bayesin luokittelu

import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report

#data
data = pd.read_csv('framingham.csv')

#datan katsastelua
print(f"datan puuttuvat arvot: {data.isnull().sum()}")

data = data.dropna()

data_y = data['TenYearCHD']
data_X = data.loc[:, data.columns != 'TenYearCHD']

#korrelaatiomatriisi
korrelaatiot = data_X.corr()
korrelaatiot.style.background_gradient(cmap='coolwarm')

#Datan jakaminen opetus- ja testidataan - 25% testiin
X_train, X_test, Y_train, Y_test = train_test_split(data_X, 
                                                    data_y, 
                                                    test_size=0.25, 
                                                    random_state=72)

data_X = data.loc[:, (data.columns != 'TenYearCHD') & 
                  (data.columns != 'prevalentHyp') &
                  (data.columns != 'currentSmoker') & 
                  (data.columns != 'prevalentHyp')
                  ]


#tehdään malli opetusdataa käyttäen
malli = GaussianNB()
malli.fit(X_train, Y_train)

#tehdään testidatalle ennusteet
y_pred = malli.predict(X_test)

#ennusteen tarkkuus & luokittelumatriisi
print(f"Tarkkuus: {round(accuracy_score(Y_test, y_pred),4)}")
print(f"{classification_report(Y_test, y_pred, target_names=['ei sairastu', 'sairastuu'])}")
