#extends CharacterBody2D
#
#
#var direction: Vector2
#var speed := 50
#var player: CharacterBody2D
#var health := 3
#var is_exploding: bool = false
##signal exploded(position: Vector2)
#
#
#func _ready():
	#add_to_group('Drones')
	#for drone in get_tree().get_nodes_in_group('Drones'):
		#if drone != self:
			#drone.connect("exploded", Callable(self, "_on_other_drone_exploded"))
#
#
#func _on_detection_area_body_entered(player_body: CharacterBody2D) -> void:
	#player = player_body
	#$AnimationPlayer2.play("drone_light")
	#
	#
#func _on_detection_area_body_exited(_player_body: CharacterBody2D) -> void:
	#player = null
	#
	#
#func _physics_process(_delta: float) -> void:
	#if player:
		#var dir = (player.position - position).normalized()
		#velocity = dir * speed
		#move_and_slide()
#
#
#func _on_collision_area_body_entered(_body: Node2D) -> void:
	#explode()
#
#
#func hit():
	#health -= 1
	#if health <= 0:
		##is_exploding = true
		#explode()
#
#
#func explode():
	#$Explosion.play()
	#speed = 0
	#$AnimatedSprite2D.hide()
	#$ExplosionSprite.show()
	#$AnimationPlayer.play("explode")
	#await $AnimationPlayer.animation_finished
	#queue_free()
#
##func chain_reaction():
	##for drone in get_tree().get_nodes_in_group("Drones"):
		##if position.distance_to(drone.position) < 20:
			##if drone != self:
				##drone.explode
extends CharacterBody2D

var speed := 50
var player: Node2D = null
var health := 3
var is_exploding: bool = false
const EXPLOSION_RADIUS := 100.0

func _ready() -> void:
	add_to_group("drones")

func _physics_process(_delta: float) -> void:
	if player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

func _on_detection_area_body_entered(player_body: Node2D) -> void:
	player = player_body
	$AnimationPlayer2.play("drone_light")

func _on_detection_area_body_exited(_player_body: Node2D) -> void:
	player = null

func _on_collision_area_body_entered(_body: Node2D) -> void:
	explode()

func hit() -> void:
	health -= 1
	if health <= 0:
		explode()

func explode() -> void:
	if is_exploding:
		return
	is_exploding = true
	# Play visuals/audio
	$Explosion.play()
	speed = 0
	$AnimatedSprite2D.hide()
	$ExplosionSprite.show()
	$AnimationPlayer.play("explode")
	# Tell every drone about this explosion (including ourselves).
	# Our own handler will ignore it because is_exploding is already true.
	get_tree().call_group("drones", "_on_other_drone_exploded", position)
	await $AnimationPlayer.animation_finished
	queue_free()


# Called for each drone in the group (including the origin)
func _on_other_drone_exploded(explosion_pos: Vector2) -> void:
	if is_exploding:
		return
	if position.distance_to(explosion_pos) <= EXPLOSION_RADIUS:
		explode()
