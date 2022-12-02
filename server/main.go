package main

import (
	"log"
	"net/http"
	"strings"
	"unicode"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/translate", func(w http.ResponseWriter, r *http.Request) {
    msg := r.URL.Query().Get("s")
		translated := translate(msg)
		w.Write([]byte(translated))
	})
	log.Println("Listening on HTTP port 3000")
	log.Fatal(http.ListenAndServe(":3000", r))
}

func isVowel(char rune) bool {
	switch rune(char) {
	case 'a', 'e', 'i', 'o', 'u', 'å', 'ä', 'ö':
		return true
	default:
		return false
	}
}

func translate(msg string) string {
	msg = strings.ToLower(msg)
	var b strings.Builder
	for _, char := range msg {
		if unicode.IsLetter(char) {
			if isVowel(char) {
				b.WriteRune(char)
				continue
			}
			b.WriteRune(char)
			b.WriteRune('o')
			b.WriteRune(char)
			continue
		}
		if unicode.IsSpace(char) {
			b.WriteRune(' ')
		}
	}
	return b.String()
}
