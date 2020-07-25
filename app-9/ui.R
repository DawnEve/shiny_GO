library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  # Application title
  headerPanel("test ggplot2"),
  
  # 侧面控件 Sidebar with a slider input for number of observations
  sidebarPanel(
    h6('Nothing to input here.'),
  ),
  
  # 右边 主控件(默认右边) Show a plot of the generated distribution
  mainPanel(
    h2('This is a bar plot'),
    plotOutput("bar0"),

    hr(),
    h2('Tab bar plot'),
    tabsetPanel(type = "tabs",
      tabPanel("testTab", plotOutput("bar1")),
      tabPanel("ggHeight", plotOutput("ggbar2", height = 800)) #指定高度
      )



  )

))