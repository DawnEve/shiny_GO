# ui.R
library(shiny)

shinyUI(fluidPage(
  # Application title
  headerPanel("Hello Shiny!"),
  
  # 侧面控件 Sidebar with a slider input for number of observations
  sidebarPanel(
    #sliderInput是一个滑动的窗口。
    sliderInput("obs", 
                "Number of observations:", 
                min = 0, 
                max = 1000, 
                value = 500)
  ),
  
  # 右边 主控件(默认右边) Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
  
))


