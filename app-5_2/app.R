# Shiny05---withProgress显示进度条
# https://blog.csdn.net/wendaomudong_l2d4/article/details/78022009

# 全局变量
pP=function(...){print(paste(...))}


# 界面
ui <- fluidPage(
  #plotOutput("plot1"), #实现1
  plotOutput("plot2"), #实现2
  actionButton('submit', 'Submit', style="background:#f55; font-weight:bold; color:white;")
)


#  后台
server <- function(input, output, session) {

  #检测是否有单击事件
  getClick=eventReactive(input$submit, {
      return(TRUE);
  })


  ##############################
  # 进度条实现1: 适合可以循环处理的数据
  ##############################
  output$plot1 <- renderPlot({
    if(!getClick()){return('');}
    n=nrow(cars)

    # 进度条
    progress <- Progress$new(session, min=1, max=n)
    on.exit(progress$close())
    progress$set(message = 'Calculation in progress',
                 detail = 'This may take a while...')
    #
    df=NULL
    for (i in 1:n) {
      progress$set(value = i,
        detail = paste('This may take a while...',i,'/',n) )

      #处理数据
      df=rbind(df, cars[i,]) 
      Sys.sleep(0.1)
      #如果工作很慢又无法分解怎么办？像GO分析...
      # 难道要异步吗？  http://ddrv.cn/a/334857
      # 异步使用future实现，通信通过全局的环境environment
    }

    #数据处理完了，开始画图
    plot(df)
  })


  ##############################
  # 进度条实现2: 感觉不好控制
  ##############################
  output$plot2 <- renderPlot({
    if(!getClick()){return('');}

    n=nrow(cars)
    df=NULL;
    withProgress(message = 'Calculation in progress',
                 detail = '//method2// This may take a while...', value = 0, 
                 expr = {
                   for (i in 1:n) {
                     incProgress(1/n)
                     Sys.sleep(0.05)
                     setProgress(detail=paste('//method2// This may take a while...',i,'/',n))
                     df=rbind(df, cars[i,])
                   }
                 })
    plot(df)
  })

}


shinyApp(ui, server)