import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error as MSE
from sklearn.metrics import r2_score as R2

def teeLineaariRegressio(X, y, testiosuus=0.25, siemen=100):
    #ositetaan data testi ja opetusdataan
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=testiosuus, random_state=siemen)
    #lineaari-objekti
    regressio = LinearRegression()
    #opetetaan malli
    regressio.fit(X_train , y_train)
    #tehdään ennuste
    y_pred = regressio.predict(X_test)
    #tulostetaan tiedot(MSE, RMSE, R2)
    print('Parametrit \n',regressio.coef_)
    print('Neliökeskivirhe MSE: %.2f' % MSE(y_test, y_pred))
    print('Jäännöskeskivirhe RMSE: %.2f' % np.sqrt(MSE(y_test, y_pred)))
    print('Mallin selitysaste R2: %.2f' % R2(y_test, y_pred))
    #PALAUTETAAN MALLI
    return regressio