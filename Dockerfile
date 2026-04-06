# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy semua file (tanpa go.mod/go.sum requirement)
COPY . .

# Build binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go

# Stage 2: Run
FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app/app .

EXPOSE 1111

CMD ["./app"]