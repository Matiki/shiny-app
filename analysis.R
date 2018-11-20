# Load all required packages into current R session
library(shiny)
library(xts)
library(quantmod)
library(forecast)
library(dplyr)
library(ggplot2)

sp500 <- getSymbols(Symbols = "^GSPC", src = "yahoo", auto.assign = FALSE)
sp500 <- sp500 %>% Ad() 

training <- window(sp500, end = 2017)
test <- window(sp500, start = 2017)

# Load data on accidental deaths in USA
data("USAccDeaths")

# split into training and test sets
training <- window(USAccDeaths, end = 1977)
test <- window(USAccDeaths, start = 1977)

# naive forecast
fc_naive <- naive(training, h = 24)
autoplot(fc_naive) + autolayer(test)

# seasonal naive
fc_snaive <- snaive(training, h = 24)
autoplot(fc_snaive, series = "Forecast") + autolayer(test, series = "Observed values")

# exponential smoothing with Holt method
fc_holt <- holt(training, h = 24)
autoplot(fc_holt) + autolayer(test)

# exponential smoothing with damped trend method
fc_damp <- holt(training, h = 24, damped = TRUE)
autoplot(fc_damp) + autolayer(test)

# exponential smoothing w/trend & (additive) seasonality (Holt-Winters method)
fc_exseason <- hw(training, h = 24, seasonal = "additive")
autoplot(fc_exseason) + autolayer(test)

# exponential smoothing w/trend & (multiplicative) seasonality 
fc_exseasonmult <- hw(training, h = 24, seasonal = "multiplicative")
autoplot(fc_exseasonmult) + autolayer(test)

training %>% hw(seasonal = "multiplicative") %>% autoplot() + autolayer(test)

# ETS model (error, trend, seasonal model)
training %>% ets() %>% forecast() %>% autoplot() + autolayer(test)

# ARIMA model
training %>% auto.arima() %>% forecast() %>% autoplot() + autolayer(test)

# Harmonic regression
training %>% auto.arima(xreg = fourier(training, K = 6), 
                        seasonal = FALSE, 
                        lambda = 0) %>%
        forecast(xreg = fourier(training, K = 6, h = 24)) %>%
        autoplot() + autolayer(test)

# TBATS model
training %>% tbats() %>% forecast() %>% autoplot() + autolayer(test)
