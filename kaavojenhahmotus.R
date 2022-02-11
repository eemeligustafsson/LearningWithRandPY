y <- c(5,4,-1,3,-1,2)#data josta ennustetaan
y_hat <- c(4,3,0,3,1,0) #mallista tuotettu data

err <- y - y_hat##virheen määrä arvojen ennustavien ja tulosarvojen välillä
RSS <- sum(err^2)#virheiden neliöiden summat
y_mean <- mean(y)#ennustavien(todellisten) arvojen keskiarvo
TSS <- sum((y-y_mean)^2)#arvot - ennusteet neliöiden summa

N <- length(y)
RSE <- sqrt(RSS/(N-2))#jäännöskeskivirhe, kertoo kuinka paljon yksittäinen ennuste heittää keskimäärin

R2 <- 1 - (RSS/TSS)#selitysateen kaava, isompi parempi, välillä 0-1

n = 2 #selittäväviä muuttujia n kpl
F <- ((TSS - RSS) / n) / (RSS / (N - n -1))#isompi parempi, voidaan saada selville
                                            #millä sarakkeilla ennustaminen onnistuu hyvin