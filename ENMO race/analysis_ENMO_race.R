# Loading the required packages
library(tidyverse)
library(lubridate)
library(here)

# Defining a function that will read all .csv files from the working directory
# and filter the 10-minute window for comparison
read_clean <- function(time_start, duration) {
  
  # Listing all files with the specified suffix within the working directory
  list_csv <- list.files(pattern = ".svm.csv")
  
  # Creating an empty tibble to store our data
  df_full <- tibble(time = POSIXct(),
                    ENMO_g = numeric(),
                    id = character())
  
  # Looping over all file names, reading the file, do some minor processing and filtering.
  # Only the specified time window will be kept. Finally, storing the values within our tibble.
  for (i in list_csv) {
    df_temp <- read_csv(i) %>%
      mutate(id = str_sub(i, end = -9)) %>%
      rename("time" = "Time",
             "ENMO_g" = "Mean SVM (g)") %>%
      filter(time >= as.POSIXct(time_start, tz = "UTC")) %>%
      filter(time <= as.POSIXct(time_start, tz = "UTC") + duration)
    
    df_full <- df_full %>%
      add_row(df_temp)
    
  }
  
  return(df_full)
  
}

# Running our function with the specified start time and duration and storing the data
df <- read_clean(time_start = "2023-05-09 10:21:00", duration = 600)

# Plotting the ENMO values for each participant over time
df %>%
  ggplot(aes(x = time, y = ENMO_g, color = id)) +
  geom_line(size = 1, alpha = 0.7)

# Summarizing the ENMO values by computing the sum of all 5-s intervals within the time window.
df %>%
  group_by(id) %>%
  summarize(sum_ENMO = sum(ENMO_g)) %>%
  arrange(desc(sum_ENMO))