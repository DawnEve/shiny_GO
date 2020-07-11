# server.R
library(shiny)

shinyServer(function(input, output) {
  #数据来源都来自于ui.R，比如obs
  output$distPlot <- renderPlot({
    dist <- rnorm( (input$obs+1)*10) #obs是从前端获取的
	
    #server处理好的图才是返回给ui.R。譬如dist
    hist(dist, n=100, freq=F)
	m1=mean(dist)
	s1=sd(dist)
	abline(v=c(m1-2*s1, m1+2*s1), col='red', lty=2, lwd=2)
	lines(density(dist), col='blue', lwd=2)
  })
  
})