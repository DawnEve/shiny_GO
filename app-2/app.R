library(shiny)

# Define UI ----
ui <- fluidPage(
  titlePanel("Basic widgets"),
  
  ## 第一行
  fluidRow(
    column(3,
           h3("Buttons"),
           actionButton("action", "Action"),
           br(),
           br(), 
           submitButton("Submit")),
    
    column(3,
           h3("Single checkbox"),
           checkboxInput("checkbox", "Choice A", value = TRUE)),
    
    column(3, 
           checkboxGroupInput("checkGroup", 
                              h3("Checkbox group"), 
                              choices = list("Choice 1" = 1, 
                                             "Choice 2" = 2, 
                                             "Choice 3" = 3),
                              selected = 1)),
    
    column(3, 
           dateInput("date", 
                     h3("Date input"), 
                     value = "2020-07-11"))   
  ),
  hr(),



  # 第二行
  fluidRow(
    
    column(3,
           dateRangeInput("dates", h3("Date range"))),
    
    column(3,
           fileInput("file", h3("File input"))),
    
    column(3, 
           h3("Help text"),
           helpText("Note: help text isn't a true widget,", 
                    "but it provides an easy way to add text to",
                    "accompany other widgets.")),
    
    column(3, 
           numericInput("num", 
                        h3("Numeric input"), 
                        value = 1))   
  ),
  hr(),



  
  #第3行
  fluidRow(
    
    column(2,
           radioButtons("radio", h3("Radio buttons"),
                        choices = list("Choice 1" = 1, "Choice 2" = 2,
                                       "Choice 3" = 3),selected = 1)),
    
    column(2,
           selectInput("select", h3("Select box"), 
                       choices = list("Choice 1" = 1, "Choice 2" = 2,
                                      "Choice 3" = 3), selected = 1)),
    
    column(2, 
           sliderInput("slider1", h3("Sliders"),
                       min = 0, max = 100, value = 50),
           sliderInput("slider2", "",
                       min = 0, max = 100, value = c(25, 75))
    ),
    
    column(2, 
           textInput("text", h3("Text input"), 
                     placeholder  = "Enter text...")),
    column(3, 
           textAreaInput("text2", h3("Textarea input"), 
                     placeholder  = "Enter text...", rows  =5))    
  ),
  hr(),

  #第4行: 作业
  fluidRow(
    
    column(5,
          h3("Census Vis"),
           helpText("Create demographic maps with information from the 2010 US Census."),
      selectInput("select_2", h4("Choose a variable to display"), 
                       choices = list("Percent White" = 1, "Percent Black" = 2,
                                      "Percent Hispanic" = 3, "Percent Asian" = 4), selected = 1),

           sliderInput("slider_2", h4("Range of interest"),
                       min = 0, max = 100, value =c(0,100) ))
  )

)




# Define server logic ----
server <- function(input, output) {
  
}



# Run the app ----
shinyApp(ui = ui, server = server)