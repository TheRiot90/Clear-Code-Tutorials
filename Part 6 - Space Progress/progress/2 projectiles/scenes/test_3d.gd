extends Node3D

func _ready() -> void:
	$MeshInstance3D.rotate_y(20)
	$ExerciseDonut.mesh.material.albedo_color = Color(Color.DEEP_SKY_BLUE)

func _process(delta: float) -> void:
	$MeshInstance3D.rotate_z(0.1 * delta)
	$ExerciseDonut.position.x += 2 * delta
	$ExerciseDonut.rotation.y += 2 * delta
