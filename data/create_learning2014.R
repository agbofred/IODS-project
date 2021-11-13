# Friday Agbo 
# 11.11.2021
# This is a script for data wrangling exercise of the IODS course
install.packages("dplyr")
library(dplyr)
# reading the learning2014 data from link provided in the exercise
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
# The output of the code in line 6 shown on the console and Environment windows seems to show that data was successfully loaded
dim(learning2014) # the dimension output shows [1] 183 60
str(learning2014) # output os the structure code revealed that the data contain 183 objects and 60 variables

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")

surface_questions <- c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32") # combining all the questions doe surf and taking the mean values

strategic_questions <- c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28") # combining all the questions doe stra and taking the mean values

# creating the deep column and taking the mean average
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

#Creating the surf column and taking the mean average
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# creating the stra column and taking the mean average
stra_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(stra_columns)
learning2014$attitude <- learning2014$Attitude/10
learning2014$attitude

#Printing out the column name 
colnames(learning2014)

#renamning the columns "Age" and "Points" to "age" and "points", respectively 
colnames(learning2014)[57] <- "age"
colnames(learning2014)[59] <- "points"
colnames(learning2014)

# Selecting and keeping the columns
keep_column <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")
new_learning2014 <- select(learning2014, one_of(keep_column))

# excluding the point variables that are zero
learning2014 <- filter(new_learning2014, points > 0)

#Checking the structure and dimention of the new datasets
dim(learning2014)

?write.csv 
write.csv(learning2014,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\learning2014.csv", row.names = FALSE)
read.csv("C:\\Users\\fridaya\\Documents\\IODS-project\\data\\learning2014.csv")
str(learning2014)
head(learning2014)
