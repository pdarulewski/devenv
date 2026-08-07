// Package main is the entrypoint to the app.
package main

import (
	"errors"
	"net/http"

	"github.com/pdarulewski/go/pkg/api"
	"github.com/pdarulewski/go/pkg/logger"
)

func main() {
	logger := logger.New()

	srv, _ := api.Server(logger)

	logger.Info("api started")

	if err := srv.ListenAndServe(); err != nil && errors.Is(err, http.ErrServerClosed) {
		panic(err)
	}
}
