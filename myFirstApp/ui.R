library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        titlePanel("Data Science FTW!"),
        sidebarLayout(
                sidebarPanel(
                        h3("Sidebar Text")
                ),
                mainPanel(
                        h3("Main Panel Text")
                )
        )
))
