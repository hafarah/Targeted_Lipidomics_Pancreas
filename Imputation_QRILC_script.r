# Imputation QRILC - Missing Value Imputation for Lipidomics Data
setwd("C:/Users/husse/VSCode_Projects/Lipidomics/Targeted_Lipidomics")

# Install and load imputeLCMD package
if (!require("imputeLCMD", quietly = TRUE)) {
  install.packages("imputeLCMD")
}

library(imputeLCMD)

# Read the CSV file
dataframe_for_imputation <- read.csv(
  "LipidomicsDataModified80PercentRule.csv",
  row.names = NULL
)

# Store metadata columns before removing them
metadata <- dataframe_for_imputation[, c("Samples", "Group")]

# Remove non-numeric columns for imputation
numeric_data <- dataframe_for_imputation[, !(names(dataframe_for_imputation) %in% c("Samples", "Group"))]

# Convert to matrix (required by impute.QRILC)
data_matrix <- as.matrix(numeric_data)

# Perform QRILC imputation
imputed_data <- impute.QRILC(data_matrix)

# Convert imputed data back to DataFrame
lipidomicsimputeddf <- as.data.frame(imputed_data[[1]])

# Add metadata columns back
lipidomicsimputeddf <- cbind(metadata, lipidomicsimputeddf)

# Export as .csv file without adding extra row numbers
write.csv(lipidomicsimputeddf, "lipidomics_imputed_data.csv", row.names = FALSE)

print("Lipidomics imputed data exported as lipidomics_imputed_data.csv")