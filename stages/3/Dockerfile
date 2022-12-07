# syntax=docker/dockerfile:1
FROM golang:1.19.3-alpine
WORKDIR /src
COPY go.mod go.sum .
RUN --mount=type=cache,target=/go/pkg/mod/ \
    go mod download -x
COPY . .
RUN go build -o client ./cmd/client
RUN go build -o server ./cmd/server
CMD ./server
