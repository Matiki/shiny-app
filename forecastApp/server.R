library(shiny)
library(forecast)
library(dplyr)
library(ggplot2)

data("USAccDeaths")

# Define server logic required to forecast time series
shinyServer(function(input, output){
        fcperiod <- reactive({
                input$periodslider
        })
        training <- reactive({
                subset(USAccDeaths, 
                       end = length(USAccDeaths) - fcperiod())
        })
        test <- reactive({
                subset(USAccDeaths,
                       start = length(USAccDeaths) - fcperiod())
        })
        output$plot1 <- renderPlot({
                if(input$modelinput == 'naive'){
                        training() %>% naive(h = fcperiod()) %>%
                        autoplot() + autolayer(test())
                }else if(input$modelinput == 'snaive'){
                        training() %>% snaive(h = fcperiod()) %>%
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'arima'){
                        training() %>% auto.arima() %>% 
                                forecast(h = fcperiod()) %>% 
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'ets'){
                        training() %>% ets() %>% 
                                forecast(h = fcperiod()) %>% 
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'hreg'){
                        training() %>% auto.arima(xreg = fourier(training(), 
                                                                 K = 6),
                                                  seasonal = FALSE,
                                                  lambda = 0) %>%
                                forecast(xreg = fourier(training(), 
                                                        K = 6, 
                                                        h = fcperiod())) %>%
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'tbats'){
                        training() %>% tbats() %>% 
                                forecast(h = fcperiod()) %>% 
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'holt'){
                        training() %>% holt(h = fcperiod()) %>%
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'damp'){
                        training() %>% holt(h = fcperiod(), damped = TRUE) %>%
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'add'){
                        training() %>% hw(h = fcperiod(), seasonal = "additive") %>%
                                autoplot() + autolayer(test())
                }else if(input$modelinput == 'mult'){
                        training() %>% hw(h = fcperiod(), seasonal = "multiplicative") %>%
                                autoplot() + autolayer(test())
                }

        })
        output$slide <- renderText({
                input$periodslider
        })
})