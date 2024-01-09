FROM quay.io/keycloak/keycloak:23.0.3 as builder

# Metrics
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# DB vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:23.0.3
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://postgres:5432/keycloak
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=password
ENV KC_HOSTNAME=whoami.infra.nocracingteam.my.id
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HTTP_ENABLED=true
ENV KC_PROXY=edge
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz
ENV PROXY_ADDRESS_FORWARDING=true
ENV KC_HOSTNAME_STRICT_BACKCHANNEL=true
ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
