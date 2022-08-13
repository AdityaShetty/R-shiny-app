#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(readxl)
library(shiny)
library(ggplot2)
library(shinyWidgets)
library(bslib)

db <- read_excel('F:/UCD/Sem3/R/Assignment 2/Maths Ed.xlsx')
db <-  data.frame(db)
db<-db[,2:13]

#Changing these NA values with median value to remove outliers
db$VLE_Use[is.na(db$VLE_Use)] <- median(db$VLE_Use, na.rm=TRUE)
db$Neuroticism[is.na(db$Neuroticism)] <- median(db$Neuroticism, na.rm=TRUE)
db$Openness[is.na(db$Openness)] <- median(db$Openness, na.rm=TRUE)
db$DeepStrategy[is.na(db$DeepStrategy)] <- median(db$DeepStrategy, na.rm=TRUE)

# Define UI for application that draws a histogram
ui <- fluidPage(
  #Changing theme
  theme = bs_theme(version = 4, bootswatch = "minty"),
  #Changing background color
  setBackgroundColor("#B1D4E0"),
  tabsetPanel(
    tabPanel("App Summary",
             verbatimTextOutput("summary"),
             imageOutput("image")
             ),

    tabPanel("Interactive App",
             # Application title
             titlePanel("Student Maths scores based on parameters"),

             # Sidebar with a slider input for number of bins
             sidebarLayout(
               sidebarPanel(

                 selectInput("x",
                             "Data:",
                             list('x' = colnames(db))
                 ),
                 selectInput("Gender",
                                "Select the Gender:",
                                list('x' = c('Male','Female','Both'))
                 ),

                 radioButtons("Type_plot", "Type of plot",
                              choices = list("hist" = 1, "Boxplot" = 2,
                                             "Plot" = 3),selected = 1),
                 selectInput("colour",
                             "Colour of Plots:",
                             list('colour' = c("#FFB4B4","#94B49F", "#6E85B7","#B2A4FF", "#F7EDDB"))
                 ),



               ),

               # Show a plot of the generated distribution
               mainPanel(
                 plotOutput("distPlot"),
                 textOutput("text")

               )
             )
    ),
    #Extra tab about student info
        tabPanel("Aboutme",
                      verbatimTextOutput("Aboutme")
        )


  )
)

