install.packages("tidyverse")
install.packages("ggplot2")
install.packages("janitor")
install.packages("dplyr")
install.packages("tidyr")
install.packages("lubridate")

library(tidyverse)
library(ggplot2)
library(janitor)
library(dplyr)
library(tidyr)
library(lubridate)

activity <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
calories <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/dailyCalories_merged.csv")
intensities <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/dailyIntensities_merged.csv")
steps <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/dailySteps_merged.csv")
sleepday <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
weightlog <- read_csv("~/Case Study 2/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv")

head(activity)
head(calories)
head(intensities)
head(steps)
head(sleepday)
head(weightlog)

# Here we can see that in the activity, the column with the dates is titled activity_date, so I am going to change it for consistency

activity <- clean_names(activity)
activity_clean <- activity %>%
  rename(date = activity_date)

# We also see in calories, intensities, and steps, the column with the dates is titled activity_day, so we will also change those

calories <- clean_names(calories)
calories_clean <- calories %>%
  rename(date = activity_day)

intensities <- clean_names(intensities)
intensities_clean <- intensities %>%
  rename(date = activity_day)

steps <- clean_names(steps)
steps_clean <- steps %>%
  rename(date = activity_day)

# For weightlog, we can see the date format includes the time which could cause inconsistencies, so we will change the column's formatting

weightlog_clean <- weightlog %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y"))

# For sleepday, we can see the column for the date is titled SleepDay, so we will also update that, as well as the formatting for the date

sleepday <- clean_names(sleepday)
sleepday_clean <- sleepday %>%
  rename(date = sleep_day) %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y"))

# Now we want to check for any duplicates in our data

check_duplicates <- function(data, dataset_name) {
  duplicates <- data[duplicated(data) | duplicated(data, fromLast = TRUE),]
  cat("Number of duplicates in", dataset_name, ":", nrow(duplicates), "\n")
  if (nrow(duplicates) > 0) {
    print(head(duplicates))  # Displaying the first few duplicates
  }
}

# Now applying the check_duplicates function to our datasets

check_duplicates(activity_clean, "activity_clean")
check_duplicates(calories_clean, "calories_clean")
check_duplicates(intensities_clean, "intensities_clean")
check_duplicates(sleepday_clean, "sleepday_clean")
check_duplicates(steps_clean, "steps_clean")
check_duplicates(weightlog_clean, "weightlog_clean")

# We can see that our sleepday_clean dataset contains 6 entries, so 3 of them are duplicates. We will remove the duplicates, and double check the removal was successful

sleepday_clean <- distinct(sleepday_clean)
check_duplicates(activity_clean, "activity_clean")

