# Load all required packages into current R session
library(shiny)
library(xts)
library(quantmod)
library(forecast)
library(dplyr)

# Load S&P 500 data from yahoo finance
sp500 <- getSymbols(Symbols = "^GSPC", src = "yahoo", auto.assign = FALSE)

# Get the adjusted closing price
sp500 <- Ad(sp500)
