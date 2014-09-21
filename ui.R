library(shiny)
library(ggplot2)

library(shinyIncubator)

# use fluid page 
shinyUI(fluidPage(
    #init progress 
    progressInit(),
    h3("Loading Data Sets with Progress Inidication"),
    # set title    
    #titlePanel("Data Set Viewer"),
    helpText("Note: this application demonstrats:"),

    helpText("* the use of progress indicator",
             "during long running tasks. When loading the 'pml' data set a progress indicator is shwon."),
    
    helpText("* how to interactevly save data sets or results."),
    
    #create site bar layout with left side panel and main panel
    sidebarLayout(
        # side bar panel 
        sidebarPanel(
            # select data set with selectInput
            selectInput("dataset", "Choose a dataset:", 
                        choices = c( "cars", "rock", "pressure", "pml")),
            #numeric input for number of rows
            numericInput("numRows", "Number of observations to view:", 10),
            #numeric input for number of columns
            numericInput("numColums", "Number of variables to view:", 7),
            
            helpText("Save the currently loaded data set to disk as csv file.",
                     "With this any data set or result can be saved interactively."),
            #save data button to trigger save operatioin
            downloadButton('saveData', 'Save data set')
            #saveDataButton('saveData', 'Save data set')
            
        ),
                
        # main panel 
        mainPanel(
            # show summary info
            h4("Summary"),
            verbatimTextOutput("summary"),
            # show first n rows
            h4("Observations"),
            tableOutput("view")
        )
    )
))
