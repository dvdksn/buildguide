# syntax=docker/dockerfile:1
FROM golang:1.19.4-alpine
WORKDIR /src
COPY go.mod go.sum .
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download -x
COPY . .
RUN --mount=type=cache,target=/go/pkg/mod \
    go build -o /bin/client ./cmd/client
RUN --mount=type=cache,target=/go/pkg/mod \
    go build -o /bin/server ./cmd/server
ENTRYPOINT [ "/bin/server" ]
