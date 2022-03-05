#luokittelu
#K-lähimmän naapurin luokittelu

data <- read.csv('framingham.csv')

#uusi puhdas data NA rivit poistettuna
data_clean <- data[!is.na(data$education),]
data_clean <- data_clean[!is.na(data_clean$cigsPerDay),]
data_clean <- data_clean[!is.na(data_clean$BPMeds),]
data_clean <- data_clean[!is.na(data_clean$totChol),]
data_clean <- data_clean[!is.na(data_clean$BMI),]
data_clean <- data_clean[!is.na(data_clean$heartRate),]
data_clean <- data_clean[!is.na(data_clean$glucose),]

#datassa tulee olla vain tilastollisesti normalisoituja numeerisia sarakkeita
#käytetään min-max skaalausta: (arvo-minini) / (maksimi-minimi)

normalisoi <- function(X){
  (X - min(X, na.rm=TRUE)) / (max(X,na.rm=TRUE) - min(X, na.rm=TRUE))
}

#normalisoidaan datan ennustukseen käytettävät sarakkeet
data_normalized <- as.data.frame(
  lapply(data_clean[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)], normalisoi))

data_target <- data_clean[,16]

#jaetaan opetus ja testidata
library(caTools)
set.seed(72)
split <- sample.split(data_normalized$male, SplitRatio = 0.75)
data_train <- subset(data_normalized, split==TRUE)
data_test <- subset(data_normalized, split==FALSE)
data_target_train <- subset(data_target, split==TRUE)
data_target_test <- subset(data_target, split==FALSE)

install.packages('class')
library(class)
#tehdään malleja eri K:n arvoilla
malli1 <- knn(train = data_train, test = data_test, cl = data_target_train, k=5) 
malli2 <- knn(train = data_train, test = data_test, cl = data_target_train, k=7)
malli3 <- knn(train = data_train, test = data_test, cl = data_target_train, k=9)

#tarkkuus funktio
tarkkuus <- function(TN, TP, FN, FP){
  return((TN*1.0+TP)/(TN+TP+FN+FP))
}

#tarkkuudet
matriisi1 <- table(data_target_test, malli1)
tarkkuus(matriisi1[1,1], matriisi1[2,2], matriisi1[1,2], matriisi1[2,1])

matriisi2 <- table(data_target_test, malli2)
tarkkuus(matriisi2[1,1], matriisi2[2,2], matriisi2[1,2], matriisi2[2,1])

matriisi3 <- table(data_target_test, malli3)
tarkkuus(matriisi3[1,1], matriisi3[2,2], matriisi3[1,2], matriisi3[2,1])
