shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data-Products Course Project"),
    HTML('<h3>UsamaFoad, June 2016</h3>'),
    
    # Sidebar with controls 
    sidebarLayout(
        sidebarPanel(
            
            selectInput("G_groups", "A- Choose Group to plot:", 
                        choices = c("1- Genes down regulated in resistant while 
                                    up regulated in susceptible " = "g1",
                                    "2- Genes down regulated in both resistant 
                                    and susceptible" = "g2",
                                    "3- Genes up regulated in both resistant and 
                                    susceptible "= "g3")),
            
            selectInput("My_dataset", "B- Choose Gene ID to show it's full name:", 
                        choices = levels(Gene_names$GeneID)),
            
            selectInput(inputId = "More_info",
                        label = "C- Documentation:",
                        choices = c('Introduction', 'Information', 'Help', 
                                    'References'),
                        selected = "Introduction")
            
        ),
        
        # Show the results
        mainPanel(
            plotOutput("myplot", width = "100%", height = "400px"),
            verbatimTextOutput("odataset"),
            uiOutput("text1") 
        )
    )
))