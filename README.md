```
source: https://www.keycloak.org/server/containers

url: https://localhost:8080
health check endpoint: 
    - https://localhost:8080/health
    - https://localhost:8080/health/ready
    - https://localhost:8080/health/live
metrics: https://localhost:8080/metrics

docker compose up -d
``````
