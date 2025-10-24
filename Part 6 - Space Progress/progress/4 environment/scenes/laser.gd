extends Area3D

var speed := 15
var can_move := true


func _ready() -> void:
	scale = Vector3(0.1,0.1,0.1)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3.ONE, 0.4)
	

func _physics_process(delta: float) -> void:
	if can_move:
		position.z -= speed * delta
	if position.z <= -200:
		queue_free()


func destroy():
	can_move = false
	$Mesh.material_overlay.set_shader_parameter('progress', 1.0)
	await get_tree().create_timer(0.4).timeout
	queue_free()
