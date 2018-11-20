library(shiny)
library(forecast)
library(dplyr)
library(ggplot2)

# Define UI for application that selects type of forecast model
shinyUI(fluidPage(
        titlePanel("Title"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput('periodslider',
                                    "What is the forecast period?",
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
                        submitButton("Run Forecast")
                ),
                mainPanel(
                        tabsetPanel(type = "tabs",
                                    tabPanel("Forecast Plot", plotOutput("plot1")),
                                    tabPanel("Forecast Accuracy", textOutput("slide"))
                        )
                )
        )
))
