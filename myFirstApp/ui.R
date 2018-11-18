library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        titlePanel("Data Science FTW!"),
        sidebarLayout(
                sidebarPanel(
                        h1("H1 text"),
                        h2("H2 text"),
                        h3("Sidebar Text"),
                        em("emphasized text")
                ),
                mainPanel(
                        h3("Main Panel Text"),
                        code("some code")
                )
        )
))
