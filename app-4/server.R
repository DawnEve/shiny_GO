# server.R
library(shiny)

shinyServer(function(input, output, session) {
  cdata <- session$clientData

  #数据来源都来自于ui.R，比如obs
  output$distPlot <- renderPlot({
    dist <- rnorm( (input$obs+1)*10) #obs是从前端获取的
	
    #server处理好的图才是返回给ui.R。譬如dist
    hist(dist, n=100, freq=F, main= paste0("input: ", input$obs) )
  	m1=mean(dist)
  	s1=sd(dist)
  	abline(v=c(m1-2*s1, m1+2*s1), col='red', lty=2, lwd=2)
  	lines(density(dist), col='blue', lwd=2)
  })

  output$selected_var <- renderText({ 
    paste0("You have selected this: ", input$var1 )
  })

  output$min_max <- renderText({
    delta=input$range[2]-input$range[1];
    paste0('range: ', input$range[1],' - ', input$range[2], "; delta=", delta)
  })

  output$histDt=renderPlot({
    source('fn1.R')


    })

  # Values from cdata returned as text
  output$clientdataText <- renderText({
    cnames <- names(cdata)

    allvalues <- lapply(cnames, function(name) {
      paste(name, cdata[[name]], sep = " = ")
    })
    paste(allvalues, collapse = "\n")
  })


})

