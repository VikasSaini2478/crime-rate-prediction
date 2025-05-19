# --- Load Required Packages ---
packages <- c("caTools", "randomForest", "caret", "ggplot2", "reshape2")
new_pkgs <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_pkgs)) install.packages(new_pkgs)
lapply(packages, library, character.only = TRUE)

set.seed(123)

# --- PREPARE DATA ---

# Use 'category' as the target
combined_data$category <- as.factor(combined_data$category)

# Drop unnecessary columns
drop_cols <- c("sno", "sno.1", "stateut", "stateut.1", "year", "dummy_target", "population", "crime_rate")
combined_data_clean <- combined_data[, !(names(combined_data) %in% drop_cols)]

# --- SPLIT DATA ---
split <- sample.split(combined_data_clean$category, SplitRatio = 0.7)
training_data <- subset(combined_data_clean, split == TRUE)
testing_data  <- subset(combined_data_clean, split == FALSE)

# --- TRAIN RANDOM FOREST MODEL ---
rf_model <- randomForest(category ~ ., data = training_data, ntree = 200, importance = TRUE)

# --- PREDICT ---
rf_predictions <- predict(rf_model, newdata = testing_data)

# --- CONFUSION MATRIX ---
conf_matrix <- confusionMatrix(rf_predictions, testing_data$category)
print(conf_matrix)

# --- CONFUSION MATRIX HEATMAP ---
cm <- table(Predicted = rf_predictions, Actual = testing_data$category)
cm_melt <- melt(cm)

ggplot(cm_melt, aes(x = Actual, y = Predicted, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = value), size = 4, color = "white") +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Confusion Matrix Heatmap", x = "Actual", y = "Predicted") +
  theme_minimal()
