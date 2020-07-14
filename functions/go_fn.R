getGO_FN=function(genes.ENTREZID){ # input gene symbol
    

    ####
    ego <- enrichGO(
	  gene          = genes.ENTREZID,
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

# for html output of GO
showDigit=function(arr){
	ifelse(arr>0.01, round(arr,3), formatC(arr, format = "E", digits = 2) )
}



#----------------------------------
# [暂时不用！]KEGG Gene Set Enrichment Analysis
# 需要输入全基因和FC
getKEGG_FN2=function(genes.ENTREZID){
	#按照输入顺序，从高到低平均分配FC
	geneList=rev( seq(-5,5, 10/length(genes.ENTREZID)) )
	names(geneList)=genes.ENTREZID
	#
	kk <- gseKEGG(geneList     = geneList,
               organism     = 'hsa',
               nPerm        = 1000,
               minGSSize    = 120,
               pvalueCutoff = 0.05,
               verbose      = FALSE)
	return(kk)
}

# KEGG over-representation test
# 输入small基因集
getKEGG_FN=function(genes.ENTREZID){
	kk <- enrichKEGG(gene         = genes.ENTREZID,
	                 organism     = 'hsa',
	                 pvalueCutoff = 0.05)
	return(kk)
}