# Load new dataset
new_data <- read.csv("crime_dataset_india.csv", stringsAsFactors = FALSE)

# Merge with combined_data by common columns like 'stateut' and 'year'
combined_data <- bind_rows(first_data, new_data)

# Optional: Remove duplicates if needed
combined_data <- combined_data %>% distinct()

# Preview final merged data
glimpse(combined_data)
