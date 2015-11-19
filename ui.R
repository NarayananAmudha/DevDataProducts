# Developing Data Products- Course Project - GrabCar

# ui.R file for the shiny app

# This carpooling app will be useful for the public to view list of car available for carpooling within their Fuel budget, 
# using mtcars dataset, from [R] datasets

library(markdown)

shinyUI(navbarPage("GRABCAR - Grab the car of your spec that suits your trip budget for fuel",
                   tabPanel("Analysis",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(                               
                                helpText("Input the Spec of the car, you wish to rent "),
                                selectInput("am",
                                            label = "Transmission Type",
                                            choices = c( "Manual"=1,"Automatic"=0),
                                            selected = 0),
                                checkboxGroupInput('cyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),                               
                                sliderInput('hp', 'Gross horsepower Range', min=50, max=340, value=c(50,310), step=10),
                                sliderInput('disp', 'Displacement Range', min=70, max=480, value=c(100,480), step=10),
                                helpText("Input Trip Distance ,Fuel Price(as per your region) ,Budget for Fuel(in your currency)"),
                                numericInput('dis', 'Estimated Distance to Travel (in miles):', 75, min = 1, max = 1000),
                                numericInput('unitPrice', 'Fuel Price (per gallon):', 3.15,  min=1, max=1000),
                                numericInput('totalPrice', 'Budget for Fuel:', 25, min=1, max=1000),
                                submitButton('Submit')
                              ),
                              
                              
                              mainPanel(tabsetPanel(tabPanel('By Table',dataTableOutput(outputId="table")) ,
                                                             tabPanel('By Plot',htmlOutput("gvis"),htmlOutput("gvis1"))
                              #mainPanel(tabsetPanel(tabPanel('By Plot',htmlOutput("gvis")
                              )
                              
                              )
                            )
                   ),
                   tabPanel("Help",
                            mainPanel(
                              includeMarkdown("help.md")
                            )
                   )
)
)   