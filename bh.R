Bhousing.df <- read.csv("BostonHousing.csv", header = TRUE)  # load data
str(Bhousing.df)
dim(Bhousing.df)  # find the dimension of data frame
head(Bhousing.df)  # show the first six rows
View(Bhousing.df)  # show all the data in a new tab


# Practice showing different subsets of the data
Bhousing.df[, 3]  # show the whole third column
BHousing.df[5, 1:10]  # show the fifth row of the first 10 columns
summary(Bhousing.df)  # find summary statistics for each column

# compute mean, standard dev., min, max, median, length, and missing values of AGE
mean(Bhousing.df$AGE) 
sd(Bhousing.df$AGE)
min(Bhousing.df$AGE)
max(Bhousing.df$AGE)
median(Bhousing.df$AGE) 
length(Bhousing.df$AGE) 

# Boxplot and Histogram
boxplot(Bhousing.df$MEDV, xlab="MEDV")
hist(Bhousing.df$TAX, xlab="Tax")

# use first 400 rows of data
Bhousing.df <- Bhousing.df[1:300, ]
# select variables for regression
selected.var <- c(1, 3, 4, 6, 7, 8, 10, 11, 12, 13)

# partition data
set.seed(4)  # set seed for reproducing the partition
train.index <- sample(c(1:300), 200)  
train.df <- Bhousing.df[train.index, selected.var]
valid.df <- Bhousing.df[-train.index, selected.var]

# use lm() to run a linear regression of MEDV on all the predictors in the
# training set.
bhousing.lm <- lm(MEDV ~ CRIM + RM + CHAS, data = train.df)
#  use options() to ensure numbers are not displayed in scientific notation.
options(scipen = 999)
summary(bhousing.lm) 

plot(Bhousing.df$RM, Bhousing.df$MEDV)
bhousing.lm <- lm(Bhousing.df$MEDV - Bhousing.df$RM)
bhousing.lm
abline(bhousing.lm, col="red")


