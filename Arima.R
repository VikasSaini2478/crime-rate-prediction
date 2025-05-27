# --- Time Series Forecasting using ARIMA ---

# Install necessary packages
if (!require(forecast)) install.packages("forecast")
library(forecast)

# Aggregate total crimes by year
yearly_crimes <- combined_data %>%
  group_by(year) %>%
  summarise(total_crimes = sum(total_crimes, na.rm = TRUE)) %>%
  arrange(year)

# Create time series object
ts_crimes <- ts(yearly_crimes$total_crimes, start = min(yearly_crimes$year), frequency = 1)

# Fit ARIMA model
arima_model <- auto.arima(ts_crimes)

# Print model summary
summary(arima_model)

# Forecast next 5 years
arima_forecast <- forecast(arima_model, h = 5)

# Print forecast
print(arima_forecast)
