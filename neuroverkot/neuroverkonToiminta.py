#neuroverkko

import numpy as np
 
#1. neuroni
def neuroverkko(syotteet, painot):
    tulos = syotteet.dot(painot)
    return tulos

#1 syöte, 1 neuroni (1x1 painokerrointa) -> tulos
x=np.array([3.6])
w=np.array([0.15])
tulos1=neuroverkko(x, w)

#3 syötettä, 1 neuroni (3x1) -> 1 tulos
x=np.array([3.6,0.65,7])
w=np.array([0.1,0.2,0.05])
tulos2=neuroverkko(x, w)

#monta neuronia
def neuroVerkko(syotteet, painot):
    tulos=syotteet.dot(painot.T)
    return tulos

#3 syötettä, 3 neuronia (3x3) 3 tulosta
x=np.array([3.6,0.65,7])
w=np.array([[0.15,0.1,0.05],
           [0.1,0.2,0.05],
           [0.1,0.3,0.1]])

tulos3=neuroVerkko(x, w)

#monta neuronia & piilokerros
def neuroVErkko(syotteet, painot):
    piilo = syotteet.dot(painot[0].T)
    tulos = piilo.dot(painot[1].T)
    return tulos

#3 syotettä, 3 neuronia (piilokerros) (3x3 painokerrointa) ->
#3 tulosta jotka syötteinä 2 neuronin tuloskerrokseen (3x2 painokerrointa) ->
#2 tulosta

x=np.array([3.6,0.65,7])
w1=np.array([[0.15,0.1,0.05],
           [0.1,0.2,0.05],
           [0.1,0.3,0.1]])
w2=np.array([[0.2,0.2,0.2],
           [0.4,0.3,0.2]])
w=np.array([w1,w2])

tulos4=neuroVErkko(x, w)















