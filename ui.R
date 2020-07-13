library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "my.css")
  ),

  # Application title
  headerPanel("Shiny GO! v0.1"),
  
  # 侧面控件 Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("species", h3("Select species"), 
                       choices = c("human", "mouse"), selected = 1),
    textAreaInput("genes", h3("Input gene list"), 
                     placeholder  = "Input gene symboles...", value="TP53 CCNE2", rows  =10),
    #submitButton("submit", 'Submit')
    actionButton("submit", "Submit"),

    hr(),
    p('Input gene number: '),
    textOutput('geneNumber')
  ),
  
  # 右边 主控件(默认右边) Show a plot of the generated distribution
  mainPanel(
    # tableOutput("test"),
    h2('Significant GO terms: Figure'),
    plotOutput("plotGO"),

    hr(),
    h2('Significant GO terms: table'),
    tableOutput("goTable")
  )

))