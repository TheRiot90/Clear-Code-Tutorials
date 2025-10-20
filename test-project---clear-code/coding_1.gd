extends Node2D

var side_a = 20
var side_b = 30.2
var test := "a string"

func _ready():
	print(2 / 3)
	
	# exercise
	print((side_a ** 2 + side_b ** 2) ** 0.5)
	side_a = 100
	print(side_a)

	test = "string"
	print(test)
