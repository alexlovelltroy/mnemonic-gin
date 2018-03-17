package main

import (
	"os"

	"github.com/gin-gonic/gin"
)

func getColor() string {
	return os.Getenv("COLOR")
}

func main() {
	app := gin.Default()
	app.GET("/", index)
	app.GET("/api", index)
	app.GET("/api/:count", RandomWord)
	app.Run("0.0.0.0:8000")
}
