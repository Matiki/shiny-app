library(shiny)

shinyUI(fluidPage(
        titlePanel("Slider App"),
        sidebarLayout(
                sidebarPanel(
                        h3("Move the slider!"),
                        sliderInput("slider1", "slide me!", 0, 100, 0)
                ),
                mainPanel(
                        h3("Slider value:"),
                        textOutput("text1")
                )
        )
))
