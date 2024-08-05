package config

import (
	"gopkg.in/yaml.v3"
	"log"
	"os"
)

// Config represents the structure of the configuration file
type Config struct {
	Name           string               `yaml:"name"`
	ReleaseChannel string               `yaml:"releaseChannel"`
	Owner          string               `yaml:"owner"`
	Labels         map[string]string    `yaml:"labels"`
	Apps           map[string]AppConfig `yaml:"apps"`
}

// AppConfig holds the configuration for each app
type AppConfig struct {
	Enabled        bool              `yaml:"enabled"`
	ReleaseChannel string            `yaml:"releaseChannel,omitempty"`
	Config         map[string]string `yaml:"config"`
	Target         string            `yaml:"target"`
	Type           string            `yaml:"type"`
}

func NewConfig(path string) (Config, error) {
	// Open the YAML file
	file, err := os.Open(path)
	if err != nil {
		return Config{}, err
	}
	defer file.Close()

	// Parse the YAML file
	var config Config
	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(&config); err != nil {
		log.Fatalf("error decoding YAML: %v", err)
	}

	return config, err
}
