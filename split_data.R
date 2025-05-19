# Load imputed dataset
source("fill_missing.R")  # Make sure this loads 'combined_data'

# Load required packages
if (!require(caTools)) install.packages("caTools")
library(caTools)

set.seed(123)  # For reproducibility

# Clean column names: remove special characters and convert spaces to underscores
names(combined_data) <- tolower(gsub("[^[:alnum:] ]", "", names(combined_data)))  # Remove bad symbols
names(combined_data) <- gsub("\\s+", "_", names(combined_data))  # Replace spaces with underscores

# Fix duplicate column names (just in case)
names(combined_data) <- make.names(names(combined_data), unique = TRUE)

# OPTIONAL: Create dummy target if not already present
if (!"dummy_target" %in% names(combined_data)) {
  combined_data$dummy_target <- sample(1:100, nrow(combined_data), replace = TRUE)
}

# Identify numeric crime-related columns (excluding 'year' and 'dummy_target')
crime_cols <- setdiff(names(combined_data)[sapply(combined_data, is.numeric)], 
                      c("year", "dummy_target", "population", "crime_rate", "total_crimes"))

# Create total_crimes column
combined_data$total_crimes <- rowSums(combined_data[, crime_cols], na.rm = TRUE)

# Add a dummy population (if not already present)
if (!"population" %in% names(combined_data)) {
  combined_data$population <- 1000000  # Replace with actual if available
}

# Calculate crime_rate (per 100,000 people)
combined_data$crime_rate <- combined_data$total_crimes / combined_data$population * 100000

# Split data into training and testing
split <- sample.split(combined_data$crime_rate, SplitRatio = 0.7)
training_data <- subset(combined_data, split == TRUE)
testing_data  <- subset(combined_data, split == FALSE)

# Summary checks
cat("📊 Summary of total_crimes:\n")
print(summary(combined_data$total_crimes))

cat("\n🔍 Column names:\n")
print(names(combined_data))

# Check for duplicate column names
dup_check <- anyDuplicated(names(combined_data))
if (dup_check > 0) {
  cat("\n⚠️ Duplicate column found at position:", dup_check, "\n")
} else {
  cat("\n✅ No duplicate column names.\n")
}
