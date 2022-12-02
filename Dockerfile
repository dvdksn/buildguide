# syntax=docker/dockerfile:1
FROM golang:1.19.3-alpine
WORKDIR /src
COPY . .
RUN go mod download
RUN go build -o translate ./client
RUN go build -o translated ./server
