
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

app <- shinyApp(ui = ui, server = server)
runApp(app, host ="0.0.0.0", port = 80)
