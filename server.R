# server.R
library(shiny)

shinyServer(function(input, output) {
  #数据来源都来自于ui.R，比如obs
  output$distPlot <- renderPlot({
    dist <- rnorm(input$obs)
    #server处理好的图才是返回给ui.R。譬如dist
    hist(dist)
  })
  
})