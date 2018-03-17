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
	app.GET("/mnemonic", index)
	app.GET("/mnemonic/:count", RandomWord)
	app.Run(":8000")
}
