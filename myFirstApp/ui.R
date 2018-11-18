library(shiny)

shinyUI(fluidPage(
        titlePanel("Plot Rando Numbers"),
        sidebarLayout(
                sidebarPanel(
                        numericInput("numeric", 
                                     "How many random numbers should be plotted?",
                                     value = 1000, min = 1, max = 1000, step = 1),
                        sliderInput("sliderx", "Pick min and max X values",
                                    min = -100, max = 100, value = c(-50, 50)),
                        sliderInput("slidery", "Pick min and max Y values",
                                    min = -100, max = 100, value = c(-50, 50)),
                        checkboxInput("show_xlab", "Show/hide X axis label", 
                                      value = TRUE),
                        checkboxInput("show_ylab", "Show/hide Y axis label", 
                                      value = TRUE),
                        checkboxInput("show_title", "Show/hide title")
                ),
                
                mainPanel(
                        h3("Graph of random points"),
                        plotOutput("plot1")
                )
        )
))
