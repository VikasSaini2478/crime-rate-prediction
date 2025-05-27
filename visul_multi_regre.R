# --- Load Required Libraries ---
if (!require(plotly)) install.packages("plotly")
library(plotly)

# --- Refit or ensure your model exists ---
# Assuming `multi_model` was already created
# And your `train_data` includes actual `crime_rate`

# --- Step 1: Make predictions ---
train_data$predicted_crime_rate <- predict(multi_model, newdata = train_data)

# --- Step 2: Create interactive Plotly scatter plot ---
plot_ly(train_data, x = ~crime_rate, y = ~predicted_crime_rate,
        type = "scatter", mode = "markers",
        marker = list(color = 'dodgerblue', size = 6),
        name = "Predicted vs Actual") %>%
  add_trace(x = ~crime_rate, y = ~crime_rate,
            type = "scatter", mode = "lines",
            line = list(color = "red", dash = "dash"),
            name = "Perfect Fit") %>%
  layout(title = "Multiple Regression: Predicted vs Actual Crime Rate",
         xaxis = list(title = "Actual Crime Rate"),
         yaxis = list(title = "Predicted Crime Rate"),
         showlegend = TRUE)
