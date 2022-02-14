library(caTools)
dat <- read.csv2("terveys_clean.csv")
set.seed(345)
splitti <- sample.split(dat$Ikä, SplitRatio = 0.8)
data_train <- subset(dat, splitti==TRUE)
data_test <- subset(dat, splitti==FALSE)

testinkoltraind <- median(data_train$Kolesteroli)
testinkoltraind

testikoltestd <- median(data_test$Kolesteroli)
testikoltestd