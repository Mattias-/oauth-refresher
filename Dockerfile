FROM golang:latest
WORKDIR /src/oauth-refresher
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build

FROM scratch
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /src/oauth-refresher/refresher .
ENTRYPOINT ["/refresher"]
