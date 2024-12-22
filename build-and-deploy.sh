#!/bin/bash

# Create Docker image
docker build -t student-microservice .

# Apply Kubernetes manifests
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Wait for the pods to be ready
echo "Waiting for the pods to be ready..."
kubectl wait --for=condition=available --timeout=60s deployment/student-microservice

# Get the service URL
SERVICE_URL=$(kubectl get service student-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
SERVICE_PORT=$(kubectl get service student-service -o jsonpath='{.spec.ports[0].nodePort}')
FULL_SERVICE_URL="http://127.0.0.1:$SERVICE_PORT"

# Test the root endpoint
echo "Testing the root endpoint..."
RESPONSE=$(curl -s $FULL_SERVICE_URL)

# Check if the response contains the expected message
if [[ "$RESPONSE" == *"Welcome to the Student API! To check the student status, please add : '/student' to the  current URL"* ]]; then
    echo "Test passed: $STUDENT_RESPONSE"
else 
    echo "Test failed: Expected '{\"student_status\":\"hired\"}', but got '$STUDENT_RESPONSE'"
    exit 1
fi

echo "Deployment and testing completed successfully."




