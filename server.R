library(googleVis)
library(shiny)
shinyServer(
    function(input,output){
        output$textAvg <- renderText({compute(input$textInput,1)})
        output$textStdev <- renderText({compute(input$textInput,2)})
        
        output$myHist <- renderPlot({histo(input$textInput)})
        output$myMap <- renderGvis({map(input$textInput)})
    }
)

histo <- function(city){
    labels <- labels(eurodist)
    i <- which(city==labels)
    mat <- as.matrix(eurodist)
    boxplot(mat[i,-i],col="lightgreen",main="Boxplot")
}

map <- function(city){
    labels <- labels(eurodist)
    i <- which(city==labels)
    mat <- as.matrix(eurodist)
    col <- rep(1,length(labels))
    col[i] <- 0
    ds <- data.frame(city=labels,dist=mat[i,])
    gvisGeoChart(ds,
                 'city',
                 'dist',
                 options=list(region="150",height=600,displayMode='markers'))
}

compute <- function(city,type){
    labels <- labels(eurodist)
    i <- which(city==labels)
    mat <- as.matrix(eurodist)
    res <- 0
    
    if (type == 1){
        res <- mean(mat[i,-i])
    }else{
        res <- sd(mat[i,-i])
    }
    
    round(res,2)
}