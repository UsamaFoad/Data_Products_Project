library(ggplot2)

shinyServer(function(input, output) {
    testone <- as.character()
    testone <-reactive({input$G_groups})

    output$odataset <- renderPrint({
        paste(input$My_dataset," = ", Gene_names$Gene[Gene_names$GeneID==input$My_dataset])})
    
    output$myplot = renderPlot({
        g1 <- read.csv(paste("inc/",testone(), ".csv",sep = ""))
         
        p <- ggplot(g1, aes(x=Gene_ID, y=log(Relative_expression_levels), 
                            fill=Resistant_or_Susceptible_strains)) + 
            geom_bar(stat="identity", position=position_dodge()) +
            geom_errorbar(aes(ymin=log(Relative_expression_levels)-(SD/10), 
                              ymax=log(Relative_expression_levels)+(SD/10)),width=.3,
                         position=position_dodge(.9))
            
            p + scale_fill_brewer(palette="Paired")+ 
            ggtitle(paste("Relative expression levels of candidate gene list","\n", 
                          "expressed as mean fold difference between pre- and",
                          "\n", "post-infection ± standard deviation (SD) ")) +
            guides(fill=guide_legend(title=NULL)) 
            
        p$theme <- theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
        p$labels$x <- "Gene ID"
        p$labels$y <- "Log (base 10) Relative Expression Levels"
        p$labels$fill <- NULL

       return(p) 
        
    })
    output$text1 <- renderUI({ 
        if(input$More_info=="Introduction"){
            
            includeHTML("inc/introduction.html")
            
        } else if(input$More_info=="Information"){

            includeHTML("inc/information.html")

        } else if(input$More_info=="Help"){

            includeHTML("inc/help.html")

        } else if(input$More_info=="References"){
            
            includeHTML("inc/references.html")
            
        }
        
    })
    
})
