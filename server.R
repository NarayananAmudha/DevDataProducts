# Developing Data Products- Course Project - GrabCar

# server.R file for the shiny app

# This carpooling app will be useful for the public to find list of car available for carpooling within their Fuel budget, 
# using mtcars dataset, from [R] datasets

library(shiny)
library(datasets)
library(plyr)
library(dplyr)
library(googleVis)

suppressPackageStartupMessages(library(googleVis))

shinyServer(function(input, output) {
  
  # Show the cars that correspond to the filters
  output$table <- renderDataTable({
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    data <- transmute(mtcars, CarModel = rownames(mtcars), MilesPerGallon = mpg, 
                      EstimatedFuelPrice = input$dis/mpg*input$unitPrice,Transmission = am,
                      Cylinders = cyl,Horsepower = hp, Displacement = disp 
                      )
    data <- filter(data, EstimatedFuelPrice <= input$totalPrice, Cylinders %in% input$cyl, 
                   Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, EstimatedFuelPrice)
    data
  }, options = list(lengthMenu = c(5, 15, 30), pageLength = 15))
  
  
  output$gvis <- renderGvis({
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    data <- transmute(mtcars, CarModel = rownames(mtcars), MilesPerGallon = mpg, 
                      EstimatedFuelPrice = input$dis/mpg*input$unitPrice,
                      Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                      Transmission = am)
    data <- filter(data, EstimatedFuelPrice <= input$totalPrice, Cylinders %in% input$cyl, 
                   Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, EstimatedFuelPrice)
    subdata <- ddply(data, c("Cylinders"), summarise,
                   Count   = length(Transmission))
    #subdata <- subset(data, select= c("EstimatedFuelPrice","MilesPerGallon"))
    titletxt = ifelse(input$am==0, "For Transmission type: Automatic \n Total Cars Available to Grab VS Number of Cylinders ",
                      "For Transmission type: Manual \n Total Cars Available to Grab VS Number of Cylinders ")
    gvisColumnChart(subdata, options=list(width=900, height=550,vAxis="{title: 'Total Car Available',titleTextStyle:{color:'red'}}",
                hAxis="{title: 'Number of Cylinders',titleTextStyle:{color:'red'}}",
                    title = titletxt,  titleTextStyle="{color:'blue', fontName:'Courier', fontSize:16}"))
  })
  
  output$gvis1 <- renderGvis({
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    data <- transmute(mtcars, CarModel = rownames(mtcars), MilesPerGallon = mpg, 
                      EstimatedFuelPrice = input$dis/mpg*input$unitPrice,
                      Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                      Transmission = am)
    data <- filter(data, EstimatedFuelPrice <= input$totalPrice, Cylinders %in% input$cyl, 
                   Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, EstimatedFuelPrice)
    subdata <- subset(data, select= c("EstimatedFuelPrice","MilesPerGallon","Horsepower","Displacement" ))
    #subdata <- subset(data, select= c("EstimatedFuelPrice","MilesPerGallon"))
    titletxt = "Correlation between Important Car Attributes \n shows hint to select car with good spec for given Budget"
    gvisLineChart(subdata, options=list(width=900, height=550,vAxis="{title: 'Attributes Value',titleTextStyle:{color:'red'}}",
                                        hAxis="{title: 'Estimated total Fuel Price for Trip',titleTextStyle:{color:'red'}}",
                                          title = titletxt,  titleTextStyle="{color:'blue', fontName:'Courier', fontSize:16}"))
  })
  
})
