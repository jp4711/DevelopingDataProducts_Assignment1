library(shinyIncubator)

# use fluid page 
shinyUI(fluidPage(
    #init progress 
    progressInit(),
    h2("Loading Data Sets with Progress Inidication"),
    # set title    
    #titlePanel("Data Set Viewer"),
        
    #create site bar layout with left side panel and main panel
    sidebarLayout(
        # side bar panel 
        sidebarPanel(
            # select data set with selectInput
            selectInput("dataset", "Choose a dataset:", 
                        choices = c( "pml", "rock", "pressure", "cars")),
            #dowload button to trigger operation
            downloadButton('downloadData', 'Download'),
            #numeric input for number of rows
            numericInput("numRows", "Number of observations to view:", 10),
            #numeric input for number of columns
            numericInput("numColums", "Number of variables to view:", 7)
            
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
