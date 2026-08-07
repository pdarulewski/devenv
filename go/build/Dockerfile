FROM golang:1.26.5-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download
COPY . .
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go build -o /bin/app ./cmd/main.go

FROM scratch AS runner

COPY --from=builder /bin/app /app

ENTRYPOINT ["/app"]
