#!/bin/bash

echo "***************************************************************************************"
echo "*---------------------------------BEGIN LOAD TEST-------------------------------------*"
echo "***************************************************************************************"

if [ -z "$1" ]
then
  echo "No SERVICE_ENDPOINT was passed as a parameter, assuming it is passed as environment variable"
else
  echo "SERVICE_ENDPOINT was passed as a parameter"
  export SERVICE_ENDPOINT=$1
fi

export CONTENT_TYPE="Content-Type: text/html"
export ENDPOINT=$SERVICE_ENDPOINT/

echo "GET $ENDPOINT"
echo $CONTENT_TYPE

echo "Phase 1: Warming up - 30 seconds, 100 users."
./hey -z 30s -c 100  -H "$CONTENT_TYPE" -m GET "$ENDPOINT"

echo "Waiting 15 seconds for the cluster to stabilize"
sleep 15

echo "\nPhase 2: Load test - 30 seconds, 400 users."
./hey -z 30s -c 400  -H "$CONTENT_TYPE" -m GET "$ENDPOINT"

echo "Waiting 15 seconds for the cluster to stabilize"
sleep 15

echo "\nPhase 3: Load test - 30 seconds, 1600 users."
./hey -z 30s -c 1600  -H "$CONTENT_TYPE" -m GET "$ENDPOINT"

echo "Waiting 15 seconds for the cluster to stabilize"
sleep 15

echo "\nPhase 4: Load test - 30 seconds, 3200 users."
./hey -z 30s -c 3200  -H "$CONTENT_TYPE" -m GET "$ENDPOINT"

echo "Waiting 15 seconds for the cluster to stabilize"
sleep 15

echo "\nPhase 5: Load test - 30 seconds, 6400 users."
./hey -z 30s -c 6400  -H "$CONTENT_TYPE" -m GET "$ENDPOINT"

echo "***************************************************************************************"
echo "*----------------------------------END LOAD TEST--------------------------------------*"
echo "***************************************************************************************"