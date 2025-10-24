extends CharacterBody3D

var direction: Vector2
var speed := 4.0
@onready var camera = $CameraController/Camera3D

func get_input():
	direction = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)


func _physics_process(delta: float) -> void:
	get_input()
	velocity = Vector3(direction.x,0,direction.y) * speed
	move_and_slide()
