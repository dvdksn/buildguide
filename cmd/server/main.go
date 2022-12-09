package main

import (
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		msg := r.URL.Query().Get("s")
		translated := translate(msg)
		w.Write([]byte(translated))
	})

	log.Println("Listening on HTTP port 3000")
	log.Fatal(http.ListenAndServe(":3000", r))
}
