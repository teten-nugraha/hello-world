package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	// optional: release mode (lebih ringan)
	gin.SetMode(gin.ReleaseMode)

	router := gin.Default()

	router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"status": "ok",
		})
	})

	router.Run(":1111")
}
