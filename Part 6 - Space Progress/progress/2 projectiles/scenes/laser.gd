extends Area3D

var speed := 15

func _ready() -> void:
	scale = Vector3(0.1,0.1,0.1)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3.ONE, 0.4)


func _physics_process(delta: float) -> void:
	position.z -= speed * delta
	if position.z <= -200:
		queue_free()
