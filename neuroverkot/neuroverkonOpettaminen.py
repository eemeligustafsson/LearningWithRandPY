#neuroverkon opettaminen

import numpy as np

#1. neuroni
def neuroverkko(syotteet, painot):
    tulos = syotteet.dot(painot)
    return tulos


def opeta(syotteet, painot, tulos, toistoLkm=4):
    print("Syötteet", syotteet, "Oikea tulos", tulos)
    for i in range(toistoLkm):
        print(f'----\nPaino: {str(painot)}')
        ennuste = neuroverkko(syotteet, painot)
        virhe = (ennuste - tulos)**2
        delta = ennuste - tulos
        paino_deltat = delta*syotteet
        painot = painot - paino_deltat
        print(f'ennuste: {str(round(ennuste,2))} MSE: {str(round(virhe,6))}')
        print(f'painomuutos: {str(paino_deltat)}')
    return painot

#1 syöte ja 1 neuroni (1x1 painokerrointa) = 1 tulos
x=np.array([3.6])
w=np.array([0.15])
y=0.8
w=opeta(x,w,y,5)

#lisätään alfa
def opeta(syotteet, painot, tulos, alfa, toistoLkm=4):
    print("Syötteet", syotteet, "Oikea tulos", tulos)
    for i in range(toistoLkm):
        print(f'----\nPaino: {str(painot)}')
        ennuste = neuroverkko(syotteet, painot)
        virhe = (ennuste - tulos)**2
        delta = ennuste - tulos
        paino_deltat = delta*syotteet
        painot = painot - alfa*paino_deltat
        print(f'ennuste: {str(round(ennuste,2))} MSE: {str(round(virhe,6))}')
        print(f'painomuutos: {str(alfa*paino_deltat)}')
    return painot

x=np.array([3.6])
w=np.array([0.15])
y=0.8
alfa=0.0012
w=opeta(x,w,y,alfa,100)
print(w)



#monta neuronia
def opeta(syotteet, painot, tulos, alfa, toistoLkm=4):
    print("Syötteet", syotteet, "Oikea tulos", tulos)
    for i in range(toistoLkm):
        print(f'----\nPaino: {str(painot)}')
        ennuste = neuroverkko(syotteet, painot)
        virhe = (ennuste - tulos)**2
        delta = ennuste - tulos
        paino_deltat = np.outer(delta,syotteet)
        painot = painot - alfa*paino_deltat
        print(f'ennuste: {str(ennuste)} MSE: {str(virhe)}')
        print(f'painomuutos: {str(alfa*paino_deltat)}')
    return painot

#3 syötettä 3 neuronia 3 tulosta
x=np.array([3.6,0.65,7])
w=np.array([[0.0,0.0,0.0],
            [0.0,0.0,0.0],
            [0.0,0.0,0.0]])
y=np.array([0.9,0.84,1.2])
alfa=0.01
w=opeta(x,w,y,alfa,8)
w=opeta(x,w,y,alfa,30)
print(w)



#monta neuronia + piilokerros ja aktivointifunktio
def relu(x):
    return (x>0)*x

def relu_derivaatta(x):
    return x > 0


def opeta(syotteet, painot1, painot2, tulos, alfa, toistoLkm=4):
    print("Syötteet", syotteet, "Oikea tulos", tulos)
    for toisto in range(toistoLkm):
        virhe = 0
        for i in range(len(syotteet)):
            syote_kerros = syotteet[i:i+1]
            piilo_kerros = relu(np.dot(syote_kerros, painot1))
            tulos_kerros = np.dot(piilo_kerros, painot2)
            virhe += np.sum((tulos_kerros-tulos[i:i+1])**2)
            delta_tulos = tulos[i:i+1]-tulos_kerros
            delta_piilo = delta_tulos.dot(painot2.T)*relu_derivaatta(piilo_kerros)
            painot2 += alfa * piilo_kerros.T.dot(delta_tulos)
            painot1 += alfa * syote_kerros.T.dot(delta_piilo)
            
            #tulostetaan suuruus joka 10 sykli
        if(toisto%10 == 9):
            print(f'virhe: {str(virhe)}')

    return (painot1, painot2)

x = np.array([[1,0,1],
              [0,1,1],
              [0,0,1],
              [1,1,1]])
y = np.array([[1,1,0,0]]).T

alfa = 0.2
piilo_koko = 4

#Painot alussa satunnaisiksi
np.random.seed(1)
#painot syöte vs piilokerros
w1 = 2*np.random.random((3,piilo_koko)) - 1
#painot piilo vs tuloskerros
w2 = 2*np.random.random((piilo_koko,1)) - 1

w1, w2 = opeta(x,w1,w2,y,alfa,60)

print(w1)
print(w2)

(1.5055*10)**-5