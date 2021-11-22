# Friday Agbo 
# 22.11.2021
# This is a script is about the data wrangling exercise for the logistics regression.
# Here we try to merge two data files.

# First, I would like to read the two data 
data1 <- read.table("C:\\Users\\fridaya\\Documents\\IODS-project\\data\\student-mat.csv", sep = ";", header=TRUE)

# we explore the first data
str(data1)
head(data1)
dim(data1)
# Read the second data
data2 <- read.table("C:\\Users\\fridaya\\Documents\\IODS-project\\data\\student-por.csv", sep = ";", header=TRUE)
str(data2)
head(data2)
dim(data2)

# Here I would deifne mine own ID following the example of the script provided in the exercise
library(dplyr)
data1_id <- data1 %>% mutate(id=1000+row_number()) 
data2_id <- data2 %>% mutate(id=2000+row_number())
colnames(data1)
colnames(data2)
