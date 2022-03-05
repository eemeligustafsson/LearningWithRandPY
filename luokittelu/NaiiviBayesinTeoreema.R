#luokittelu
#Naiivi bayesin luokittelu eli ei suhdetta(naiivi)

data <- read.csv('framingham.csv')

#uusi puhdas data NA rivit poistettuna
data_clean <- data[!is.na(data$education),]
data_clean <- data_clean[!is.na(data_clean$cigsPerDay),]
data_clean <- data_clean[!is.na(data_clean$BPMeds),]
data_clean <- data_clean[!is.na(data_clean$totChol),]
data_clean <- data_clean[!is.na(data_clean$BMI),]
data_clean <- data_clean[!is.na(data_clean$heartRate),]
data_clean <- data_clean[!is.na(data_clean$glucose),]

#luokittelumatriisi (ristiintaulukointi funktio)
luokittelu <- function(oikeat, ennusteet, raja){
  table(oikeat, ennusteet > raja)
}

#tarkkuus funktio
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

#naiivi bayesilainen luokittelu olettaa, että ennustukseen käytetyt muuttujat ovat
#keskenään riippumattomia 
library(corrplot)
corrplot(cor(data,use="pairwise.complete.obs"))
#havaitaan TenYearCHD kanssa korreloivat muuttujat

corrplot(cor(data[c('sysBP', 'age', 'prevalentHyp', 'diaBP')],use="pairwise.complete.obs"))
#havaitaan että sysBP ja biaBP korreloivat vahvasti jätetään diaBP pois
#havaitaan että sysBP ja prevalentHyp korreloivat vahvasti jätetään prevalentHyp pois

corrplot(cor(data[c('sysBP', 'age', 'male', 'BPMeds', 'diabetes', 'totChol', 'BMI', 'glucose')],use="pairwise.complete.obs"))
#havaitaan että diabetes ja glucose välillä korrelaatio, glucose pois


#jaetaan opetus ja testidata
library(caTools)
set.seed(72)
split <- sample.split(data_clean$male, SplitRatio = 0.75)
data_train <- subset(data_clean, split==TRUE)
data_test <- subset(data_clean, split==FALSE)

#luokittelun tekeminen
install.packages('e1071')
library(e1071)

#tehdään ja opetetaan malli
malli <- naiveBayes(TenYearCHD ~ sysBP + age + male + totChol + BPMeds + diabetes + BMI, data=data_train)

#tehdään mallilla ennusteet
ennusteet <- predict(malli, newdata = data_test, type="raw")

#tarkkuus
matriisi <- luokittelu(data_test$TenYearCHD, ennusteet[,2], 0.5)
tarkkuus(matriisi[1,1], matriisi[2,2], matriisi[1,2], matriisi[2,1])
