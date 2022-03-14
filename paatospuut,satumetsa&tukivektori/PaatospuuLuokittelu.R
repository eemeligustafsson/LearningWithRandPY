#luokittelu päätöspuu

data <- read.csv('framingham.csv')
str(data)
summary(data)

#uusi puhdas data NA rivit poistettuna
data_clean <- data[!is.na(data$education),]
data_clean <- data_clean[!is.na(data_clean$cigsPerDay),]
data_clean <- data_clean[!is.na(data_clean$BPMeds),]
data_clean <- data_clean[!is.na(data_clean$totChol),]
data_clean <- data_clean[!is.na(data_clean$BMI),]
data_clean <- data_clean[!is.na(data_clean$heartRate),]
data_clean <- data_clean[!is.na(data_clean$glucose),]

library(caTools)
library(rpart)
library(rpart.plot)

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
#tehdään malli
malli1 <- rpart(TenYearCHD ~ .,data=data_train, method="class")

#tehdään ennusteet
ennusteet1 <- predict(malli1, newdata=data_test, type="class")

#tarkkuus
matriisi <- table(data_test$TenYearCHD, ennusteet1)
tarkkuus(matriisi[1,1], matriisi[2,2], matriisi[1,2], matriisi[2,1])
#visualisoidaan

prp(malli1)

