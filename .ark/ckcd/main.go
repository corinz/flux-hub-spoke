package main

import (
	"ckcd/internal/adapter"
	"ckcd/internal/config"
	"log"
	"strings"
)

func main() {
	cfg, err := config.NewConfig("./config.yaml")
	if err != nil {
		log.Fatal(err)
	}
	//var objList []adapter.Adapter
	for _, app := range cfg.Apps {
		if app.Enabled {
			switch strings.ToLower(app.Type) {
			case "helm":
				log.Println("Creating helm chart")
				rendered, err := adapter.NewHelm(app.Target, app.Target+"/values.yaml")
				if err != nil {
					log.Fatal(err)
				}
				log.Print(rendered)
			default:
				log.Println("Unknown app type:", app.Type)
			}

		}
	}

}
