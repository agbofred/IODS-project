# Friday Agbo 
# 03.12.2021
# This is a script for wrangling the two data sets data sets, BPRS and RATS for exercise 6
#..................................................................

# READING DATA AND CHECKING THE SUMMARIES
BPRS  <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=TRUE)
RATS  <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header=TRUE)

# Let us check the BPRS and RATS data names, structures, and summary 

names(BPRS)
str(BPRS)
summary(BPRS)
BPRS

# The BPRS data contain 40 observations and  11 variables

##############
names(RATS)
str(RATS)
summary(RATS)

# The RATS data 16 observations and  13 variables

# CONVERTING THE CATEGORICAL VARIABLES OF BOTH DATA SETS TO FACTOR 

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# The categorical variables of BPRS are "treatment" and "subject"
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)

# The categorical variables of RATS are "ID" and "Group"
# Factor ID & Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group )
str(RATS)

# CONVERTING BOTH DATA SETS TO LONG FORM AND ADDING "week" VARIABLE TO BPRS AND A "Time" VARIABLE TO RATS

# Convert to long form
BPRSLONG <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSLONG <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)

# Extract the week number from BPRSLONG data and assign it to new variable "week"
BPRSLONG <-  BPRSLONG %>% mutate(week = as.integer(substr(weeks,5,5)))
# Let us Glimpse (BPRSLONG)
glimpse(BPRSLONG)
BPRSLONG$week

# Extract the WD number from RATS data and assign it to new variable "Time"
RATSLONG <-  RATSLONG %>% mutate(Time = as.integer(substr(WD,3,4)))
# Let us Glimpse (RATSLONG)
glimpse(RATSLONG)
RATSLONG$Time

# Let us take a closer look at the BPRS (Wide Form) and BPRSLONG (Long Form)
names(BPRS) # This gives 11 variables 
names(BPRSLONG) # This gives 5 variables 
str(BPRSLONG)

# Let us also take a closer look at the RATS (Wide Form) and RATSLONG (Long Form)
names(RATS) # This gives 13 variables 
names(RATSLONG) # This gives 5 variables 
str(RATSLONG)


# Here I will like to save the BPRS, BPRSLONG, RATS, and RATSLONG datasets in my "data" folder in case I will need them for the data analysis in R Markdown 

write.csv(BPRS,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\BPRS.csv", row.names = FALSE)
write.csv(BPRSLONG,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\BPRSLONG.csv", row.names = FALSE)
write.csv(RATS,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\RATS.csv", row.names = FALSE)
write.csv(RATSLONG,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\RATSLONG.csv", row.names = FALSE)
