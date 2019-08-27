## Install ML FLow from CRAN, and carrier as well
install.packages('mlflow')
install.packages('carrier')

## Load the library and others we need for the notebook
library(mlflow)
library(DBI)
library(MASS)
library(SparkR)
library(glmnet)
library(randomForest)
library(carrier)
library(caret)

## Complete the installation
install_mlflow()

data(Boston, package="MASS")

set.seed(40)

# Split the data into training and test sets. (0.75, 0.25) split.
sampled <- base::sample(1:nrow(Boston), 0.75 * nrow(Boston))
train <- Boston[sampled, ]
test <- Boston[-sampled, ]

# The predicted column is "quality" which is a scalar from [3, 9]
train_x <- as.matrix(train[, !(names(train) == "medv")])
test_x <- as.matrix(test[, !(names(train) == "medv")])
 
train_y <- as.matrix(subset(train, select = c(medv)))
test_y <- as.matrix(subset(test, select = c(medv)))

with(mlflow_start_run(), {

    #Create control function for training with 10 folds and keep 3 folds for training. search method is grid.
    control <- trainControl(method='repeatedcv', number=10, repeats=3, search='grid')
    tunegrid <- expand.grid(.mtry = (1:15))
    
    rf_gridsearch <- train(medv ~ ., data = train, method = 'rf', metric = 'rmse', tuneGrid = tunegrid)
    model <- rf_gridsearch$finalModel
    predictor <- crate(function(x){library(randomForest);stats::predict(!!model, as.matrix(x))}, !!model)
    predicted <- predictor(test)
    
    rmse <- sqrt(mean((predicted - test_y) ^ 2))
    mae <- mean(abs(predicted - test_y))
    r2 <- as.numeric(cor(predicted, test_y) ^ 2)

    ## Log the parameters associated with this run

    mlflow_log_param("mtry", rf_gridsearch$finalModel$mtry)
    mlflow_log_param("ntree", rf_gridsearch$finalModel$ntree)
#     mlflow_log_param("Best Model", model)
    ## Log metrics we define from this run
    mlflow_log_metric("rmse", rmse)
    mlflow_log_metric("r2", r2)
    mlflow_log_metric("mae", mae)
    mlflow_log_model(predictor, "model")
  })
