SourceData <-Simple_mydata_Urge2Move

NRows = dim(SourceData)[1]
Nf = dim(SourceData)[2]
dat <- SourceData[2:N,2:Nf] #Remove 1st row, Remove 1st column (patient name)
last_Feature_Index = Nf-2
Label_index = Nf - 1

library(caret)
library(e1071)
library(rpart)


index <- 1:nrow(dat)
testindex <- sample(index, trunc(length(index)/4))
testset <- dat[testindex,]
trainset <- dat[-testindex,]


model <- svm(trainset[, 1:last_Feature_Index],trainset[, Label_index], type = "C-classification" ) 

# test with train data
pred <- predict(model, testset[, 1:last_Feature_Index])

# Check accuracy:
table(pred, testset[,Label_index])
