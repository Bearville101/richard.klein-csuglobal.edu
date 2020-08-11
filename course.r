## 1. Understand Business - College Course Registration 

## 2. Understand Data - CourseTopics - contains eight attributes which are course that can be taken by students

# Load and Explore Data 
```{r}
course.df <- read.csv ("CourseTopics.csv")
course.df
```

## 3. Prepare Data for Modeling
# Install arules
```{r}
options(repos=c(CRAN="http://cran.uk.r-project.org"))
install.packages("arules")
library(arules)
```

# Convert to Matrix
```{r}
course.mat <- as.matrix(course.df)
course.mat[1:20, ]
```

# Convert to Transactions Database
```{r}
course.trans <- as(course.mat, "transactions")
inspect(course.trans)[1:20, ]
```

## 4. Build Model
# Rules
# apriori confidence level of .1 and support of .01
```{r}
rules <- apriori(course.trans, parameter = list(supp = 0.01, conf = 0.1, target = "rules"))
# inspect the first Five rules, sorted by their lift
inspect(head(sort(rules, by = "lift"), n = 5))
```

#apriori confidence level of .5 and support of .01
```{r}
rules <- apriori(course.trans, parameter = list(supp = 0.01, conf = 0.5, target = "rules"))
# inspect the first Five rules, sorted by their lift
inspect(head(sort(rules, by = "lift"), n = 5))
```
