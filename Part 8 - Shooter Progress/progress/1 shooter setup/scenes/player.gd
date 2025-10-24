extends CharacterBody3D

var direction: Vector2
var speed := 10
var mouse_acceleration = Vector2(0.001, 0.001)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Camera3D.rotation.y -= event.relative.x * mouse_acceleration.x
		$Camera3D.rotation.x -= event.relative.y * mouse_acceleration.y
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,-PI/3, PI/3)


func get_input():
	direction = Input.get_vector("left", "right","forward", "backward").rotated(-$Camera3D.global_rotation.y)
	velocity.x = direction.x * speed
	velocity.z = direction.y * speed
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
