data <- read.csv2('koepalat.csv')

data_clean <- data[!is.na(data$paksuus),]
data_clean <- data_clean[!is.na(data_clean$yhdenmukaisuus1),]
data_clean <- data_clean[!is.na(data_clean$yhdenmukaisuus2),]
data_clean <- data_clean[!is.na(data_clean$adheesio),]
data_clean <- data_clean[!is.na(data_clean$koko),]
data_clean <- data_clean[!is.na(data_clean$ydin),]
data_clean <- data_clean[!is.na(data_clean$kromatiini),]
data_clean <- data_clean[!is.na(data_clean$nukleoli),]
data_clean <- data_clean[!is.na(data_clean$mitoosi),]
data_clean <- data_clean[!is.na(data_clean$luokka),]

data_clean$luokka <- factor(data_clean$luokka)

library(caTools)
set.seed(581)
split <- sample.split(data_clean$paksuus, SplitRatio = 0.70)
data_train <- subset(data_clean, split==TRUE)
data_test <- subset(data_clean, split==FALSE)

luokittelu <- function(oikeat, ennusteet, raja){
  table(oikeat, ifelse(ennusteet > raja, "hyvä", "paha"))
}
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

#logisttinen regressio malli opetusdatalle
malli <- glm(luokka ~ ., data = data_train, family = binomial)
summary(malli)
#ennusteet
ennusteet1 <- predict(malli, type = "response", newdata = data_test)
#luokittelumatriisi
matrix1 <- luokittelu(data_test$luokka, ennusteet1, 0.5)
#tarkkuus
tarkkuus1 <- tarkkuus(matrix1[1,1], matrix1[2,2], matrix1[1,2], matrix1[2,1])
  
  
  
  
