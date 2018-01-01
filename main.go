package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
)

func showExpression(expr Expression) {
	bytes, err := json.MarshalIndent(expr, "", "\t")
	if err != nil {
		panic(err.Error())
	}
	fmt.Println(string(bytes))
}

func main() {
	expr := Parse(strings.NewReader(os.Args[1]))
	showExpression(expr)
	fmt.Printf("= %d\n", Calculate(expr))
}
