# syntax=docker/dockerfile:1
FROM golang:1.19.4-alpine AS base
ENV CGO_ENABLED=0
WORKDIR /src
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,source=go.mod,target=go.mod \
    --mount=type=bind,source=go.sum,target=go.sum \
    go mod download -x
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,target=. \
    go build -o /bin/client ./cmd/client
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,target=. \
    go build -o /bin/server ./cmd/server

FROM scratch
COPY --from=base /bin/client /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]
