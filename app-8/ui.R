library(shiny)



shinyUI(fluidPage(
	headerPanel("Bug demo: when hand input, Shiny can get the value from textAreaInput; but when js set values for textAreaInput, 
		Shiny get nothing."),

  tags$script(src='my.js'),

  sidebarPanel(
    textAreaInput("genes", h3("1. Input gene list"), 
                     placeholder  = "Please input some string", 
                     value='some string',
                     rows  =10),
    actionButton("use_demo", '2. Demo genes'), # 填充示例基因

    actionButton("submit", "3. Submit") #提交按钮
   ),

  mainPanel(
  	h3('4. output'),
  	hr(),
  	textOutput('textOutput'),

	hr(),
  	h3('How to repeat this problem:'),
  	p('(1)Normal: input some string in 1, and click 3,  the string will be shown at 4;'),
  	p('(2)Problem: click 2, using js to set some string to 1, then click 3, nothing shown at 4. why?'),
    p('更新输入框数据后，需要主动触发其change事件。'),

  	hr(),
  	h3('Dir structure'),
  	pre('
  		|- ui.R
  		|- server.R
  		|- www / my.js
  		')

  )
))