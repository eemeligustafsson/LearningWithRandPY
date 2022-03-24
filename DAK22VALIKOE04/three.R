library(caTools)
library(e1071)
data <- read.csv('loans_imputed.csv')
 
set.seed(144)
split <- sample.split(data$not.fully.paid, SplitRatio = 0.7)
data_train <- subset(data, split==TRUE)
data_test <- subset(data, split==FALSE)

luokittelu <- function(oikeat, ennusteet, raja){
  table(oikeat, ifelse(ennusteet > raja, 1, 0))
}
#tarkkuus funktio
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}
malli01 <- svm(not.fully.paid ~ credit.policy + purpose + installment + log.annual.inc + fico + revol.bal + inq.last.6mths + pub.rec ,data = data_train, kernel = 'polynomial')
ennusteet01 <- predict(malli01, newdata = data_test)

matriisi1 <- luokittelu(data_test$not.fully.paid, ennusteet01, 0.5)
tarkkuus1 <- tarkkuus(matriisi1[1,1], matriisi1[2,2], matriisi1[1,2], matriisi1[2,1])
