package main

import (
	"math/rand"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func init() {
	rand.Seed(52)
}

func oneword() string {
	return wordlist[rand.Intn(len(wordlist))]
}

func index(c *gin.Context) {
	content := gin.H{"Hello": "Friend", "Version": getColor(), "Wordlist Length": len(wordlist), "Wordlist Capacity": cap(wordlist)}
	c.JSON(200, content)
}

// RandomWord accepts an argument and assumes that it can be coerced into an integer.  It uses that
// integer to create a json with that number of words randomly selected from the wordlist.
func RandomWord(c *gin.Context) {
	wordcount := c.Params.ByName("count")
	intWordcount, err := strconv.Atoi(wordcount)

	if err != nil {
		errContent := gin.H{"error": "That doesn't appear to be a number less than 200", "count": wordcount}
		c.JSON(200, errContent)
		// 200 is our upper limit
	} else if intWordcount > 200 {
		c.Redirect(http.StatusMovedPermanently, "/mnemonic/20")
	} else {
		var words = make([]string, intWordcount)
		for i := range words {
			words[i] = oneword()
		}
		content := gin.H{"count": intWordcount, "words": words}
		c.JSON(200, content)
	}
}
