package main

import (
	"log"
)

func main() {
	err := ping()
	if err != nil {
		log.Fatal(err)
	}
	log.Fatal(play())
}
