library(shiny)
library(ggplot2)
library('dplyr')

library('clusterProfiler')
library('org.Hs.eg.db')

###### 自定义函数
source('functions/go_fn.R')

shinyServer(function(input, output) {
	getGene <- eventReactive(input$submit, {
		#'''
		#	input gene symbols,
		#	return gene id;
		#'''
		pP=function(...){ print( paste(...)) }
		print('=============01 get gene list (reactive)====================')
		genes=input$genes;

		pP('Raw input: ', genes)
    pP('>>>>>>Time: ', Sys.time())
		genes=strsplit(genes, '[^0-9a-zA-Z\\-\\.]+')[[1]]
		#length(genes) #RP11-489E7.4, MT-ND5

		# gene symbol to id
		print('=============01_2 convert symbol to gene id (reactive)====================')
    	gene.df <- bitr(genes, fromType="SYMBOL", toType=c("ENTREZID","ENSEMBL"), OrgDb="org.Hs.eg.db")
    	#  SYMBOL ENTREZID         ENSEMBL
		#1   TP53     7157 ENSG00000141510
		#2  CD274    29126 ENSG00000120217
		genes=unique( gene.df$ENTREZID )
		print(length(genes))
		return( genes )
	})

	getGO=eventReactive(input$submit, {
		print('=============02 getGO, Run time consuming steps: at most once====================')
		genes=getGene()
		if(length(genes)<5){ return(''); }
		return(getGO_FN(genes))
	})
	# output$geneNumber=renderText({
	# 	length( getGene() )
	# })

	#----------------KEGG 富集
	getKEGG=eventReactive(input$submit, {
		print('=============03 getKEGG, Run time consuming steps: at most once====================')
		genes=getGene()
		if(length(genes)<5){ return(''); }
		#print(paste('>>>>>>>>>>>', length(genes)  ) )
		#print(head(genes, n=100))

		return( getKEGG_FN(genes) )
	})


	#----------------KEGG 富集 
   # 条状图
  output$barplotKEGG=renderPlot({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	kk=getKEGG()
  	barplot(kk, showCategory=20)
  })

   # 点图
  output$dotplotKEGG=renderPlot({
    genes=getGene()
    if(length(genes)<5){ return(''); }
    #
    kk=getKEGG()
    dotplot(kk, showCategory=30)
  })

  # 表格 simple
  output$KEGG_TableSimple=renderTable({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	kk=getKEGG()
  	df=as.data.frame(kk)
  	df$pvalue = showDigit(df$pvalue)
	df$p.adjust = showDigit(df$p.adjust)
	df$qvalue = showDigit(df$qvalue)
	df[, which( !(colnames(df) %in% c('geneID') ) ) ]
  })
  # 表格 all
  output$KEGG_Table=renderTable({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	kk=getKEGG()
  	df=as.data.frame(kk)
  	df$pvalue = showDigit(df$pvalue)
	df$p.adjust = showDigit(df$p.adjust)
	df$qvalue = showDigit(df$qvalue)
	df
  })



	#----------------GO 富集 
  # ggplot bar plot
  output$barplotGO_0=renderPlot({
    genes=getGene()
    if(length(genes)<5){ return(''); }
    #
    ego=getGO()
    df=as.data.frame(ego) %>%  group_by(ONTOLOGY) %>% filter(p.adjust<0.05) %>% top_n(n=5, wt=-p.adjust)
    ggplot(df, aes(x=Description, y=-log10(p.adjust), fill=ONTOLOGY) ) +
      geom_bar(stat="identity", width=0.8) + 
      coord_flip() +  #反转x和y坐标轴
      theme_bw() + 
      scale_x_discrete(limits=rev(df$Description) ) + #限定x坐标的顺序
      xlab("") + ylab("-log10(adj.P.value)")+
      theme(axis.text=element_text(face = "bold", color="gray50")) +
      labs(title = "Significant Enriched GO Terms")
  })

   # 条状图
  output$barplotGO=renderPlot({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	ego=getGO()
    write.table(ego, 'D://ego2020.txt')
  	barplot(ego, showCategory=20)
  })

   # 点图
  output$dotplotGO=renderPlot({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	ego=getGO()
  	dotplot(ego, showCategory=30)
  })
  #网状图
  output$emapplotGO=renderPlot({
  	genes=getGene()
  	if(length(genes)<5){ return(''); }
  	#
  	ego=getGO()
  	emapplot(ego)
  })



  # 表格 simple
  output$goTableSimple <- renderTable({
  	genes=getGene()
    if(length(genes)<5){ return( genes ); }
    #
    ego=getGO()
	df=as.data.frame(ego)
	df$pvalue = showDigit(df$pvalue)
	df$p.adjust = showDigit(df$p.adjust)
	df$qvalue = showDigit(df$qvalue)
	df[, which( !(colnames(df) %in% c('geneID')) ) ]
  })

  # 表格 完整版
  output$goTable <- renderTable({
  	genes=getGene()
    if(length(genes)<5){ return( genes ); }
    #
    ego=getGO()
	df=as.data.frame(ego)
	df$pvalue = showDigit(df$pvalue)
	df$p.adjust = showDigit(df$p.adjust)
	df$qvalue = showDigit(df$qvalue)
	df
  })

})