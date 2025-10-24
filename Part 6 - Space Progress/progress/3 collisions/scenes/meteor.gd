extends Area3D

var speed: float 
var direction_x: float
var can_move := true


func _ready() -> void:
	direction_x = randf_range(-1, 1)
	position.z = -10
	var random_scale = randf_range(1,3)
	scale = Vector3(random_scale, random_scale, random_scale)
	speed = randf_range(3,5)


func _physics_process(delta: float) -> void:
	if can_move:
		position.z += 2 * delta
		position.x += direction_x * delta
		rotate_x(1.5 * delta)
		rotate_z(1.5 * delta)
	


func _on_area_entered(area: Area3D) -> void:
	can_move = false
	area.destroy()
	$meteor.material_overlay.set_shader_parameter('progress', 1.0)
	await get_tree().create_timer(0.4).timeout
	queue_free()


func _on_body_entered(_player: CharacterBody3D) -> void:
	get_tree().quit()
