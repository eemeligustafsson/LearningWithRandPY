#luokittelu satunnaismetsä

data <- read.csv('framingham.csv')

#uusi puhdas data NA rivit poistettuna
data_clean <- data[!is.na(data$education),]
data_clean <- data_clean[!is.na(data_clean$cigsPerDay),]
data_clean <- data_clean[!is.na(data_clean$BPMeds),]
data_clean <- data_clean[!is.na(data_clean$totChol),]
data_clean <- data_clean[!is.na(data_clean$BMI),]
data_clean <- data_clean[!is.na(data_clean$heartRate),]
data_clean <- data_clean[!is.na(data_clean$glucose),]

data_clean$TenYearCHD <- as.factor(data_clean$TenYearCHD)

library(caTools)
library(rpart)
install.packages('randomForest')
library(randomForest)

#jaetaan opetus ja testidata
set.seed(72)
split <- sample.split(data_clean$male, SplitRatio = 0.75)
data_train <- subset(data_clean, split==TRUE)
data_test <- subset(data_clean, split==FALSE)

#luokittelumatriisi (ristiintaulukointi funktio)
luokittelu <- function(oikeat, ennusteet){
  table(oikeat, ennusteet)
}
#tarkkuus funktio
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

#¤tehdään random forest malli
malli <- randomForest(TenYearCHD ~ ., data=data_train, ntree=200)

#ennustetaan testidatalle (luokittelu)
ennusteet <- predict(malli, newdata=data_test, type="class")

#tarkkuus
matriisi <- table(data_test$TenYearCHD, ennusteet)
tarkkuus(matriisi[1,1], matriisi[2,2], matriisi[1,2], matriisi[2,1])
