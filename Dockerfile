# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy go.mod kalau ada (optional tapi best practice)
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go

# Stage 2: Run (minimal image)
FROM alpine:3.20

WORKDIR /app

# Copy binary dari builder
COPY --from=builder /app/app .

# Expose port
EXPOSE 1111

# Run binary
CMD ["./app"]