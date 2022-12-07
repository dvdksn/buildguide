package main

import (
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"strings"
)

func main() {
	args := strings.Join(os.Args[1:], " ")
  requestUrl := "http://localhost:3000?s=" + url.QueryEscape(args)
	response, err := http.Get(requestUrl)
	if err != nil {
		fmt.Printf("[error] http request failed: %s", err)
		os.Exit(1)
	}
	body, err := io.ReadAll(response.Body)
	if err != nil {
		fmt.Printf("[error] failed to parse server response: %s", err)
	}

	fmt.Println(string(body))
}
