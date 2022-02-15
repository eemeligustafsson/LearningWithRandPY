data <- read.csv('climate_change.csv')
library('caTools')

data_train  <- subset(data, data$Year <= 2006)
data_test <- subset(data, data$Year >= 2007)

malli01 <- lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, 
              data=data)
summary(malli01)


library(corrplot)
korrelaatiomatriisi <- cor(data)
corrplot(korrelaatiomatriisi)