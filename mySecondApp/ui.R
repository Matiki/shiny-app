library(shiny)

shinyUI(fluidPage(
        titlePanel("Predict HP from MPG"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderMPG", "What is MPG of car?", 
                                    10, 35, value = 20),
                        checkboxInput("showmodel1", "Show/hide Model 1", 
                                      value = TRUE),
                        checkboxInput("showmodel2", "Show/hide Model 2",
                                      value = TRUE),
                        submitButton("Submit")
                ),
                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted HP from Model 1:"),
                        textOutput("pred1"),
                        h3("Predicted HP from Model 2:"),
                        textOutput('pred2')
                )
        )
))
