# ui.R
library(shiny)

shinyUI(fluidPage(

  # Application title
  headerPanel( "Hello Shiny! 001" ),
  
  
  # 侧面控件 Sidebar with a slider input for number of observations
  sidebarPanel(
    #sliderInput是一个滑动的窗口。
    sliderInput("obs", 
                "Number of observations002:", 
                min = 0, 
                max = 1000, 
                value = 800)
  ),
  
  
  
  # 右边 主控件(默认右边) Show a plot of the generated distribution
  mainPanel(
    ##########
    tags$h1( "右侧大标题",  ),
    hr(),
    tags$ol(
        tags$li("First list item"), 
        tags$li("Second list item"), 
        tags$li("Third list item")
    ),

    tags$div(
      HTML("As html: <strong>Raw HTML!</strong>")
    ),
    tags$div(
      "As string: <strong>Raw HTML!</strong>"
    ),

    ##########
    h2("代码格式"),
    em("em() creates italicized (i.e, emphasized) text."),
    br(),
    pre("怎么多行？
code displays your text similar to computer code;
for(i in 1:10){
  print(i)
  }"
      ),

    h3("如何插入图片"),
    img(src='009_pseudotime_heatmap.png' ),
    img(src='code.png' ),

     p("span does the same thing as div, but it works with",
        span("groups of words", style = "color:blue"),
        "that appear inside a paragraph."),

    ##########
    h2("First level title正态分布"),
    plotOutput("distPlot"),

    ##########
    hr(),
    h2("Second level title二项分布"),
    plotOutput("distPlot2"),
    a('find more here', href="http://baidu.com", target="_blank"),
    br(),
  )
  
))


