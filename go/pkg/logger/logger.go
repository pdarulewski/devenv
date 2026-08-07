// Package logger provides logging utilities.
package logger

import (
	"log/slog"
	"os"
)

// New returns a structured JSON format logger.
func New() *slog.Logger {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

	return logger
}
