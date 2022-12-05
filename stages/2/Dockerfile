# syntax=docker/dockerfile:1
FROM golang:1.19.3-alpine
WORKDIR /src
COPY go.mod go.sum .
RUN go mod download
COPY . .
RUN go build -o client ./cmd/client
RUN go build -o server ./cmd/server
CMD ./server
