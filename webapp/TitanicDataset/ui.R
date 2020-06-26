library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Titanic Survival Prediction"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("sex",
                         "Sex of the passenger:",
                         choices=c("Female", "Male")
                        ),
            selectInput("class",
                        "Ticket class:",
                        choices=c(1,2,3)
                       ),
            sliderInput("age",
                        "Age of the passenger:",
                        min = 1,
                        max = 75,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Plot",
                         h1("Survival Probability on the Titanic"),
                         plotOutput("prob")
                        ),
                tabPanel("Instructions",
                         h2("Description"),
                         div("This simple web app shows the survival probability of a passenger on board the famous Titanic based on simple assumptions made on age, sex and ticket class."),
                         h2("How to use the app"),
                         div("The app is quite simple to use: select the sex of an hypothetical passenger, its ticket class and its age on the slider. You will then get a real time output of its survival probability compared to the average survival probability of the other passengers (~40%). There is no \"free input\" from you so in a sense \"you cannot break it\" but nonetheless have fun experimenting!"),
                         h2("Data"),
                         div("The data used are those of the famous Kaggle dataset for the Titanic competition. For this web app it has been simplified to allow faster computations and visualisation of the results: we only chose input of age (at least 1 year old), sex and ticket class of the passengers."),
                         h2("Methodology"),
                         div("Predictions are made using a very simple logistic regression model to avoid complicated computations. From the point of view of the predictions we could have achieved better performance using a different approach, but in this case we preferred to use a fast and quick way to get to the solution.")
                        )
            )
        )
    )
))
