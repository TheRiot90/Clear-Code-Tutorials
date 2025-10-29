extends Node2D


var bullet_scene = preload("res://scenes/bullets/bullet.tscn")


func _ready() -> void:
	var light_tween = get_tree().create_tween()
	light_tween.set_loops()
	light_tween.bind_node($".")
	light_tween.tween_property($PointLight2D2, "energy", 1.5, 1)
	light_tween.tween_property($PointLight2D2, "energy", 0.5, 1)

func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	$Bullets.add_child(bullet)
	bullet.setup(pos, dir)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	call_deferred("change_scene")
	
	
func change_scene():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
