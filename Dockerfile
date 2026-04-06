# Stage 1: Build
FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go

# Stage 2
FROM alpine:3.20

WORKDIR /app
COPY --from=builder /app/app .

EXPOSE 1111
CMD ["./app"]