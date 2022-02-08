#joitain esimerkkejä, lineaariregressio
import lineaarireg
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


#esimerkki1 X = 1D
X = np.array([5, 10, 15, 20, 25, 30, 35, 40 ,45, 50, 55]).reshape((-1,1))
y = np.array([5, 12, 20, 22, 14, 26, 32, 44, 22 ,47, 38])

malli = lineaarireg.teeLineaariRegressio(X, y)

#ennustaminen mallin avulla
y_pred = malli.predict(X)
#esimerkki2 X = 2D

#esimerkki3 X = ?D