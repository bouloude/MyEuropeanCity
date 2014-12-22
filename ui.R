library(shiny)
library(googleVis)

shinyUI(pageWithSidebar(
    headerPanel("My European City"),
    sidebarPanel(
        selectizeInput(inputId="textInput","My city is:",labels(eurodist)),
        p('Average distance to other cities (km)'),
        p(textOutput('textAvg')),
        p('Distance standard deviation (km)'),
        p(textOutput('textStdev')),
        plotOutput('myHist')
    ),
    
    mainPanel(
        
        htmlOutput('myMap')
    )
))