
cars.df <- read.csv("toyotacorolla.csv", header = TRUE)  # load data
dim(cars.df)  # find the dimension of data frame
head(cars.df)  # show the first six rows
View(cars.df)  # show all the data in a new tab

# Practice showing different subsets of the data
cars.df[, 3]  # show the whole third column
cars.df[5, 1:10]  # show the fifth row of the first 10 columns
summary(cars.df)  # find summary statistics for each column 


# use model.matrix() to convert all categorical variables in the data frame into 
# a set of dummy variables. We must then turn the resulting data matrix back into 
# a data frame for further work.
xtotal <- model.matrix(~ 0 + Fuel_Type + Color, data = cars.df)
xtotal$Fuel_Type[1:5]  # will not work because xtotal is a matrix
xtotal <- as.data.frame(xtotal)
t(t(names(xtotal)))  # check the names of the dummy variables
head(xtotal)

xtotal <- xtotal[, -3]  #  Drop -3 (Fuel-TypePetrol). 
xtotal <- xtotal[, -12] #  Drop -12 results in no dropped variable as there are 11
xtotal <- xtotal[, -11] #  Drop -11 (ColorYellow). 10 variables remaining
