# Wine Model

### Requirement
requires R package `glmnet` to be installed on the environment
install.packages("glmnet")


### Validation 
```
http://localhost:5001/predict/" -H "accept: application/json" -H "Content-Type: application/json" -d  '{"fixed.acidity":[7],"volatile.acidity":[0.27],"citric.acid":[0.36],"residual.sugar":[20.7],"chlorides": [0.045],"free.sulfur.dioxide":[45],"total.sulfur.dioxide":[170],"density":[1.001],"pH":[3],"sulphates":[0.45],"alcohol": [8.8]}
```
