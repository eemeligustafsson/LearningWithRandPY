#luokittelu
#tukivektorikone

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
library(e1071) #samassa naiivi Bayesilainen luokitus

#jaetaan opetus ja testidatat
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

#tehdään mallit
malli01 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'linear')
summary(malli01)
malli02 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'polynomial')
summary(malli02)
malli03 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'radial')
summary(malli03)
malli04 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'sigmoid')
summary(malli04)

#ennusteet
ennusteet01 <- predict(malli01, newdata = data_test)
ennusteet02 <- predict(malli02, newdata = data_test)
ennusteet03 <- predict(malli03, newdata = data_test)
ennusteet04 <- predict(malli04, newdata = data_test)

#luokittelutulokset
matriisi01 <- table(data_test$TenYearCHD, ennusteet01)
matriisi02 <- table(data_test$TenYearCHD, ennusteet02)
matriisi03 <- table(data_test$TenYearCHD, ennusteet03)
matriisi04 <- table(data_test$TenYearCHD, ennusteet04)

#tarkkuudet
tarkkuus(matriisi01[1,1], matriisi01[2,2], matriisi01[1,2], matriisi01[2,1])
tarkkuus(matriisi02[1,1], matriisi02[2,2], matriisi02[1,2], matriisi02[2,1])
tarkkuus(matriisi03[1,1], matriisi03[2,2], matriisi03[1,2], matriisi03[2,1])
tarkkuus(matriisi04[1,1], matriisi04[2,2], matriisi04[1,2], matriisi04[2,1])

#lisää malleja
malli5 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'polynomial', cost = 0.01)
malli6 <- svm(TenYearCHD ~ ., data = data_train, kernel = 'polynomial', cost = 1.5)
ennusteet5 <- predict(malli5, newdata = data_test)
ennusteet6 <- predict(malli6, newdata = data_test)
matriisi5 <- table(data_test$TenYearCHD, ennusteet5)
matriisi6 <- table(data_test$TenYearCHD, ennusteet6)
tarkkuus(matriisi5[1,1], matriisi5[2,2], matriisi5[1,2], matriisi5[2,1])
tarkkuus(matriisi6[1,1], matriisi6[2,2], matriisi6[1,2], matriisi6[2,1])