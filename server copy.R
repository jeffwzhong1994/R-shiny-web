options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/cloud-platform")
library(googleComputeEngineR)
library(jsonlite)

account_key <- "/Users/jeffwzhong/Desktop/Work/Projects/R/pkbackend.json"
project  <- "pk-backend"
zone  <- "us-west2-a"
fromJSON(account_key)
googleAuthR::gar_auth_service("/Users/jeffwzhong/Desktop/Work/Projects/R/pkbackend.json")
Sys.setenv(GCE_AUTH_FILE = account_key,
           GCE_DEFAULT_PROJECT_ID = project,
           GCE_DEFAULT_ZONE = zone)

#set our default global project
gce_global_project(project)
gce_global_zone(zone)

default_project = gce_get_project("pk-backend")
default_project$name

vm <- gce_vm(template = "rstudio", predefined_type = "f1-micro", name = "rstudio-server", username = "mark", password = "mark1234")
the_list <- gce_list_instances()
the_list

server=function(input,output){
  output$pk=renderDataTable({
    library(dplyr)
    library(lubridate)
    data=read.csv("pk records.csv")
    data$a.rtime=ymd_hms(data$a.rtime)-hours(16)
    data$year = paste(year(data$a.rtime),"-",month(data$a.rtime))
    data$year 
    data$a.rtime= as.Date(data$a.rtime)
    data$a.rtime
    summary(data)
    data%>%
      filter(a.uid == input$UID)%>%
      filter(a.rtime==input$Date)%>%
      mutate(PK_points=a.recvbeans*10)%>%
      mutate(Opponent_PK_points=a.peerrecvbeans*10)%>%
      select( time = a.rtime, uid=a.uid, PK_points, OpponentUID=a.peeruid, Opponent_PK_points)
    
  })
}

shinyApp(ui=ui,server = server)

