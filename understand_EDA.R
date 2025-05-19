# Load preprocessed and split data
source("split_data.R")

# Load ggplot2 (install if not already available)
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# 1. 📈 Trend of total crimes over the years (mean per year)
ggplot(combined_data, aes(x = year, y = total_crimes)) +
  stat_summary(fun = mean, geom = "line", color = "blue", size = 1.2) +
  stat_summary(fun = mean, geom = "point", color = "darkblue", size = 2) +
  labs(
    title = "📊 Trend of Average Total Crimes Over the Years",
    x = "Year",
    y = "Average Total Crimes"
  ) +
  theme_minimal()

# 2. 📊 Distribution of total crimes
ggplot(combined_data, aes(x = total_crimes)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  labs(
    title = "Histogram of Total Crimes",
    x = "Total Crimes",
    y = "Frequency"
  ) +
  theme_minimal()

