library(shiny)

shinyServer(function(input, output) {
        
        output$plot1 = renderPlot({
                set.seed(20181118)
                
                npoints <- input$numeric
                
                minx <- input$sliderx[1]
                maxx <- input$sliderx[2]
                miny <- input$slidery[1]
                maxy <- input$slidery[2]
                
                datax <- runif(npoints, minx, maxx)
                datay <- runif(npoints, miny, maxy)
                
                xlab <- ifelse(input$show_xlab, "X axis", "")
                ylab <- ifelse(input$show_ylab, "Y axis", "")
                main <- ifelse(input$show_title, "Title", "")
                
                plot(datax, datay, xlab = xlab, ylab = ylab, main = main,
                     xlim = c(-100, 100), ylim = c(-100, 100))
        })
})
