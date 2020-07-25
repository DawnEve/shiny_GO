myArgs<-commandArgs(TRUE)
mode=myArgs[1]
if(!(mode %in% c('demo', 'win', 'linux') )){
	stop("mode must in c('demo', 'win', 'linux')")
}
print(paste('>>> Shiny APP Runnig Mode: ', mode))


########################
# init
########################
library(shiny)

if(mode=='demo'){
	# 学习 shiny用
	runApp("F:\\Temp\\shiny\\app-9", host="0.0.0.0", port=8888, display.mode = "showcase")
}else if(mode=='win'){
	# GO on win, for develop
	runApp("F:\\Temp\\shiny", host="0.0.0.0", port=8888)
}else{
	# GO on linux, for production
	runApp("/home/wangjl/test/shiny_GO/", host="0.0.0.0", port=9993)
}
