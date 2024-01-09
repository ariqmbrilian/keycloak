```
source: https://www.keycloak.org/server/containers

url: https://localhost:8443
health check endpoint: 
    - https://localhost:8443/health
    - https://localhost:8443/health/ready
    - https://localhost:8443/health/live
metrics: https://localhost:8443/metrics

docker compose up -d
``````
