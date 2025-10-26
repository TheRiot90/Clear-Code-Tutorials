extends Node2D


var scale2: Vector2 = Vector2(.02, .02)


func _process(delta: float) -> void:
	scale += scale2
