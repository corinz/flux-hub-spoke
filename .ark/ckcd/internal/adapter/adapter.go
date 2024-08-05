package adapter

type Adapter interface {
	render() ([]byte, error)
}
