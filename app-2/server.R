library(shiny)
library(dplyr)
library(broom)
shinyServer(function(input, output,session) {
  #----data 1 for kmeans clust----
  set.seed(500)
  selectedData <- reactive({
      rbind(
          tibble(x = rnorm(input$n), y = rnorm(input$n)),
          tibble(r = rnorm(input$n, 5, .25), theta = runif(input$n, 0, 2 * pi),             
                           x = r * cos(theta), y = r * sin(theta)) %>%
                dplyr::select(x, y)
          )
  })

  #----data2  for hclust use----
  selectedData_clust <- reactive({
      cbind(selectedData(), hclust_assignments=selectedData() %>%
                   dist() %>% hclust(method = "single") %>%
                   cutree(2) %>% factor()%>%as.data.frame()
           )
  })

  #-----plot-----
  output$plot <- renderPlot({
    switch(input$type,
         "kmeans" =( plot(selectedData(),
                         col = kmeans(selectedData(),2)$cluster,
                         pch = 20, cex = 1)
                   ),
          
         "hclust" = (plot(selectedData_clust()[,1:2],
                          col = selectedData_clust()[,3],
                          pch = 20, cex = 1)
                    )
         )
  })
#----end---
})

# ref: https://www.cnblogs.com/litao1105/p/4525628.html
#用k-means进行聚类，常常假定数据是球状的，
#code中生成的数据集是非球状的，以便证明kmeans针对这种非球状数据集，会给出坑爹的结果。