data <- read.csv('loans.csv')
sum(is.na(data))

install.packages('mice')
library(mice)
set.seed(843)
#määritellään imputoitavat muuttujat (kaikki muut paitsi not.fully.paid)
#käytetään joukko-operaatiota erotus
imputoitavat <- setdiff(names(data), "not.fully.paid")
#muodostetaan datasta imputoitu kopio
imputoitu <- complete(mice(data[imputoitavat]))
#ja sijoitetaan alkuperäisen tilalle
data[imputoitavat] <- imputoitu
#poistetaan kopio
rm(imputoitu)
sum(is.na(data))

data$notfullypaid <- factor(data$not.fully.paid)

luokittelu <- function(oikeat, ennusteet, raja){
  table(oikeat, ifelse(ennusteet > raja, 1, 0))
}
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

library(caTools)
#jaetaan opetus ja testidata
set.seed(144)
split <- sample.split(data$not.fully.paid, SplitRatio = 0.70)
data_train <- subset(data, split==TRUE)
data_test <- subset(data, split==FALSE)

malli1 <- glm(not.fully.paid ~ credit.policy + purpose + installment + log.annual.inc + fico + revol.bal + inq.last.6mths + pub.rec, data=data_train, family = binomial)

ennuste1 <- predict(malli1, type ="response", newdata=data_test)

#luokittelumatriisi
matrix1 <- luokittelu(data_test$not.fully.paid, ennuste1, 0.5)
#tarkkuus
tarkkuus1 <- tarkkuus(matrix1[1,1], matrix1[2,2], matrix1[1,2], matrix1[2,1])

