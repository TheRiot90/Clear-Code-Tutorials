extends Node3D

var laser_scene: PackedScene = preload("res://scenes/laser.tscn")
var meteor_scene: PackedScene = preload("res://scenes/meteor.tscn")
var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")
var game_size = {
	'left': - 15,
	'right': 15,
	'front': -2,
	'back': -40
}

func _ready() -> void:
	for i in randi_range(50,60):
		var obstacle = obstacle_scene.instantiate()
		$Projectiles.add_child(obstacle)
		obstacle.set_xz_pos(
			randf_range(game_size['left'], game_size['right']),
			randf_range(game_size['front'], game_size['back']),
		)


func _on_player_shoot_laser(pos: Vector3) -> void:
	var laser = laser_scene.instantiate() as Area3D
	$Projectiles.add_child(laser)
	laser.position = pos + Vector3(0,0,-1.2)


func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Projectiles.add_child(meteor)


func _on_obstacle_timer_timeout() -> void:
	for i in randi_range(3,6):
		var obstacle = obstacle_scene.instantiate()
		$Projectiles.add_child(obstacle)
		obstacle.set_xz_pos(
			randf_range(game_size['left'], game_size['right']),
			randf_range(game_size['back'], game_size['back'] + 5),
		)
