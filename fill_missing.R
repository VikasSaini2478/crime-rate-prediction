source("read_dataset.R")

# Function to get mode
get_mode <- function(x) {
  ux <- na.omit(unique(x))
  if(length(ux) == 0) return(NA)
  ux[which.max(tabulate(match(x, ux)))]
}

# Function to impute missing values
impute_missing <- function(df) {
  # Numeric columns: impute with mean
  for(col in names(df)[sapply(df, is.numeric)]) {
    if (anyNA(df[[col]])) {
      mean_val <- mean(df[[col]], na.rm = TRUE)
      df[[col]][is.na(df[[col]])] <- mean_val
      cat("✅ Imputed numeric column:", col, "with mean =", round(mean_val, 2), "\n")
    }
  }
  
  # Character columns: impute with mode
  for(col in names(df)[sapply(df, is.character)]) {
    if (anyNA(df[[col]])) {
      mode_val <- get_mode(df[[col]])
      df[[col]][is.na(df[[col]])] <- mode_val
      cat("✅ Imputed character column:", col, "with mode =", mode_val, "\n")
    }
  }
  
  # Logical columns (if any): impute with mode
  for(col in names(df)[sapply(df, is.logical)]) {
    if (anyNA(df[[col]])) {
      mode_val <- get_mode(df[[col]])
      df[[col]][is.na(df[[col]])] <- mode_val
      cat("✅ Imputed logical column:", col, "with mode =", mode_val, "\n")
    }
  }
  
  return(df)
}

# Impute missing values
combined_data <- impute_missing(combined_data)
cat("✅ All missing values filled. Remaining NA count:", sum(is.na(combined_data)), "\n")

# Final structure view
glimpse(combined_data)