#!/usr/bin/env Rscript
packages <- c(
  "tidymodels", "xgboost", "rpart.plot", "vip",
  "naniar", "stringr", "lubridate", "corrplot"
)
install.packages(packages[!packages %in% installed.packages()[, "Package"]])
