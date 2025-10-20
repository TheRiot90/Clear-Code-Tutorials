extends Node2D

func _ready() -> void:
	position.x = 600

func _process(delta: float):
	$Sprite2D.rotate(0.1)
	$Sprite2D.position.x += 10

	# exercise
	$ExerciseSprite.position.x += 1.85
	$ExerciseSprite.position.y += 1
	$ExerciseSprite.scale.x *= 1.005
	$ExerciseSprite.scale.y *= 1.005
