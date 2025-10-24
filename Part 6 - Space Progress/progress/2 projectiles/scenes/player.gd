extends CharacterBody3D

var direction: float
var speed := 4
signal shoot_laser(pos: Vector3)


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	$craft_speederA.rotation.z = move_toward($craft_speederA.rotation.z, -direction / 2.0, delta)
	velocity.y = sin(Time.get_ticks_msec() / 500.0) / 4.0 + sin(Time.get_ticks_msec() / 600.0) / 10.0
	
	move_and_slide()

	if Input.is_action_just_pressed("laser"):
		shoot_laser.emit(global_position)
