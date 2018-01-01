package main

import (
	"strconv"
)

type Calculable interface {
	calc() int
}

func (n Number) calc() int {
	if i, err := strconv.ParseInt(n.Literal, 10, 64); err != nil {
		return 0
	} else {
		return int(i)
	}
}

func (ope Operator) calc(left, right Calculable) int {
	switch ope.Literal {
	case "+":
		return left.calc() + right.calc()
	case "-":
		return left.calc() - right.calc()
	case "*":
		return left.calc() * right.calc()
	case "/":
		return left.calc() / right.calc()
	default:
		return 0
	}
}

func (be BinaryExpression) calc() int {
	return be.Operator.calc(be.Left.(Calculable), be.Right.(Calculable))
}

func Calculate(e Expression) int {
	return e.(Calculable).calc()
}
