# init
# aim: a simply GO server based on clusterProfileR and shinny

###########
# v0.1 can run at local cmd:
D:\Program Files\R\R-3.6.1\bin>Rscript F:\\Temp\\shiny\\run.R
Warning message:
'shiny'R3.6.3


runApp("census-app", display.mode = "showcase") #能在前台看到R代码


发现一个别人做的 https://github.com/szenitha/Shiny-Seq/tree/master/App



#######################################
# 目录结构
#######################################
app-1/ 第一课，怎么添加html标签
	www/ 内可以放静态文件 image/js/css/text 等等。
	img(src = "my_image.png", height = 72, width = 72)

app-3/ 使用了单文件 app.R，展示可用的组件。
app-4/ 后台怎么响应前台的输入？前台显示代码 display.mode = "showcase"
app-6/ 响应式加载数据reactive({})
	输出表格
#




#######################################
# 干货
#######################################

1. 基本结构
$ cat app.R
library(shiny)
# Define UI ----
ui <- fluidPage(
	sidebarPanel(
		helpText("input sth."),
		  sliderInput("range", "Range of interest",
					   min = 0, max = 100, value =c(0,100) )
	  ),

    mainPanel( 
    	    h2("hist plot"),
    		plotOutput("histDt"),

    		hr('Table 1:  details'),
    		tableOutput('tb1')
    	)
)

# Define server logic ----
server <- function(input, output) {
	output$histDt=renderPlot({
		#plot
	})  
}

# Run the app ----
shinyApp(ui = ui, server = server)






# 2. UI 中的 *Output 函数
R对象变为ui输出的函数：
Output_function	/Creates
dataTableOutput	DataTable
htmlOutput	raw HTML
imageOutput	image
plotOutput	plot
tableOutput	table
textOutput	text
uiOutput	raw HTML
verbatimTextOutput	text

添加方式和添加html元素及组件一样，放到 sidebarPanel or mainPanel in the ui.





# 3. server中渲染函数
render function	/ creates
renderDataTable	DataTable
renderImage	images (saved as a link to a source file)
renderPlot	plots
renderPrint	any printed output
renderTable	data frame, matrix, other table like structures
renderText	character strings
renderUI	a Shiny tag object or HTML





