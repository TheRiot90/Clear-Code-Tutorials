extends Node2D

var direction = Vector2(1, 1)
var speed = 20


func _ready() -> void:
	print([1, 2, 3, 'string', false, [1, 2, 3]])
func _process(delta: float) -> void:
	print(Vector2(2, 3) * 3)
	$Icon.position += direction * 2
