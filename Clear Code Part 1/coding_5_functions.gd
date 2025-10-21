extends Node2D


func _ready():
	#test_func(123)
	#print(return_something() * 2)
	print(calculate(15, 5))


func test_func(parameter_one: int, parameter_two: String = 'test'):
	print('test function')
	print(parameter_one, ' ', parameter_two)


func return_something() -> int:
	print('return something function was run')
	return 100
	
	
func calculate(first_num: int, second_num: int, operator: String = 'plus') -> int:
	var result: int
	if operator == 'plus':
		result = first_num + second_num
	elif operator == 'minus':
		result = first_num - second_num
	elif operator == 'multiply':
		result = first_num * second_num
	elif operator == 'divide':
		result = first_num / second_num
	return result
