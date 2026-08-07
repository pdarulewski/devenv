package logger_test

import (
	"testing"

	"github.com/pdarulewski/go/pkg/logger"
	"github.com/stretchr/testify/assert"
)

func TestNew(t *testing.T) {
	t.Parallel()

	t.Run("new logger", func(t *testing.T) {
		t.Parallel()

		logger := logger.New()
		assert.NotNil(t, logger)
	})
}
