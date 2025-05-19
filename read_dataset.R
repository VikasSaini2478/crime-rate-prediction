setwd("C:\\Users\\Vikas Saini\\OneDrive\\Desktop\\project")  

#install.packages("dplyr") pakage install
library(dplyr) # Load required library

# List all CSV files in the folder
files <- list.files(pattern = "\\.csv$")

# Function to read each file and add the year from filename
read_and_tag_year <- function(file) {
  data <- read.csv(file, stringsAsFactors = FALSE)
  year <- as.integer(gsub("[^0-9]", "", file))
  data$year <- year
  return(data)
}

# Step 3: Read all files and combine them into one dataframe
combined_data <- lapply(files, read_and_tag_year) %>%
  bind_rows()

# Step 4: Preview the combined dataset
str(combined_data)
head(combined_data)
summary(combined_data)


sum(is.na(combined_data))

# Get column names
names(combined_data)

# View structure
glimpse(combined_data)

# Check for NA values column-wise
colSums(is.na(combined_data))



