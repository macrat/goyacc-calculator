%{
package main

import (
	"io"
	"text/scanner"
)

type Expression interface {}

type Token struct {
	Token   int
	Literal string
}

type Number struct {
	Literal string
}

type Operator struct {
	Literal string
}

type BinaryExpression struct {
	Left     Expression
	Operator Operator
	Right    Expression
}

%}

%union{
	token Token
	expr Expression
	ope  Operator
}

%type<expr> program
%type<expr> expr
%type<ope> ope
%token<token> NUMBER

%left '+' '-'
%left '*' '/'

%%

program
	: expr
	{
		$$ = $1
		yylex.(*Lexer).result = $$
	}

expr
	: NUMBER
	{
		$$ = Number{Literal: $1.Literal}
	}
	| expr ope expr
	{
		$$ = BinaryExpression{Left: $1, Operator: $2, Right: $3}
	}
	| '(' expr ')'
	{
		$$ = $2
	}

ope
	: '+'
	{
		$$ = Operator{Literal: "+"}
	}
	| '-'
	{
		$$ = Operator{Literal: "-"}
	}
	| '*'
	{
		$$ = Operator{Literal: "*"}
	}
	| '/'
	{
		$$ = Operator{Literal: "/"}
	}
%%

type Lexer struct {
	scanner.Scanner

	result Expression
}

func (l *Lexer) Lex(lval *yySymType) int {
	token := int(l.Scan())
	if token == scanner.Int {
		token = NUMBER
	}
	lval.token = Token{Token: token, Literal: l.TokenText()}
	return token
}

func (l *Lexer) Error(e string) {
	panic(e)
}

func Parse(file io.Reader) Expression {
	l := new(Lexer)
	l.Init(file)

	yyParse(l)

	return l.result
}
