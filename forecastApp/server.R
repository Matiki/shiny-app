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
        
        trans <- reactive({
                input$fourierslider
        })
        
        model <- reactive({
                if(input$modelinput == 'naive'){
                        fit <- training() %>% naive(h = fcperiod())
                }else if(input$modelinput == 'snaive'){
                        fit <- training() %>% snaive(h = fcperiod()) 
                }else if(input$modelinput == 'arima'){
                        fit <- training() %>% auto.arima() %>% 
                                forecast(h = fcperiod())
                }else if(input$modelinput == 'ets'){
                        fit <- training() %>% ets() %>% 
                                forecast(h = fcperiod())
                }else if(input$modelinput == 'hreg'){
                        fit <- training() %>% auto.arima(xreg = fourier(training(),
                                                                        K = trans()),
                                                         seasonal = FALSE,
                                                         lambda = 0) %>%
                                forecast(xreg = fourier(training(), 
                                                        K = trans(), 
                                                        h = fcperiod()))
                }else if(input$modelinput == 'tbats'){
                        fit <- training() %>% tbats() %>% 
                                forecast(h = fcperiod())
                }else if(input$modelinput == 'holt'){
                        fit <- training() %>% holt(h = fcperiod())
                }else if(input$modelinput == 'damp'){
                        fit <- training() %>% holt(h = fcperiod(), damped = TRUE)
                }else if(input$modelinput == 'add'){
                        fit <- training() %>% hw(h = fcperiod(), seasonal = "additive")
                }else if(input$modelinput == 'mult'){
                        fit <- training() %>% hw(h = fcperiod(), seasonal = "multiplicative")
                }
                fit
        })
        
        output$plot1 <- renderPlot({
                model() %>% autoplot() + autolayer(test())
        })
        
        output$accuracy <- renderTable({
                accuracy(model(), test())
        })
})