library(shiny)
library(shinydashboard)


##shiny app
header=dashboardHeader(title = "BIGO LIVE PK Points")
body=dashboardBody(fluidRow(
  column(width = 5, box(width = NULL,
                        dateInput(inputId = "Date",label="Date",format = "yyyy-mm-dd"),
                        numericInput(inputId = "UID", label = "UID", value = 0))),
  column(width=9,box(width=NULL,solidHeader = TRUE, dataTableOutput("pk")))))



ui=dashboardPage(header,dashboardSidebar(disable = FALSE,collapsed = TRUE), body)
