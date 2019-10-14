library(shiny)
library(shinydashboard)
library(datasets)


shinyUI(
  dashboardPage(
    
    # This is header of shiny App
    dashboardHeader(title = "My Dashboard"),
    
    # This is sidebar of shiny app
    dashboardSidebar(
      sidebarMenu(
        menuItem("Filters", tabName = "filter", icon = icon("filter")),
        menuItem("About App", tabName = "about", icon = icon("clipboard"))
      )
    ),
    
    # This is body of shiny App
    dashboardBody(
             tabItems(
               # First Tab
               tabItem(tabName = "about",
                       fluidRow(
                         box("Information about the app")
                       )
               ),
               tabItem(tabName = "filter",
                       titlePanel(h4("Upload data")),
                       sidebarLayout(
                         sidebarPanel(
                           fileInput("file","Choose file", multiple = FALSE),
                           # checkboxInput(inputId = 'header', label = 'Header', value = TRUE),
                           # uiOutput("selectfile")
                           # checkboxGroupInput("columns","Select Columns",choices=NULL,inline = T)
                           selectInput('xcol', 'X Variable', ""),
                           selectInput('ycol', 'Y Variable', "", selected = "")
                         ),
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Data",tableOutput("contents")),
                             tabPanel("Plot",plotOutput("plot"))
                           ),
                           uiOutput("tb")
                         )
                       )
                       
               )
             )     
    )
  )
)
