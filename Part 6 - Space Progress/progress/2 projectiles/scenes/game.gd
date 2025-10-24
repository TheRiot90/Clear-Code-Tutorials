extends Node3D

var laser_scene: PackedScene = preload("res://scenes/laser.tscn")
var meteor_scene: PackedScene = preload("res://scenes/meteor.tscn")

func _on_player_shoot_laser(pos: Vector3) -> void:
	var laser = laser_scene.instantiate() as Area3D
	$Projectiles.add_child(laser)
	laser.position = pos + Vector3(0,0,-1.2)


func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Projectiles.add_child(meteor)
