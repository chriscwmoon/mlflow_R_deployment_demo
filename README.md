# MLflow R Model Deployment Demo

MLflow R model deployment demo on Azure



Docker commands:

Build a docker image :
`docker build --rm -t rdeploy .`

Run an image:
``docker run --rm -P rdeploy``

Find currently running containers:
``docker ps -a``

Validate the running docker:
`` docker exec -it f107b8141860 curl -X POST "http://localhost:5001/predict/" -H "accept: application/json" -H "Content-Type: application/json" -d  '{"fixed.acidity":[7],"volatile.acidity":[0.27],"citric.acid":[0.36],"residual.sugar":[20.7],"chlorides": [0.045],"free.sulfur.dioxide":[45],"totalping 52.184.228.164``
