library(dplyr)

# Aggregate total crimes per year
yearly_crimes <- combined_data %>%
  group_by(year) %>%
  summarise(total_crimes = sum(total_crimes, na.rm = TRUE)) %>%
  arrange(year)
library(forecast)

# Convert to time series
crime_ts <- ts(yearly_crimes$total_crimes, start = min(yearly_crimes$year), frequency = 1)

# Fit ARIMA model
arima_model <- auto.arima(crime_ts)

# Forecast next 5 years
arima_forecast <- forecast(arima_model, h = 5)

# Print forecast
print(arima_forecast)
