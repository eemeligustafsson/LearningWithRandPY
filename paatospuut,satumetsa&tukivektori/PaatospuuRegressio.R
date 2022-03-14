#regressio
#päätöspuu

data <- read.csv('carprices_scaled.csv')

install.packages('caret')
install.packages('rpart')
install.packages('spart.slot')

library(caTools)
library(caret) #sisältää funktion RMSE
library(rpart)
library(rpart.plot)

#datan jako
set.seed(100)

#tehdään totuusarvoja sisältävä vektori jonka alkiomäärä on datan rivien määrä
split <- sample.split(data$CarName, SplitRatio = 0.75)
data_train <- subset(data, split == TRUE)
data_test <- subset(data, split == FALSE)

#tehdään lineaariregression malli (vertailun vuoksi)
malli1 <- lm(price ~ CarName + enginelocation + enginesize + stroke + horsepower, data=data_train)
#ennustetaan testidatalla
ennusteet1 <- predict(malli1, newdata=data_test)
RMSE(ennusteet1, data_test$price)

#tehdään päätöspuu
malli2 <- rpart(price ~ CarName + enginelocation + enginesize + stroke + horsepower, 
                data=data_train, method = 'anova')
#visualisoidaan
prp(malli2)
#ennustetaan
ennusteet2 <- predict(malli2, newdata=data_test, method="vector")
RMSE(ennusteet2, data_test$price)

#tehdään toinen päätöspuu
malli3 <- rpart(price ~ .,data=data_train, method = 'anova', control = rpart.control(cp=0.005))
#visualisoidaan
prp(malli3)
#ennustetaan
ennusteet3 <- predict(malli3, newdata=data_test, method="vector")
RMSE(ennusteet3, data_test$price)
