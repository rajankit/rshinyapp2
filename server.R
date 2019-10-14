library(shiny)
library(datasets)
library(plotly)
library(dplyr)
library(shinydashboard)

shinyServer(function(session,input,output) {
  data_set <- reactive({
    if(is.null(input$file)) return(NULL)
    infile <- input$file;
    df <- read.csv(infile$datapath,header = TRUE, sep = ',',
                   quote ="'")
    for(i in seq_along(df)){
      df[,i] <- as.factor(df[,i])
      
    }
    df[df=="NA"] <- NA
    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                      choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                      choices = names(df), selected = names(df)[2])
    return (df)
  })
  # output$selectfile <- renderUI({
  #   if(is.null(input$file)) {return()}
  #   list(hr(), 
  #        helpText("Select the files for which you need to see data and summary stats"),
  #        selectInput("Select", "Select", choices=names(data_set()),multiple = T)
  #   )
  # })
  # observe({
  #   # get all character or factor columns
  #   updateCheckboxGroupInput(session, "Select Columns",
  #                choices = vchoices, # update choices
  #                selected = NULL) # remove selection
  # })
  
  # output$columns <- renderUI({
  #   vchoices <- 1:ncol(data_set())
  #   names(vchoices) = names(data_set())
  #   print(vchoices)
  #   updatecheckboxGroupInput("columns","Select Columns",choices=vchioces,inline = T)
  # })
  output$contents<-renderTable({
    if(is.null(data_set())) return(NULL)
    data_set()
  })
  output$plot <- renderPlotly({
    
  })
})