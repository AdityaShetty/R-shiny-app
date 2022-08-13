#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(readxl)
library(shiny)
library(ggplot2)
library("rstudioapi")
library(shinyWidgets)
library(bslib)
setwd(dirname(getActiveDocumentContext()$path))

db <- read_excel('Maths Ed.xlsx')
db <-  data.frame(db)



#Changing these NA values with median value to remove outliers
db$VLE_Use[is.na(db$VLE_Use)] <- median(db$VLE_Use, na.rm=TRUE)
db$Neuroticism[is.na(db$Neuroticism)] <- median(db$Neuroticism, na.rm=TRUE)
db$Openness[is.na(db$Openness)] <- median(db$Openness, na.rm=TRUE)
db$DeepStrategy[is.na(db$DeepStrategy)] <- median(db$DeepStrategy, na.rm=TRUE)


server <- function(input, output) {

  output$distPlot <- renderPlot({
    #Selecting data based on selection
    if (input$Gender == "Male"){
      db = db[db$Gender_0F_1M==0,]
    }
    if (input$Gender == "Female"){
      db = db[db$Gender_0F_1M==1,]
    }

    db<-db[,2:13]

    parameter_selected    <- as.numeric(unlist(db[input$x]))


    #Histogram plot
    if(input$Type_plot == 1) {
      hist(parameter_selected, probability = TRUE, bins=50,
           col = input$colour, border = 'black', main="Histogtam",
           xlab="Parameter score",
           ylab="Frequency")
    }
    #Boxplot plot
    if(input$Type_plot == 2) {
      boxplot(parameter_selected,
              col = input$colour, border = 'black', main="Boxplot",
              xlab="Parameter score")
    }
    #Scatter plot
    if(input$Type_plot == 3) {
      plot(parameter_selected,
           col = input$colour, border = 'black', main="Scatter Plot",
           xlab="Indexes",
           ylab="Parameter score")
    }

  })




  output$summary<- renderText({paste("This app is interactive report on Maths data scores based on",
                                     " parameters of a class given.",
                                     "In this app we can plot different types of plot for numeric",
                                     " parameters based on Gender and specific values. The theme ",
                                     "of the app is changed including different types of outputs.",
                                     "Below is an image example of the created app. Please click on",
                                     " tab above to use the actual app "
                                     ,sep="\n")})


  output$image <- renderImage({
    list(src = 'Img.jpg', width = "60%", height = "100%")})

  output$Aboutme <- renderText({paste("Name: Aditya Shetty",
                                      "Msc. Data & Computational Sciene-UCD", sep="\n")})





}

