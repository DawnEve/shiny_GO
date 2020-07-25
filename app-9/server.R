library(shiny)
library(ggplot2)
library(dplyr)

###### 自定义函数
shinyServer(function(input, output) {
  # 
  output$bar0=renderPlot({
    ggplot(diamonds[1:100,], aes(x,y))+geom_point()
  })

  # 
  output$bar1=renderPlot({
    ggplot(diamonds[1:100,], aes(x,y))+geom_point()
  })

  # ggplot bar plot
  output$ggbar2=renderPlot({
    ego=read.table('data/ego2020.txt', row.names=1)
    #arrange(qvalue) %>%
    df=ego %>%  group_by(ONTOLOGY) %>% filter(qvalue<0.05) %>% top_n(n=5, wt=-p.adjust)
    ggplot(df, aes(x=Description, y=-log10(p.adjust), fill=ONTOLOGY) ) +
      geom_bar(stat="identity", width=0.8) + 
      coord_flip() +  #反转x和y坐标轴
      #scale_fill_manual(values = CPCOLS) + 
      theme_bw() + 
      scale_x_discrete(limits=rev(df$Description) ) + #限定x坐标的顺序
      xlab("") + ylab("-log10(adj.P.value)")+
      theme(axis.text=element_text(face = "bold", color="gray50"),
        text = element_text(size = 20) ) + # 所有字体放大
      labs(title = "Significant Enriched GO Terms")
  })

})