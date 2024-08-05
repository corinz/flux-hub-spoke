package adapter

import (
	"bytes"
	"fmt"
	"helm.sh/helm/v3/pkg/chart"
	"helm.sh/helm/v3/pkg/chart/loader"
	"helm.sh/helm/v3/pkg/engine"
	"log"
)

type Helm struct {
	chart    *chart.Chart
	Rendered []byte
}

func NewHelm(chartPath string, valuesPath string) (map[string]string, error) {
	// Load the Helm chart from the local filesystem
	ch, err := loader.Load(chartPath)
	if err != nil {
		return nil, fmt.Errorf("failed to load chart: %w", err)
	}

	// Read values from the file
	//values, err := chartutil.ReadValuesFile(valuesPath)
	//if err != nil {
	//	return nil, fmt.Errorf("failed to read values file: %w", err)
	//}
	//ch.Values = values

	var vals = map[string]interface{}{
		"Release": map[string]interface{}{
			"Name": "test",
		},
		"Values": map[string]interface{}{
			"serviceAccount": map[string]interface{}{
				"enabled": true,
			},
		},
	}
	//chartutil.CoalesceValues(ch, vals)
	rendered, err := engine.Render(ch, vals)
	if err != nil {
		return nil, fmt.Errorf("failed to render chart: %w", err)
	}

	return rendered, nil
}

// RenderChart renders a Helm chart from the local filesystem into a byte array
func (h *Helm) render() ([]byte, error) {

	//v, _ := chartutil.CoalesceValues(h.chart, h.values)
	// Template the chart with the values
	rendered, err := engine.Render(h.chart, h.chart.Values)
	if err != nil {
		log.Println(h.chart.Values)
		return nil, fmt.Errorf("failed to render chart: %w", err)
	}

	// Convert rendered map to a byte array
	var buf bytes.Buffer
	for _, manifest := range rendered {
		buf.WriteString(manifest)
	}

	return buf.Bytes(), nil
}
