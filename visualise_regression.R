
library(ggplot2)

# Predicted vs Actual plot for Model 1
ggplot(results1, aes(x = Actual, y = Predicted)) +
  geom_point(color = "dodgerblue", alpha = 0.7) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Model 1: Predicted vs Actual Crime Rate",
       x = "Actual Crime Rate",
       y = "Predicted Crime Rate") +
  theme_minimal()

# Add predictions to testing data for Model 2
testing_data$predicted_total_crimes <- pred2

ggplot(testing_data, aes(x = year)) +
  geom_point(aes(y = total_crimes), color = "gray40", alpha = 0.6) +
  geom_line(aes(y = predicted_total_crimes), color = "blue", size = 1) +
  labs(title = "Model 2: Total Crimes Over Time (Actual vs Predicted)",
       x = "Year",
       y = "Total Crimes") +
  theme_minimal()
