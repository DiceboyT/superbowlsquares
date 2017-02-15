library(shiny)
library(stringr)

server <- function(input, output) {
  
  sbsq <- function(vec){
    squares_matrix <- matrix(sample(vec,100,replace=T),nrow=10,ncol=10)
    return(squares_matrix)
  }
  
  names <- eventReactive(input$go,{
    names <- stringr::str_split(input$text," ")[[1]]
  })
  
  sq <- eventReactive(input$go,{
    names <- str_split(input$text," ")[[1]]
    sq <- sbsq(names)
  })
  
  output$squares <- renderTable(rownames=T,border=T,{
    squares <- data.frame(sq())
    rownames(squares) <-  0:9
    colnames(squares) <-  0:9
    squares
  })
  
  pats <- eventReactive(input$go,{
    pats <- "Columns: New England Patriots"
  })
  
  falcons <- eventReactive(input$go,{
    falcons <- "Rows: Atlanta Falcons"
  })
  
  prob <- eventReactive(input$go,{
    falcons <- "Win Probability"
  })
  
  output$patriots <- renderText(pats())
  
  output$falcon <- renderText(falcons())
  
  output$winprob <- renderText(prob())
  
  output$df <- renderTable(border=T,{
    
    probs <- c(.19,.098,.033,.122,.15,.038,.078,.188,.06,.043)
    
    mat <- matrix(ncol=10,nrow=10)
    
    for(i in 1:10){
      for(j in 1:10){
        mat[i,j] <- probs[i]*probs[j]
      }
    }
    
    names_vector <- as.vector(sq())
    
    df <- data.frame(Name=names(),Probability=0)
    
    for(i in 1:length(names())){
      df$Probability[i] <- sum(mat[names_vector==df$Name[i]])
    }
    
    df

  })
  
}


