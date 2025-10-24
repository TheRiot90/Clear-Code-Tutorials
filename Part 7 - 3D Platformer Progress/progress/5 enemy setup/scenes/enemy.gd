extends CharacterBody3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var player = get_tree().get_first_node_in_group('Player')
@export var notice_radius = 20
@export var attack_radius = 2
@export var speed := 2.0

 
func _physics_process(delta: float) -> void:
	if position.distance_to(player.position) < notice_radius:
		var target_dir = (player.position - position).normalized()
		var target_vec2 = Vector2(target_dir.x, target_dir.z)
		rotation.y = rotate_toward(rotation.y, -target_vec2.angle() + PI/2, delta * 6.0)
		if position.distance_to(player.position) > attack_radius:
			velocity = Vector3(target_vec2.x, 0, target_vec2.y) * speed
			move_state_machine.travel('Walking')
		else:
			velocity = Vector3.ZERO
			move_state_machine.travel('Idle')
	
	if not is_on_floor():
		velocity.y -= 2
	else:
		velocity.y = 0
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	$AttackTimer.wait_time = randf_range(3,4)
	if position.distance_to(player.position) < attack_radius:
		$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
