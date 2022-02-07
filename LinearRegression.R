#lineaariregressio
#datat
data <- read.csv("carprices_scaled.csv")
#opetetaan malli
malli1 <- lm(price ~ ., data=data)
malli2 <- lm(price ~ CarName + enginelocation + enginesize + stroke + horsepower, data=data)
summary(malli2)
#muuttujien korrelaatiot
korrelaatiot <- cor(data[c('CarName', 'enginelocation', 'enginesize', 'stroke', 'horsepower')])
library(corrplot)
corrplot(korrelaatiot)

#esimerkki2
data2 <- read.csv("baseball.csv")
#rakenteen tutkailua
str(data2)

dat <- subset(data2, Year < 2002)

#visu
par(mfrom=c(2,2))
hist(data2$RS, main="RS")
hist(data2$RA, main="RA")
hist(data2$OBP, main="OBP")
hist(data2$SLG, main="SLG")
par(mfrom=c(1,1))

#juoksujen lkm to playoffs
par(mfrom=c(1,1))
varit <- c("red", "blue")
pisteidemvarit <- varit[data2$Playoffs+1]
plot(x = data2$W, y=data2$RS, main="voitot vs juoksujen lkm",
     xlab="Voitot", ylab="juoksut lkm", col=pisteidemvarit)
abline(v=99, col="green")


data2$RD = data2$RS - data2$RA
plot(data2$RD, data2$W, main="juoksuero vs voitot", col="blue",
     xlab="juoksuero", ylab="voitot")

#huomataan voimakas lineaarinen suhde
#voidaan ennakoida, että RD vaikuttaa W:n ennustamiseen

#linemalli
malli <- lm(W ~ RD, data=data2)
summary(malli)

#malli: W = 80.904 + 0.104 * RD

#mitä saa juoksuero olla että voitot väh 95
#80.904 + 0.104 * RD >= 95 <=> RD >= x 


korre <- cor(data2[c('RS','OBP', 'SLG', 'BA')])
korre2 <- cor(data2[c('RA', 'OOBP', 'OSLG')], use="pairwise.complete.obs")

#lineaariregressio
malli3 <- lm(RS ~ OBP + SLG + BA, data=data2)
summary(malli3)

##################################################
malli4 <- lm(RS ~ OBP + OSLG, data=data2)
#ennuste esimerkki
oak2001 <- subset(data2, data2$Year == 2001 & data2$Team == "OAK")
predict(malli4, newdata=oak2001)

