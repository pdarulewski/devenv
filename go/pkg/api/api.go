// Package api defines API utilities.
package api

import (
	"log/slog"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Server creates a basic router with a healthz and metrics endpoints.
func Server(logger *slog.Logger) (*http.Server, *http.ServeMux) {
	mux := http.NewServeMux()

	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusOK)
	})

	mux.Handle("GET /metrics", promhttp.Handler())

	handler := LoggingMiddleware(logger, mux)

	srv := &http.Server{ //nolint:exhaustruct
		Addr:              ":8080",
		Handler:           handler,
		ReadHeaderTimeout: 5 * time.Second, //nolint:mnd
	}

	return srv, mux
}

// LoggingMiddleware logs API responses.
func LoggingMiddleware(logger *slog.Logger, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/healthz" {
			next.ServeHTTP(w, r)

			return
		}

		start := time.Now()

		next.ServeHTTP(w, r)

		logger.Info(
			"http request",
			slog.String("method", r.Method),
			slog.String("path", r.URL.Path),
			slog.Duration("elapsed", time.Since(start)),
		)
	})
}
