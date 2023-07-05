# Assignment: Housing Exercise Wk 5
# Name: Krenke, Ryan
# Date: 2023-07-05

## 1.

setwd('C:/Users/ryanr/dsc520/completed/assignment Wk5')

housing_df <- read.csv("C:/Users/ryanr/dsc520/completed/assignment Wk5/week-6-housing.csv")

library(plyr)
library(dplyr)

housing_df %>% select(Sale.Date, addr_full, zip5)

housing_df %>% filter(year_built == '2004')

housing_df %>% mutate(PricePerFt=Sale.Price/square_feet_total_living)

housing_df %>% group_by(year_built) %>% summarize(mean(Sale.Price))

housing_df %>% arrange(bedrooms)

## 2. 

library(purrr)

head(housing_df)
pluck(housing_df, 7)
## (Does not work)
## keep_at(housing_df, function(building_grade) 'building_grade'>= 9)
## (Does not work)
## housing_df %>% keep({.$building_grade > 8}) 
housing_df %>% map_dbl(mean)
housing_df %>% map_chr(class)

## 3. Adding a new row to the df
newdata_df <- c(7/2/2023, 300000, 1, 3, 2, "R1", "1234 SW Apple ST", "98053",
                "REDMOND", "REDMOND", -123.123, 47.123, 10, 3000, 3, 1, 1, 0,
                2023, 0, "R6", 8123, "R", 2)
newhousing_df <- rbind(housing_df, newdata_df)
head(newhousing_df)

## See #4 for cbind

## 4. 

library(stringr)
addresslist <- str_split(string=housing_df$addr_full, pattern=" ") 
# Split the string data in the full address column into individual parts
addressMatrix <- data.frame(Reduce(rbind, addresslist)) 
# Add this split to a matrix
names(addressMatrix) <- c("Address 1", "Address 2", "Address 3", "Address 4") 
# Add names to the matrix
housing_df <- cbind(housing_df, addressMatrix) 
# Bind the new matrix to the original df

housing_df$addresspartial = str_c(housing_df$'Address 2'," ",
                                  housing_df$'Address 3'," ", 
                                  housing_df$'Address 4') 
# combining address 2 through 4
head(housing_df)
duplicated_columns <- duplicated(t(housing_df))  
##Removing duplicated columns made by cbind
colnames(housing_df[duplicated_columns])
head(housing_df[!duplicated_columns])


library(reshape2)  
## Made my own data file to try the melt function
golfscores_df <- read.csv("C:/Users/ryanr/dsc520/completed/assignment Wk5/avg-golf-scores.csv")
golfscores_df
meltgolf <- melt(golfscores_df, id.vars=c("course"), variable.name="Year", 
                 value.name="Avg Score")
meltgolf

