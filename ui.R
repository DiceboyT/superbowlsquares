library(shiny)
library(shinythemes)

ui <- fluidPage(theme=shinytheme("cyborg"),
  
  titlePanel("Super Bowl Squares"),
  
  sidebarLayout(
    
    sidebarPanel(

       textInput("text",
                   "Names (separated by spaces)"
                  ),
      
       actionButton("go",
                   "Create Squares"),
       
       img(src='falcons.png',height=325,width=325),
       
       img(src="patriots.png",height=200,width=350)
    ),
    

    mainPanel(
      
      h4(textOutput("patriots")),
      
      h4(textOutput("falcon")),
      
      tableOutput("squares"),
      
      h4(textOutput("winprob")),
      
      tableOutput("df")
      
    )
  )
)




