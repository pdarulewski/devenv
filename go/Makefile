app:
	go build -o ./bin/app cmd/main.go

docker:
	docker buildx build \
		-f build/Dockerfile \
		-t app:dev \
		.

lint:
	golangci-lint run

mocks:
	mockery

test:
	go test ./... \
		-coverprofile coverage.out \
		-race
	grep -v '\.gen\.go' coverage.out > coverage.filtered.out
	go tool cover -func coverage.filtered.out | awk '/total:/ {print $$3}'
