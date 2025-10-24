extends Node3D

var min_limit_x := -0.8
var max_limit_x := -0.2
var mouse_acceleration := 0.005
var horizontal_acceleration := 2.0
var vertical_acceleration := 1.0

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	rotate_from_vector(joy_dir * Vector2(horizontal_acceleration, vertical_acceleration) * delta)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_acceleration)

func rotate_from_vector(v: Vector2):
	if v.length() > 0:
		rotation.y += v.x
		$Camera3D.rotation.x += v.y
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, min_limit_x, max_limit_x)
