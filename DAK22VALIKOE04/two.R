data <- read.csv2('winequality-white.csv')

library(caTools)
library(rpart)
install.packages('randomForest')
library(randomForest)

set.seed(44)
split <- sample.split(data$quality, SplitRatio = 0.70)
data_train <- subset(data, split==TRUE)
data_test <- subset(data, split==FALSE)

luokittelu <- function(oikeat, ennusteet){
  table(round(oikeat, digits = 0), round(ennusteet, digits = 0))
}
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}
set.seed(100)
malli <- randomForest(quality ~ ., data=data_train, ntree=150)
ennusteet <- predict(malli, newdata=data_test, type="class")

matriisi <- luokittelu(data_test$quality, ennusteet)
tarkkuus(matriisi[1,1], matriisi[2,2], matriisi[1,2], matriisi[2,1])
