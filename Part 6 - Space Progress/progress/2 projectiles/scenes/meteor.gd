extends Area3D

var speed: float 
var direction_x: float

func _ready() -> void:
	direction_x = randf_range(-1, 1)
	position.z = -10
	var random_scale = randf_range(1,3)
	scale = Vector3(random_scale, random_scale, random_scale)
	speed = randf_range(3,5)


func _physics_process(delta: float) -> void:
	position.z += 2 * delta
	position.x += direction_x * delta
	rotate_x(1.5 * delta)
	rotate_z(1.5 * delta)
	
