getGO_FN=function(genes){ # input gene symbol
    # gene symbol to id
    gene.df <- bitr(genes, fromType="SYMBOL", toType=c("ENTREZID","ENSEMBL"), OrgDb="org.Hs.eg.db")

    ####
    ego <- enrichGO(
	  gene          = gene.df$ENTREZID,
	  keyType = "ENTREZID",  #'ENSEMBL'
	  OrgDb         = org.Hs.eg.db,
	  ont           = "all", #BP, CC, MF, or "ALL" for all three.
	  pvalueCutoff  = 0.01,
	  
	  # one of "holm", "hochberg", "hommel", "bonferroni", 
	  #  "BH", "BY", "fdr", "none"
	  pAdjustMethod = "BH",
	  qvalueCutoff  = 0.05, #0.2  0.05
	  
	  #universe, #背景基因。如果省略，则使用DB中TERM2GENE table表的所有基因
	  #universe      = names(geneList),
	  
	  # Only gene Set size in [minGSSize, maxGSSize] will be tested.
	  minGSSize = 10, #输出条目
	  maxGSSize = 500,
	  
	  readable      = TRUE, #whether mapping gene ID to gene Name
	  pool = FALSE  #If ont='ALL', whether pool 3 GO sub-ontologies
	)
	return(ego)
}


showDigit=function(arr){
	ifelse(arr>0.01, round(arr,3), formatC(arr, format = "E", digits = 2) )
}