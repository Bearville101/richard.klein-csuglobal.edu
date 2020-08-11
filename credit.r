## 1. Understand business
#GermanCredit collects information used to determine the credit worthiness of credit applicants.
#The information collected was possibly provided by multiple sources including the credit applicants themselves.


## 2. Understand Data
# the dataset includes 30 variables and 1000 records.

#Import data and create dataframe. View without column #1.
```{r}
credit.df <- read.csv("GermanCredit.csv")
credit.df[, -1]
```


#Data Exploration. The funtions chosen include the viewing of structure, head (first 6 lines),
# summary statistics, and a table, boxplot, and histogram of variable AGE.
```{r}
str (credit.df)
head (credit.df)
summary (credit.df)
table(credit.df$AGE)
boxplot(credit.df$AGE, xlab="AGE")
hist(credit.df$AGE, xlab="AGE")
```
#Also included statistics on variable AMOUNT.
```{r}
# compute mean, standard dev., min, max, median, and length values of AMOUNT
mean(credit.df$AMOUNT) 
sd(credit.df$AMOUNT)
min(credit.df$AMOUNT)
max(credit.df$AMOUNT)
median(credit.df$AMOUNT) 
length(credit.df$AMOUNT)
```

## 3a. Prep Data for Modeling.
```{r}
# create training and validation sets
set.seed(2)  # set seed for reproducing the partition
selected.var <- c(2, 5, 9, 10, 11, 12, 13, 14, 18, 19, 21, 26, 27, 28, 32)
train.index <- sample(c(1:dim(credit.df)[1]), dim(credit.df)[1]*0.6)  
train.df <- credit.df[train.index, selected.var]
valid.df <- credit.df[-train.index, selected.var]
```

## 4a. Build First Model - Logistic Regression

```{r}
#run Logistic Regression
logit.reg <-glm(RESPONSE ~., data = train.df, family = "binomial")
options(scipen=999)
summary(logit.reg)
```
```{r}
#Logistic Fitting Function
Logit(RESPONSE = 1 (good credit) ) =
  - 0.59250288  
- CHK_ACCT * 0.59274472  
+ NEW_CAR * -0.65809898  
+ EDUCATION * -0.81393232  
+ RETRAINING * -0.62355443
+ AMOUNT * -0.00014002 
- SAV_ACCT * 0.23168728  
- EMPLOYMENT * 0.26497302 
+ INSTALL_RATE * -0.32370933  
+ CO.APPLICANT * -0.00734996  
- GUARANTOR * 1.56369195 
- REAL_ESTATE * 0.50120591 
- OWN_RES * 0.36287918  
+ NUM_CREDITS * -0.00561465 
+ JOB * -0.06006284 
```

## 5a. Evaluate Model
#Lift Chart
```{r}
#install.packages("gains")
library(gains)
pred <- predict(logit.reg, valid.df)
gain <- gains(valid.df$RESPONSE, pred, groups=20)
logit.reg.pred <- predict(logit.reg, valid.df, type = "response")
data.frame(actual = valid.df$RESPONSE[1:20], predicted = logit.reg.pred[1:20]) 

plot(c(0,gain$cume.pct.of.total*sum(valid.df$RESPONSE))~
       c(0,gain$cume.obs), 
     xlab="# cases", ylab="Cumulative", main="", type="l")
lines(c(0,sum(valid.df$RESPONSE))~c(0, dim(valid.df)[1]), lty=2)
```

#Confusion Matrix
```{r}
#install.packages ("caret")
library(caret)
#install.packages("e1071")
library(e1071)
#run confusion matrix
confusionMatrix(as.factor(ifelse(pred > 0.5, 1, 0)), as.factor(valid.df$RESPONSE)) 
```

## 3b. Prep Data for Modeling -  Classification Tree
```{r}
#install.packages("rpart")
#install.packages("rpart.plot")
library(rpart)
library(rpart.plot)
```
```{r}
# create training and validation sets & partition
set.seed(1)  
selected.var2 <- c(2, 4, 11, 12, 13, 18, 19, 21, 26, 27, 28, 32)
names (credit.df[selected.var2])
train.index <- sample(c(1:dim(credit.df)[1]), dim(credit.df)[1]*0.6)  
train.df <- credit.df[train.index, selected.var2]
valid.df <- credit.df[-train.index, selected.var2]
```
## 4b. Build Model - Classification Tree
```{r}
# classification tree
default.ct <- rpart(RESPONSE ~ ., data = train.df, method = "class")
```
## 5b. Evaluate Model
```{r}
# plot tree
prp(default.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10) 
```
#Confusion Matrix
```{r}
#install.packages ("caret")
library(caret)
#install.packages("e1071")
library(e1071)
#run confusion matrix
confusionMatrix(as.factor(ifelse(pred > 0.5, 1, 0)), as.factor(valid.df$RESPONSE)) 
```
