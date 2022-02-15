import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error as MSE
from sklearn.metrics import r2_score as R2

#helppokäyttöinen lineaariregression funktio
def teeLineaariRegressio(X, y):
    #ositetaan data testi ja opetusdataan
    #lineaari-objekti
    regressio = LinearRegression()
    #opetetaan malli
    regressio.fit(X, y)
    #tehdään ennuste
    y_pred = regressio.predict(X)
    #tulostetaan tiedot(MSE, RMSE, R2)
    print('Parametrit \n',regressio.coef_)
    print('Neliökeskivirhe MSE: %.2f' % MSE(y, y_pred))
    print('Jäännöskeskivirhe RMSE: %.2f' % np.sqrt(MSE(y, y_pred)))
    print('Mallin selitysaste R2: %.2f' % R2(y, y_pred))
    #PALAUTETAAN MALLI
    return regressio