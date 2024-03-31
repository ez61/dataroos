## Data structures in R
# Vector
# Creating a numeric vector
numeric_vector <- c(1, 2, 3, 4, 5)
print(numeric_vector)

# Creating a character vector
char_vector <- c("apple", "banana", "cherry")
print(char_vector)

# Matrix
# Creating a matrix with 3 rows and 2 columns
matrix_data <- matrix(1:6, nrow=3, ncol=2)
print(matrix_data)

# Array
# Creating an array with dimensions 3x3x2
array_data <- array(1:18, dim=c(3,3,2))
print(array_data)

# List
# Creating a list containing different data types
list_data <- list(name="John Doe", age=28, salary=3000.00)
print(list_data)

# Data frame
# Creating a data frame
df <- data.frame(
  id = 5:7,
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 32, 37)
)
print(df)

a <- 5
a + 9
a <- 10




demodata <- read.csv("workshop_data.csv", header = TRUE)
head(demodata)
str(demodata)

mean(demodata$Age, na.rm = TRUE)



library(dplyr)

demodata <- demodata |> mutate(agegroup = case_when(
  Age < 30 ~ '18-30',
  Age < 50 ~ '30-50',
  Age < 65 ~ '50-65',
  TRUE ~ 'Other'
))

head(demodata)

demodata |> filter(Age >= 50 & Gender == "Female")




demodata <-  demodata |> mutate(agegroup = case_when(
  Age < 30 ~ '18-30',
  Age < 50 ~ '30-50',
  Age < 65 ~ '50-65',
  TRUE ~ 'Other'
)) 

demodata |> group_by(agegroup) |> summarise(meansalary = mean(Income, na.rm = TRUE),
                                      numofpeople = n())



library(ggplot2)

ggplot(demodata, aes(x=Age))+
  geom_histogram(binwidth=5, fill="skyblue", color="black") +
  ggtitle("Distribution of Age") +
  xlab("Age on x-axis") +
  ylab("Count")

library(scales)
# box-plot
  
ggplot(demodata, aes(x=agegroup, y=Income)) +
  geom_boxplot(fill="lightgreen", color="black") +
  ggtitle("Income Distribution by Age Group") +
  scale_y_continuous(labels=label_comma())+
  xlab("Age Group") +
  ylab("Income")



ggplot(demodata, aes(x=Weight, y=Income, color = agegroup)) +
  geom_point(pch=17) +
  ggtitle("Weight vs. Income Colored by Age Group") +
  xlab("Weight") +
  ylab("Income")




ggplot(demodata, aes(x=Weight)) +
  geom_histogram(binwidth=2, fill="purple", color="black") +
  facet_wrap(~ agegroup) +
  ggtitle("Weight Distribution by Age Group") +
  xlab("Weight") +
  ylab("Count")
