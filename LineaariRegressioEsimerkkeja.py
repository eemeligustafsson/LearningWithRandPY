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

#visualisointi, nähdään kuinka lähelle ennustaminen menee visuaalisesti
plt.scatter(X, y, color='black')
plt.plot(X,y_pred, color='blue', linewidth=3)
plt.xticks()
plt.yticks()
plt.show()
#esimerkki2 X = 2D
data = pd.DataFrame([[150,100],[159,200],[170,350],[175,400],[179,500],
                     [180,180],[189,159],[199,110],[199,400],[199,230],
                     [235,120],[239,340],[239,360],[249,145],[249,400]], 
                    columns=['Hinta', 'Mainoskulut'])

data['Myynti'] = pd.Series([0.73,1.39,2.03,1.45,1.82,
                            1.32,0.83,0.53,1.95,1.27,
                            0.49,1.03,1.24,0.55,1.3])

data_y = data['Myynti']
data_X = data.loc[:, data.columns != 'Myynti']

malli = lineaarireg.teeLineaariRegressio(data_X, data_y)
#ennustetaan uusi myynnin arvo
print(f'Hinta 220 + mainoskulut 150 --> Myynti {malli.predict(pd.DataFrame({"Hinta":[220], "Mainoskul":[150]}))}')

#visualisoidaan
#3D-kuva akselit x.y ja z
#Tehdään 3D kaaviota varten X Y ja Z akselit
#arvoalueen Hinta ja Mainoskulut-sarakkeista
x_surf, y_surf = np.meshgrid(np.linspace(data.Hinta.min(),
                                         data.Hinta.max(),
                                         100),
                             np.linspace(data.Mainoskulut.min(),
                                         data.Mainoskulut.max(),
                                         100))
#tehdään kaikki arvokombinaatiot edellä olevista akseliston x y arvoista
#karteesinen tulo, eli kaikkien Hintojen ja mainoskulujen eri kombinaatiot
Z = pd.DataFrame({'Hinta': x_surf.ravel(), 'Mainoskulut': y_surf.ravel()})
#ennustetaan Myynti edellä tehdyistä hinta ja mainoskulu sarakkeista
Myynti_pred = malli.predict(Z)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(data['Hinta'], data['Mainoskulut'],data['Myynti'],c='blue',marker='o', alpha=0.5)
ax.plot_surface(x_surf,y_surf,Myynti_pred.reshape(x_surf.shape), rstride=1, cstride=1, cmap='hot')
ax.set_xlabel('Hinta')
ax.set_ylabel('Mainoskulut')
ax.set_zlabel('Myynti')
ax.view_init(30,45)
plt.show()

#esimerkki3 X = ?D
data = pd.read_csv('diabetes_scaled.csv', index_col=0)
data_y = data['target'] #target
data_for_X = data.loc[:, data.columns != 'target'] #näistä valitaan x:n sarakkeet

#testataan 1 sarake kerrallaan
for i in range(0,len(data_for_X.columns)):
    data_X = data_for_X.iloc[:, [i]]
    print('\nx = ', data_X.columns.values)
    lineaarireg.teeLineaariRegressio(data_X, data_y)
    
#testataan 2 saraketta kerrallaa
for i in range(0,len(data_for_X.columns)):
    for j in range(i,len(data_for_X.columns)):
        if i!=j:
            data_X = data_for_X.iloc[:, [i,j]]
            print('\nX = ', data_X.columns.values)
            lineaarireg.teeLineaariRegressio(data_X, data_y)

#selitysaste R2 (suurin ensin)
#edellisen perusteella valitaan kaksi
#testataan bmi + s5 + joku kolmas
for i in range(0,len(data_for_X.columns)):
    if((data_for_X.columns.values[i]!= 'bmi') and
       (data_for_X.columns.values[i] != 's5')):
        data_X = data_for_X.loc[:, ['bmi', 's5', data_for_X.columns[i]]]
        print('\nX = ', data_X.columns.values)
        lineaarireg.teeLineaariRegressio(data_X, data_y)


#paras malli, voitiin selvittää tekemällä lisää samankaltaisia silmukoita kun yläpuolella
data_X = data_for_X.loc[:, ['bmi', 's5', 'bp', 's3','sex', 's6']]
print('\nX = ',data_X.columns.values)
malli = lineaarireg.teeLineaariRegressio(data_X, data_y)