library(shiny)
library(caret)
library(titanic)
library(dplyr)

# transform data as in the analysis
train <- titanic_train
train <- train[,c(2,3,5,6)]
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
train$Sex <- as.factor(train$Sex)
train$Age <- as.numeric(train$Age)
train <- train %>% filter(Age >= 1)
train$Age <- as.integer(train$Age)

# compute total survival
surv.prob.tot <- nrow(train[train$Survived == 1,]) / nrow(train)

# load the model
log.reg = readRDS("log.reg.rds")

shinyServer(function(input, output) {
    
    pred.data <- reactive({
        data.frame(Pclass=input$class, Sex=tolower(input$sex), Age=input$age)
    })

    output$prob <- renderPlot({
        surv.prob.pred <- predict(log.reg, newdata=pred.data(), type="prob")[,2]
        surv.prob <- data.frame(type=factor(c("Average survival probability",
                                              "Predicted survival probability"
                                             )
                                           ),
                                probability=c(surv.prob.tot, surv.prob.pred)
                               )
        surv.plot <- ggplot(surv.prob, aes(x=type,
                                           y=probability,
                                           fill=type,
                                           label=paste(100*round(probability,2),
                                                       "%",
                                                       sep=""
                                                      )
                                          )
                           ) +
                     geom_bar(stat="identity") +
                     geom_text(size=8, position=position_stack(vjust=1)) +
                     scale_y_continuous(limits=c(0,1)) +
                     xlab("") +
                     ylab("") +
                     theme(legend.position="none") +
                     coord_flip()
        surv.plot
    })

})
