my test of goyacc
=================

``` shell
$ git clone https://github.com/macrat/goyacc-calculator && cd goyacc-calculator

$ make
```

``` shell
$ ./calculator '1 + 2 * 3 - 4'
{
	"Left": {
		"Literal": "1"
	},
	"Operator": {
		"Literal": "+"
	},
	"Right": {
		"Left": {
			"Literal": "2"
		},
		"Operator": {
			"Literal": "*"
		},
		"Right": {
			"Left": {
				"Literal": "3"
			},
			"Operator": {
				"Literal": "-"
			},
			"Right": {
				"Literal": "4"
			}
		}
	}
}
= -1
```

``` shell
$ ./calculator '(1 + 2) * (3 - 4)'
{
	"Left": {
		"Left": {
			"Literal": "1"
		},
		"Operator": {
			"Literal": "+"
		},
		"Right": {
			"Literal": "2"
		}
	},
	"Operator": {
		"Literal": "*"
	},
	"Right": {
		"Left": {
			"Literal": "3"
		},
		"Operator": {
			"Literal": "-"
		},
		"Right": {
			"Literal": "4"
		}
	}
}
= -3
```
