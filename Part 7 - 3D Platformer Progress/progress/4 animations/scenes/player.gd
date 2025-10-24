extends CharacterBody3D

# movement
var direction: Vector2
var speed := 4.0
var acceleration := 8.0
var friction := 12.0
@onready var camera = $CameraController/Camera3D
@onready var skin = $Skin
@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")

# jumping
@export var jump_strength = 15
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
# source: https://youtu.be/IOe1aGY6hXA?feature=shared

func get_input():
	direction = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)
	if Input.is_action_just_released("jump") and is_on_floor():
		jump()
	if Input.is_action_just_pressed("ui_cancel"):
		$AnimationTree.set("parameters/HitOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func _physics_process(delta: float) -> void:
	get_input()
	move(delta)
	apply_gravity(delta)
	move_and_slide()
	animate(delta)

func animate(delta):
	move_state_machine.travel('Running' if direction else 'Idle')
	if not is_on_floor():
		move_state_machine.travel('Jump')
	if direction:
		skin.rotation.y = rotate_toward(skin.rotation.y,-direction.angle() + PI/2, 6.0 * delta)


func move(delta):
	var vel_2d := Vector2(velocity.x, velocity.z)
	if direction:
		vel_2d += direction * speed * delta * acceleration
		vel_2d = vel_2d.limit_length(speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, speed * friction * delta)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y

func jump():
	velocity.y = jump_strength


func apply_gravity(delta):
	if not is_on_floor():
		var gravity = jump_gravity if velocity.y > 0 else fall_gravity
		velocity.y -= gravity * delta
