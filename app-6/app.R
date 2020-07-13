library('shiny')

# Define UI ----
ui <- fluidPage(
	# 侧面控件
  sidebarPanel(
  	helpText("input sth."),
      sliderInput("range", "Range of interest",
                   min = 0, max = 100, value =c(0,100) )
  ),

    mainPanel( 
    	    h2("hist plot"),
    		plotOutput("histDt"),
    	)
)

# Define server logic ----
server <- function(input, output) {
	#reactive({})函数则自带缓存，除了第一次加载耗时外，之后都是用缓存数据(除非它依赖的input改变了)
	dataInput <- reactive({
		    # 假设获取数据很慢，需要访问网络
			Sys.sleep(3)
			x=read.table('data.txt', header=T, row.names=1)
			return(x)
		})

	output$histDt=renderPlot({
		# 假设获取数据很慢，需要访问网络
		#Sys.sleep(3)
		#x=read.table('data.txt', header=T, row.names=1) #每次用户更改页面值，都需要等待加载数据。
		x=dataInput()
		#

		arr=input$range
		len=rnorm( mean(arr) )
		#
		library(pheatmap)
		pheatmap(x, scale='row', main=length(len) )
		#hist(x, main=length(l))
    })
}

# Run the app ----
shinyApp(ui = ui, server = server)