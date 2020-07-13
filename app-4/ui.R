# ui.R
library(shiny)

shinyUI( fluidPage(
  #titlePanel("Basic widgets"), hr(),
  # Application title
  headerPanel( "Census Vis. 004" ),
  
  
  # 侧面控件
  sidebarPanel(
      helpText("Create demographic maps with information from the 2010 US Census."),
      selectInput("var1", "Choose a variable to display", 
                  choices = c("Percent White" , "Percent Black",
                              "Percent Hispanic", "Percent Asian"), 
                  selected = 'Percent Black'),

      sliderInput("range", "Range of interest",
                   min = 0, max = 100, value =c(0,100) )
  ),
    
  # 右边 主控件(默认右边)
  mainPanel( 
    textOutput("selected_var"),
    textOutput("min_max"),

    h2("hist plot"),
    plotOutput("histDt"),

    hr(),
    h2('Session info'),
    #pre( textOutput('clientdataText') )
    verbatimTextOutput("clientdataText")
  )
  
))
