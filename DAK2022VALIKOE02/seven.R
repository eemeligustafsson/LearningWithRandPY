data <- read.csv('climate_change.csv')
library('caTools')

data_train  <- subset(data, data$Year <= 2006)
data_test <- subset(data, data$Year >= 2007)

malli01 <- lm(Temp ~ MEI + CFC.11 + CFC.12+ TSI + Aerosols, 
              data=data_test)
summary(malli01)

ennuste01 <- predict(malli01, newdata=data_test)
RMSE01 <- sqrt(sum((data_test['Temp']-ennuste01)^2)/length(ennuste01))

err <- data_test - ennuste01
RSS <- sum(err^2)
y_mean <- mean(data_test$Temp)
TSS <- sum((data_test-y_mean)^2)

N <- length(data_test)
RSE <- sqrt(RSS/(N-2))

R2 <- 1 -(RSS/TSS)

