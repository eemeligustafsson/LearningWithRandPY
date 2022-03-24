data <- read.csv2('TitanicMatkustajat.csv')

data_clean <- data[!is.na(data$MatkustajaId),]
data_clean <- data_clean[!is.na(data_clean$Selviytyi),]
data_clean <- data_clean[!is.na(data_clean$Matkustusluokka),]
data_clean <- data_clean[!is.na(data_clean$Nimi),]
data_clean <- data_clean[!is.na(data_clean$Sukupuoli),]
data_clean <- data_clean[!is.na(data_clean$Ika),]
data_clean <- data_clean[!is.na(data_clean$Lippu),]
data_clean <- data_clean[!is.na(data_clean$Hinta),]
data_clean <- data_clean[!is.na(data_clean$Hytti),]
data_clean <- data_clean[!is.na(data_clean$LahtoSatama),]

library(caTools)
library(caTools)
library(rpart)
library(rpart.plot)

set.seed(552)
split <- sample.split(data_clean$Selviytyi, SplitRatio = 0.75)
data_train <- subset(data_clean, split==TRUE)
data_test <- subset(data_clean, split==FALSE)

luokittelu <- function(oikeat, ennusteet){
  table(oikeat, ennusteet)
}

tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}
malli1 <- rpart(Selviytyi ~ Matkustusluokka + Sukupuoli + Ika + Hinta + LahtoSatama ,data=data_train, method="class", minbucket=1)
ennusteet1 <- predict(malli1, newdata = data_test, type = "class")
matriisi1 <- table(data_test$Selviytyi, ennusteet1)
tarkkuus(matriisi1[1,1], matriisi1[2,2], matriisi1[1,2], matriisi1[2,1])
prp(malli1)





library(caret)
set.seed(100)
trControl <- trainControl(method = "cv", number = 10)  # cv = cross-validation
cpArvot <- expand.grid(.cp = seq(0.009,0.02,0.0005))  # tutkittavat cp-arvot (23 kpl)
#Muodostetaan ristivalidoinnilla erilaiset mallit
mallit <- train(Selviytyi ~ Matkustusluokka + Sukupuoli + Ika + Hinta + LahtoSatama, data=data_train, method = "rpart", trControl = trControl, tuneGrid = cpArvot)





