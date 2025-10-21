extends Node2D

var a := 0
var direction := 1
var speed := 15

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$Icon.position.y += speed * direction
	if $Icon.position.y >= 648:
		direction = -1
	if $Icon.position.y < 0:
		direction = 1
