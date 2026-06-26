#!/usr/bin/env Rscript
packages <- c("dplyr", "ggmap", "gmapsdistance", "leaflet", "rvest", "sqldf", "zoo")
install.packages(packages[!packages %in% installed.packages()[,"Package"]])
