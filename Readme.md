---
title: "GrabCar"
output: html_document
---

This carpooling **GRABCAR** app will be useful for the public to find list of cars available for rent within their Fuel budget.


#### Dataset
Currently this app is using **mtcar** dataset of R package,but this app can be extended to any dataset as long it have Car Models with the following attributes

- mpg : Miles Per gallon
- cyl : Number of cylinders
- disp : Displacement (cu.in.)
- hp : Gross horsepower
- am : Transmission Type


#### Input
In the Left Panel, **Input the Spec of the car** you wish to rent such as Number of Cylinder, Displacement, Horse Power and Transmission type .Then you need to **Input trip detail** such as the distance of your trip(dis), the price of fuel(unitPrice) in your region and  your budget for fuel in your region currency. **Click** on **Submit** button


#### Processing
Information provided in the left panel of GUI will be used to **Estimate the Trip Total Fuel Price** (dis/mpg*unitPrice) for each car in the dataset 


#### Output
Result of the Processing will be displayed in right panel as table and charts in two seperate tabs **Table** ,**Plot** of main tabs **Analysis** .

- **Table tab** will list all the cars with the given spec and whose estimated total fuel price is less than given Budget for Fuel. 
- **Plot tab** will plot a **bar chart** for total number of car availbale for given spec with respect to number of cylinder and there is one more  **Line chart** which plot  Correlation between Important Car Attributes.These plots  will provide hint for the user to select best car with good spec  and whose estimated total fuel price is less than the specified Budget for Fuel. 


#### Notes
App **GRABCAR** is developed as part of Project work to Coursera **Developing Data Products** course.
- Source code for ui.R and server.R files are available on the [GitHub](https://github.com/NarayananAmudha/DevDataProducts).
- App is available in shinyapps.io server as [GRABCAR](https://amudhanarayanan.shinyapps.io/GrabCar).
- Pitch Presntation Slides for the App is available in [Rpubs](http://rpubs.com/NarayananAmudha/GrabCar).
- 



