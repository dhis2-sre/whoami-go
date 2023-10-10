package main

import (
	"fmt"
	. "github.com/dhis2-sre/whoami-go/internal"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", WhoAmI)
	http.HandleFunc("/health", Health)

	port := "8080"
	if value, ok := os.LookupEnv("PORT"); ok {
		port = value
	}

	log.Printf("Server listening on port: %s", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
