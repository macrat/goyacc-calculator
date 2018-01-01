calculator: parser.go main.go calculate.go
	go build -o $@

parser.go: parser.go.y
	goyacc -o $@ $^
