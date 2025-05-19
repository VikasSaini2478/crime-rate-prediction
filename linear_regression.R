# Load cleaned and split data
source("split_data.R")

# --- STEP 1: Add population and crime rate ---
# (You already did this in earlier steps, so this is just to be safe)
if (!"population" %in% names(combined_data)) {
  combined_data$population <- 1000000
}
combined_data$crime_rate <- combined_data$total_crimes / combined_data$population * 100000

# --- STEP 2: Model 1 - Predict crime_rate from total_crimes ---
model1 <- lm(crime_rate ~ total_crimes, data = training_data)
cat("📈 Model 1: Predicting crime rate from total crimes\n")
print(summary(model1))

# Predict and evaluate
pred1 <- predict(model1, newdata = testing_data)
results1 <- data.frame(
  Actual = testing_data$crime_rate,
  Predicted = pred1
)
rmse1 <- sqrt(mean((results1$Actual - results1$Predicted)^2))
cat("✅ RMSE (crime_rate ~ total_crimes):", round(rmse1, 2), "\n")

# --- STEP 3: Model 2 - Predict total_crimes from year ---
model2 <- lm(total_crimes ~ year, data = training_data)
cat("\n📈 Model 2: Predicting total crimes from year\n")
print(summary(model2))

# Predict and evaluate
pred2 <- predict(model2, newdata = testing_data)
rmse2 <- sqrt(mean((testing_data$total_crimes - pred2)^2))
cat("✅ RMSE (total_crimes ~ year):", round(rmse2, 2), "\n")
