# server.R
library(shiny)

shinyServer(function(input, output) {
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
output$distPlot2 <- renderPlot({
    dist <- rbinom( (input$obs+1)*10, size=100, prob=0.1) #obs是从前端获取的
    par(mfrow=c(1,2))
    plot(density(dist), col='red', lty=2, main='binom(size, p)')
    hist(dist, n=20, main=input$obs)
  })
})

