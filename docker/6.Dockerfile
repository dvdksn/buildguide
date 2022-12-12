# syntax=docker/dockerfile:1
FROM --platform=${BUILDPLATFORM} golang:1.19.4-alpine AS base
ENV CGO_ENABLED=0
WORKDIR /src
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,source=go.mod,target=go.mod \
    --mount=type=bind,source=go.sum,target=go.sum \
    go mod download -x

FROM base AS build-client
ARG TARGETOS
ARG TARGETARCH
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,target=. \
    GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/client ./cmd/client

FROM base AS build-server
ARG TARGETOS
ARG TARGETARCH
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,target=. \
    GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/server ./cmd/server

FROM scratch AS client
COPY --from=build-client /bin/client /bin/
ENTRYPOINT [ "/bin/client" ]

FROM scratch AS server
COPY --from=build-server /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]

FROM scratch AS binaries
COPY --from=build-client /bin/client /
COPY --from=build-server /bin/server /
