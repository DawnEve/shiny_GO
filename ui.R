library(shiny)


shinyUI(fluidPage(
  tags$script(src='my.js'),

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "my.css")
  ),

  # Application title
  headerPanel("Shiny GO! v1.0"),
  
  # 侧面控件 Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("species", h3("Select species(暂不支持小鼠)"), 
                       choices = c("human", "mouse"), selected = 'human'),
    textAreaInput("genes", h3("Input gene list"), 
                     placeholder  = "Please input gene symbols(at lest >5), seperated by blank, tab or one symbol per line.", 
                     rows  =10),
    actionButton("use_demo", 'Demo genes'), # 填充示例基因

    actionButton("submit", "Submit"), #提交按钮

    hr(),
    #span('Input gene number: '),
    #textOutput('geneNumber', inline=T)
    HTML("<p>Input gene number: <span id='geneNumber'></span></p>")
  ),
  
  # 右边 主控件(默认右边) Show a plot of the generated distribution
  mainPanel(
    h2('enrichKEGG'),
    tabsetPanel(type = "tabs",
      tabPanel("barplotKEGG", plotOutput("barplotKEGG")),
      tabPanel("Table(Simple)", tableOutput("KEGG_TableSimple")),
      tabPanel("Table(Detail)", tableOutput("KEGG_Table"))
    ),

    hr(),
    h2('enrichGO'),
    tabsetPanel(type = "tabs",
      tabPanel("barplotGO_top20", plotOutput("barplotGO")),
      tabPanel("dotplot_top30", plotOutput("dotplotGO")),
      tabPanel("emapplot", plotOutput("emapplotGO")),
      
      tabPanel("Table(Simple)", tableOutput("goTableSimple")),
      tabPanel("Table(Detail)", tableOutput("goTable"))
    )

  )

))