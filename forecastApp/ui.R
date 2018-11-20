library(shiny)
library(forecast)
library(dplyr)
library(ggplot2)

# Define UI for application that selects type of forecast model
shinyUI(fluidPage(
        titlePanel("Time Series Forecasting of Accidental Deaths in the US 1973-1978"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput('periodslider',
                                    "What is the forecast period? (in months)",
                                    12, 60, value = 12),
                        radioButtons(inputId = "modelinput",
                                     label = "Choose model type: ",
                                     choices = list("Naive model" = 'naive',
                                                    "Seasonal Naive" = 'snaive',
                                                    "ARIMA model" = 'arima',
                                                    "ETS model" = 'ets',
                                                    "Harmonic Regression" = 'hreg',
                                                    "TBATS Model" = 'tbats',
                                                    "Exponential Smoothing" = 'holt',
                                                    "Exp Smoothing w/Damped Trend" = 'damp',
                                                    "Exp Smoothing w/Additive Seasonality" = 'add',
                                                    "Exp Smoothing w/Multiplicative Seasonality" = 'mult'),
                                     selected = 'ets'),
                        sliderInput('fourierslider',
                                    "Number of fourier terms (for harmonic regression model):",
                                    1, 6, value = 3),
                        submitButton("Run Forecast")
                ),
                mainPanel(
                        tabsetPanel(type = "tabs",
                                    tabPanel("Forecast Plot", plotOutput("plot1")),
                                    tabPanel("Forecast Accuracy", tableOutput("accuracy")),
                                    tabPanel("Instructions", 
                                             "Select the type of forecast model on the left.",
                                             br(), 
                                             "Use the slider to change the length of the forecast period.",
                                             br(),
                                             "If using a harmonic regression model, you can select how many fourier terms to include.",
                                             br(),
                                             "Press the 'Run Forecast' button to generate a new plot.",
                                             br(),
                                             "Click the 'Accuracy' tab to check the RMSE of each model.")
                        )
                )
        )
))
