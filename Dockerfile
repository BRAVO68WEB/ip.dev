# syntax=docker/dockerfile:1

# --- Build stage ---
FROM golang:1.24-alpine AS builder
WORKDIR /app

# Install build deps
RUN apk add --no-cache git ca-certificates tzdata

# Cache go mod
COPY go.mod go.sum ./
RUN go mod download

# Copy source
COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/ip-service main.go

# --- Runtime stage ---
FROM alpine:3.20
WORKDIR /app

RUN apk add --no-cache ca-certificates curl bash

# Copy binary
COPY --from=builder /out/ip-service /app/ip-service

# Copy data directory if exists
COPY data/ /app/data/

# Expose port
EXPOSE 8080

# Default env for db path
ENV MMDB_PATH=/app/data/GeoLite2-City.mmdb

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://localhost:8080/self || exit 1

# Entrypoint
ENTRYPOINT ["/app/ip-service"]