# Shiny05---withProgress显示进度条
# https://blog.csdn.net/wendaomudong_l2d4/article/details/78022009

## Only run examples in interactive R sessions
#if (interactive()) {

library(promises)
library(future)
#plan(multisession)

# library(ggplot2)

# 全局变量
pP=function(...){print(paste(...))}
en1=environment()


# 界面
ui <- fluidPage(
  plotOutput("plot"),
  #plotOutput("plot2")
  actionButton('submit', 'Submit')
)


#  后台
server <- function(input, output, session) {
  glob=list('isrun'=0)
  en1$glob=glob;

  #检测是否有单击事件
  getClick=eventReactive(input$submit, {
      return(TRUE);
  })

  # 这是一个不可细分的耗时任务
  # 怎么异步在前台显示一个假的进度条
  fn1=function(){
    Sys.sleep(5)
    return(mtcars)
  }

  ##############################
  # 进度条实现3:
  ##############################
  en1$glob$n=10

  #
  output$plot <- renderPlot({
    if(!getClick()){return('');}
    en1$glob$isrun=0

    #进度条，全局化
    prog <- Progress$new(session, min=1, max=en1$glob$n)
    en1$prog=prog;

    # 异步获取数据并打印出来
    future( fn1() ) %...>% (function(result){
      en1$glob$isrun <<- en1$glob$n;
      en1$prog$close();
      
      pP('>>>>>isrun: in future: ',en1$glob$isrun)
      # plot(result) #最后异步必须是输出图像
      ggplot(result, aes(disp, mpg, col=as.factor(gear) ))+
        geom_point()+theme_bw()+labs(title="mtcars")
    })
  })
  
  observeEvent( input$submit, {
  #observe({
    print('>>>>>>>>>>myFunc is called')
    prog=en1$prog;
    n=en1$glob$n;
    #on.exit(prog$close())
    prog$set(message = "Analysis in progress",
         detail = "//method3// This may take a while...", value = 0)
    for (i in 1:(n-1) ) {
      pP('>>>>>isrun:',en1$glob$isrun)
      if(en1$glob$isrun == en1$glob$n ){ #为什么这里取不到变动后的值？
        break;
      }
       #incProgress(1/n)
       Sys.sleep(0.2)
       prog$set(value=i, detail=paste('//method3// ...',i,'/',n))
     }

     prog$set(detail=paste('In XX analysis, please waite for a while...'))
  })

}


shinyApp(ui, server)