extends Control

func _ready() -> void:
	Global.current_monster = Global.monsters[0]
	$AttackSprite.hide()


func _on_input_menu_selected(state: int, type: Variant) -> void:
	match state:
		Global.State.ATTACK:
			var target = $Monsters/Enemy if Global.attack_data[type]['target'] else $Monsters/Player
			attack(target, type)
	
	
func attack(target: TextureRect, attack_type: Global.Attack):
	$AttackSprite.show()
	$AttackSprite.frame = 0
	$AttackSprite.texture = load(Global.attack_data[attack_type]['animation'])
	var pos = target.get_rect().position + target.get_rect().size / 2
	$AttackSprite.position = pos
	
	var tween = create_tween()
	tween.tween_property($AttackSprite, 'frame', 3, 0.6).from(0)
	tween.tween_property($AttackSprite, 'visible', false, 0)
	
