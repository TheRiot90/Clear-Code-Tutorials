extends CharacterBody3D

var direction: Vector2
var speed := 4.0


func get_input():
	direction = Input.get_vector("left","right","backward","forward")


func _physics_process(delta: float) -> void:
	get_input()
	velocity = Vector3(direction.x,0,direction.y) * speed
	move_and_slide()
