extends CharacterBody3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var player = get_tree().get_first_node_in_group('Player')
@export var notice_radius = 20
@export var attack_radius = 2
@export var speed := 2.0
@export var can_damage: bool = false
var alive := true

 
func _physics_process(delta: float) -> void:
	if alive and position.distance_to(player.position) < notice_radius:
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

		if can_damage and position.distance_to(player.position) < attack_radius:
			player.hit()


func _on_attack_timer_timeout() -> void:
	$AttackTimer.wait_time = randf_range(3,4)
	if position.distance_to(player.position) < attack_radius:
		$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func defeat():
	alive = false
	call_deferred("disable_collision")
	var tween = create_tween()
	tween.tween_method(death_animation, 0.0, 1.0, 0.5)


func disable_collision():
	$CollisionShape3D.disabled = true


func death_animation(value: float):
	$AnimationTree.set("parameters/DeathBlend/blend_amount", value)
