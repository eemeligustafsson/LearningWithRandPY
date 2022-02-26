data <- read.csv("framingham.csv")
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
#jaetaan opetus ja testidata
set.seed(72)
split <- sample.split(data_clean$male, SplitRatio = 0.75)
data_train <- subset(data_clean, split==TRUE)
data_test <- subset(data_clean, split==FALSE)

#luokittelumatriisi (ristiintaulukointi funktio)
luokittelu <- function(oikeat, ennusteet, raja){
  table(oikeat, ennusteet > raja)
}

#tarkkuus funktio
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

#logisttinen regressio malli opetusdatalle
malli <- glm(TenYearCHD ~ ., data = data_train, family = binomial)
summary(malli)

#uusi malli tilastollisesti merkittävistä muuttujista
malli01 <- glm(TenYearCHD ~ sysBP + male + age + totChol + cigsPerDay, data = data_train, family = binomial)
summary(malli01)

#uusi malli tilastollisesti merkittävistä muuttujista
malli02 <- glm(TenYearCHD ~ sysBP + male + age + cigsPerDay, data = data_train, family = binomial)
summary(malli02)

#tehdään testidatalle ennusteet
ennuste1 <- predict(malli, type ="response", newdata=data_test)
ennuste2 <- predict(malli01, type ="response", newdata=data_test)
ennuste3 <- predict(malli02, type ="response", newdata=data_test)

#malli
#luokittelumatriisi
matriisi1 <- luokittelu(data_test$TenYearCHD, ennuste1, 0.5)
#tarkkuus
tarkkuus1 <- tarkkuus(matriisi1[1,1], matriisi1[2,2], matriisi1[1,2], matriisi1[2,1])


#malli01
#luokittelumatriisi
matriisi2 <- luokittelu(data_test$TenYearCHD, ennuste2, 0.5)
#tarkkuus
tarkkuus2 <- tarkkuus(matriisi2[1,1], matriisi2[2,2], matriisi2[1,2], matriisi2[2,1])


#malli02
#luokittelumatriisi
matriisi3 <- luokittelu(data_test$TenYearCHD, ennuste3, 0.5)
#tarkkuus
tarkkuus3 <- tarkkuus(matriisi3[1,1], matriisi3[2,2], matriisi3[1,2], matriisi3[2,1])
