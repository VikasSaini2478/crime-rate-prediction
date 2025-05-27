# --- Load Required Packages ---
if (!require(caret)) install.packages("caret")
library(caret)

# --- Step 1: Clean & Prepare Data ---
# Make sure 'year' and 'population' are numeric
combined_data$year <- as.numeric(combined_data$year)
combined_data$population <- as.numeric(combined_data$population)

# --- Step 2: Define Predictors & Target ---
# Choose relevant features (customize this if needed)
# Exclude categorical or non-numeric features
predictors <- combined_data %>%
  select(year, population, total_crimes)  # Add more numeric predictors here if available

# Target variable
target <- combined_data$crime_rate

# Combine into training data
train_data <- cbind(predictors, crime_rate = target)

# --- Step 3: Fit Multiple Linear Regression Model ---
multi_model <- lm(crime_rate ~ ., data = train_data)

# --- Step 4: View Summary of Model ---
summary(multi_model)
