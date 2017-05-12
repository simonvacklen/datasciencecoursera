## Course project - Machine Learning, Coursera
# Simon Vacklen

```
Firstly we need to load the proper packages, and then import the textfiles.
```

```{r}
library(caret)
library(rpart)

pml_train <- read.csv("c:/temp/pml-training.csv", na.strings = c("NA", "#DIV/0!", ""))
pml_test <- read.csv("c:/temp/pml-testing.csv", na.strings = c("#DIV/0!", "NA"))
```


```
Then we need to deal with missing values, the program below creates a table called "nulltab", which is table
counting the missing values for each variable.
From this table the vector "covarlist" is created, which is a list of all variables with less than 50% missing values,
which is then applied as a filter to the training and testing data.

```
```{r}
nulltab <-data.frame()
for (i in 1:ncol(pml_train))
{
varnum <- i
nullcount <- sum(is.na(pml_train[, i]))[1]
row <- cbind(varnum , nullcount)
nulltab <- rbind(nulltab, row)
}

nulltab[, 3] <- nulltab$nullcount/nrow(pml_train)
names(nulltab)[3] <- c("null_rate")

## Choosing variables with more than 50% non-missing
covarlist <- (subset(nulltab, null_rate==0)[7:nrow(nulltab), 1])
covarlist <- covarlist[!is.na(covarlist)] 

pml_train <- pml_train[,covarlist]
pml_test <- pml_test[,covarlist]
```

```
In order to perform basic cross validation, the training data is split into training and validation,
 the prediction error on the validation set will be used to estimate
```

```{r}
split <- createDataPartition(pml_train$classe, p=0.5)[[1]]
training <- pml_train [split, ]
validation <- pml_train [-split, ]
```

```
Now to the actual models, we will attempt to predict with two different methods, a basic decision tree
and secondly using the boosting algorithm. They will evaluated using the accuracy measure take from 
a confusion matrix.

First the decision tree model:
```

```{r}
treemodel <- train(classe ~ ., data=training, method="rpart")
prediction <- predict(treemodel$finalModel, validation, type="class")
cm_val <- confusionMatrix(validation$classe, predict(treemodel$finalModel, validation, type="class"))
cm_val$overall['Accuracy']
```

```
So an accuracy of almost 50% is what we will attempt to beat with the second algorithm,  the boosting model.
We use the same type fo evaulation, looking at the accuracy through the confusion matrix.
```

```{r}
boostmodel <- train(classe ~ ., data=training, method = "gbm", verbose=FALSE)
prediction_boost <- predict(boostmodel, validation, type="raw")
cm_val <- confusionMatrix(validation$classe, prediction_boost)
cm_val$overall['Accuracy'] 
```

```
So the  accuracy of the boosting model is much higher, and this is the one that will be used.
Finally, we apply the model to the test data for output to thequiz.
```

```{r}
prediction_boost_test <- predict(boostmodel, pml_test, type="raw")
prediction_boost_test
```


