
library(shiny)
library(ggplot2)

library(shinyIncubator)
#library(shiny)
library(datasets)

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output, session) {
    
    # Return the requested dataset
    datasetInput <- reactive({
        switch(input$dataset,
               "rock" = rock,
               "pressure" = pressure,
               "cars" = cars,
               "pml" = {
                   # download file if not on machine
                   if (!file.exists("./data/pml-training.csv")) {
                       download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", 
                                     destfile = "./data/pml-training.csv")
                   }
                   # display progress bar since loading take some time
                   # Use min/max and setProgress(value=x) for progress bar
                   withProgress(session, min = 0, max = 10, {
                        setProgress(message = "Loading data set ...")
                        for (i in 1:10) {
                            setProgress(value = i)
                            Sys.sleep(0.4)
                        }
                   })
                   
                   pml <- read.csv("./data/pml-training.csv")
                   pml
               }
        )
    })
    
    output$saveData <- downloadHandler(
        filename = function() { 
            paste(input$dataset, '.csv', sep='') 
        },
        content = function(file) {
            write.csv(datasetInput(), file)
        }
    )
    
    # Generate a summary of the dataset
    output$summary <- renderPrint({
        dataset <- datasetInput()
        summary(dataset)
    })
    
    # Show the first "n" cases (rows)
    output$view <- renderTable({
        ds = datasetInput()
        #head(datasetInput(), n = input$numRows)
        head(ds, n = input$numRows)
    })
    
})
