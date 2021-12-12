# Friday Agbo 
# 03.12.2021
# This is a script for wrangling data of human development and gender inequality datasets for exercise 5
#..................................................................

# Lets read the human development data and save in hd
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
str(hd)
head(hd)
summary(hd)
dim(hd)

# here we want to read the gender inequity data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(gii)
head(gii)
summary(gii)
colnames(gii)

# Here I will want to modify the column names for the hd and gii

# changing the names of the variables in data (hd)
colnames(hd)[1] <- "HDI_rank" #human development index rank instead of HDI.Rank
colnames(hd)[2] <- "country" # Country name
colnames(hd)[3] <- "HDI" #human development index
colnames(hd)[4] <- "LEB" #life expectancy at birth
colnames(hd)[5] <- "EYE" #expected years of education
colnames(hd)[6] <- "MYE" #mean years of education
colnames(hd)[7] <- "GNI" #gross national income per capital
colnames(hd)[8] <- "GNI_HDI" # GNI per capital rank minus HDI rank


# changing the names of the variables in data (gii)

colnames(gii)[1] <- "GII_rank" #gender inequality index rank
colnames(gii)[2] <- "country" #Country name
colnames(gii)[3] <- "GII" #gender inequality index
colnames(gii)[4] <- "MMR" #maternal mortality ratio
colnames(gii)[5] <- "ABR" #adolescent birth rate
colnames(gii)[6] <- "PRP" #percent representation in Parliament
colnames(gii)[7] <- "Edu.F" #Population with secondary education, female
colnames(gii)[8] <- "Edu.M" #Population with secondary education, male
colnames(gii)[9] <- "Labo.F" #labour force participation rate, female
colnames(gii)[10] <- "Labo.M" #labour force participation rate, male

# Let's confirm the column rename in hd and gii
colnames(hd)

colnames(gii)

# We will now mutate the gii data by adding two columns "EduRatio" and "LaboRatio"
gii <- mutate(gii, EduRatio = Edu.F/Edu.M, LaboRatio = Labo.F/Labo.M)

summary(gii) # I ran this summary to confirm that the two columns were created successfully

# Now we want to join the two data hd and gii
human <- inner_join(hd,gii,by=c("country")) 
str(human) # human data contain 195 observations and 19 variables as expected

# Now we want to save the "human" data in to the local "data" folder 
write.csv(human,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\human.csv", row.names = FALSE)

##########################################################

# WEEK 5 DATA WRANGLING EXERCISES BEGINS HERE 

# Here we begin by reading the human data in order to begin the Week 5 exercise 

str(human) # Exploring the structure of the human data

dim(human) # exploring the dimensions of the human data


#From the data structure of the human data, it contain 195 observations and 19 variables. The names convention of the data is given in the list below 

#1. "HDI_rank" = human development index rank instead of HDI.Rank
#2. "CTRY" = Country name
#3. "HDI" = human development index
#4. "LEB" = life expectancy at birth
#5. "EYE" = expected years of education
#6. "MYE" = mean years of education
#7. "GNI" = gross national income per capital
#8. "GNI_HDI" = GNI per capital rank minus HDI rank
#9. "GII_rank" = gender inequality index rank
#10. "GII" = gender inequality index
#11. "MMR" = maternal mortality ratio
#12. "ABR" = adolescent birth rate
#13. "PRP" = percent representation in Parliament
#14. "Edu.F" = Population with secondary education, female
#15. "Edu.M" = Population with secondary education, male
#16. "Labo.F" = labour force participation rate, female
#17. "Labo.M" = labour force participation rate, male
#18. "EduRatio" = Ratio of Female and Male populations with secondary education in each country
#19. "LaboRatio" = Ratio of labour force participation of females and males in each country 

# *NOTE* that the "country" and "GNI" variables are of datatype "Character" strings. Other variables are numeric and integer.

# remove the commas from GNI and covert from character to numeric value using the   %>% as.numeric() 
human$GNI <- str_replace(human$GNI, pattern=",", replace ="")
human$GNI <- as.numeric(human$GNI)


# Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 

keep <- c("country", "EduRatio", "LaboRatio", "EYE", "LEB", "GNI", "MMR", "ABR", "PRP")
human <- dplyr::select(human, one_of(keep)) # Updating the data frame human
str(human) # Confirming the new human data


# As can be observed from the structure of the new Human dataframe, the GNI has been coverted to numeric data.

# We will like to remove all missing values from the data. Before we could do that, it is important to print out the logical "completeness indicator" vector to see which values are FALSE (missing).

# print out a completeness indicator of the new 'human' data
complete.cases(human)

# Now that we know some values are missing, we create a new data frame human_ by removing all the NA 

human_ <- filter(human, complete.cases(human) == TRUE) # filter out all rows with NA values

# We now want to remove observations wich relates to region instead of country in the human_$countey 


human_$country # First let us check the country column to see which data do not relate to country 

# We observe that from data [1:155], the records are valid countries. But from data [156:162] the records are related to regions or world. Therefore, these last 7 records must be removed from the country 

# choose everything until the last 7 observations

human_ <- human_[1:155, ]


#Now we shall define the row names of the data by the country names and remove the country name column from the data.

rownames(human_) <- human_$country # add countries as rownames 


# remove the Country variable from human- data
human <- dplyr::select(human_, -country)

str(human)

# The human data now have 155 observations and 8 variables as expected.

# Now we are saving the new "human" data into out local "data" directory to override the old "human" data.

write.csv(human,"C:\\Users\\fridaya\\Documents\\IODS-project\\data\\human.csv", row.names = FALSE)


