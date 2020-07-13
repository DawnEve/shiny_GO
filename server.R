library(shiny)
library(ggplot2)

library('clusterProfiler')
library('org.Hs.eg.db')

###### 自定义函数
source('functions/go_fn.R')

shinyServer(function(input, output) {
	getGene <- eventReactive(input$submit, {
		print('=============01 get gene list (reactive)====================')
		genes=input$genes;
		genes=strsplit(genes, '[^0-9a-zA-Z\\-]+')[[1]]
		length(genes)
		genes
	})

	getGO=eventReactive(input$submit, {
		print('=============02 Run time consuming steps: at most once====================')
		genes=getGene()
		if(length(genes)<5){ return(''); }
		return(getGO_FN(genes))
	})

	output$geneNumber=renderText({
		length( getGene() )
	})


   # 点图
  output$plotGO=renderPlot({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	ego=getGO()
  	dotplot(ego, showCategory=30)
  })

  # 表格
  output$goTable <- renderTable({
  	genes=getGene()
    if(length(genes)<5){ return( genes ); }
    #
    ego=getGO()
	df=as.data.frame(ego)
	print(dim(df))
	df$pvalue = showDigit(df$pvalue)
	df$p.adjust = showDigit(df$p.adjust)
	df$qvalue = showDigit(df$qvalue)
	print(dim(df))
	df
  })

  # 表格 test
  output$test=renderTable({
  	arr=c(6.496822e-22, 8.094667e-21, 8.581570e-20, 1.670604e-19, 1.670604e-19, 7.252100e-1)
  	#names(arr)=paste0('gene',1:length(arr))
  	df=data.frame(
  		gene=paste0('gene',1:length(arr) ),
  		value=ifelse(arr>0.01, round(arr,3), formatC(arr, format = "E", digits = 2) )
  	)
  	#df$value=as.character(df$value)
  	df

  })

  	
})