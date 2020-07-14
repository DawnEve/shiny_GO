library(shiny)

shinyServer(function(input, output) {
	getGene <- eventReactive(input$submit, {
		genes=input$genes;
		genes
	})

	output$textOutput=renderText({
		getGene()
	})


})