data <- read.csv('wine.csv')
library(caTools)

korrelaatiomatriisi <- cor(data)
library(corrplot)
korrelaatiomatriisi <- cor(data)
corrplot(korrelaatiomatriisi)

malli01 <- lm(Price ~ AGST, 
              data=data)
summary(malli01)

malli02 <- lm(Price ~ AGST + HarvestRain, 
              data=data)
summary(malli02)

malli03 <- lm(Price ~ AGST + HarvestRain + Age, 
              data=data)
summary(malli03)

malli04 <- lm(Price ~ AGST + WinterRain + Age, 
              data=data)
summary(malli04)

malli05 <- lm(Price ~ AGST + HarvestRain + WinterRain, 
              data=data)
summary(malli05)

malli06 <- lm(Price ~ AGST + HarvestRain + WinterRain + Age, 
              data=data)
summary(malli06)

malli07 <- lm(Price ~ AGST + HarvestRain + WinterRain + FrancePop, 
              data=data)
summary(malli07)

ennusteet02 <- predict(malli07, newdata=data)
RMSE02 <- sqrt(sum((data['Price']-ennusteet02)^2)/length(ennusteet02))

#Näytetään muutama esimerkki
for(i in sample(1:length(ennusteet02),5,replace=F)) 
{
  print(paste('Todellinen:',data[i,'Price'],'Ennuste malli01:',ennusteet02[i]))
}

