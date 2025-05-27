# Load libraries
library(forecast)
library(ggplot2)
library(dplyr)

# Arrange and prepare time series
combined_data <- combined_data %>% arrange(year)
ts_data <- ts(combined_data$crime_rate, start = min(combined_data$year), frequency = 1)

# Fit ETS model and forecast 5 years
ets_model <- ets(ts_data)
ets_forecast <- forecast(ets_model, h = 5)

# Actual and forecast years
actual_years <- seq(min(combined_data$year), by = 1, length.out = length(ts_data))
forecast_years <- seq(max(actual_years) + 1, by = 1, length.out = 5)

# Combine actual + forecast into data frame
plot_df <- data.frame(
  year = c(actual_years, forecast_years),
  crime_rate = c(as.numeric(ts_data), as.numeric(ets_forecast$mean)),
  lower_95 = c(rep(NA, length(ts_data)), as.numeric(ets_forecast$lower[, 2])),
  upper_95 = c(rep(NA, length(ts_data)), as.numeric(ets_forecast$upper[, 2])),
  type = c(rep("Actual", length(ts_data)), rep("Forecast", 5))
)

# --- Plot with correct aesthetics ---
ggplot(plot_df, aes(x = year, y = crime_rate, color = type)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  geom_ribbon(
    data = filter(plot_df, type == "Forecast"),
    aes(x = year, ymin = lower_95, ymax = upper_95),
    fill = "skyblue", alpha = 0.3, inherit.aes = FALSE
  ) +
  scale_x_continuous(breaks = seq(min(plot_df$year), max(plot_df$year), 1)) +
  labs(title = "ETS Forecast of Crime Rate (2016–2029)",
       x = "Year", y = "Crime Rate") +
  theme_minimal(base_size = 14) +
  scale_color_manual(values = c("Actual" = "black", "Forecast" = "blue")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
